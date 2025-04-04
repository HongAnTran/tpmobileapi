import {
  BadRequestException,
  Injectable,
  NotFoundException,
  UnprocessableEntityException,
} from "@nestjs/common";
import { PaymentStatus, Prisma } from "@prisma/client";
import { OrderPickupStatus, OrderStatus } from "src/common/types/Order.type";
import { PrismaService } from "src/prisma.service";
import { MailService } from "src/mail/mail.service";
import { v4 as uuidv4 } from "uuid";
import { TelebotService } from "src/telebot/telebot.service";
import { TELE_CHATID } from "src/common/config/config";
import { formatCurrency } from "src/common/helper/curency";
@Injectable()
export class OrderPublicService {
  constructor(
    private prisma: PrismaService,
    private readonly mailService: MailService,
    private telebotService : TelebotService
  ) {}

  async createOrderReview(
    input: Pick<
      Prisma.OrderCreateInput,
      | "items"
      | "note"
      | "total_price"
      | "temp_price"
      | "discount"
      | "ship_price"
    >,
    customerId?: number
  ) {
    return this.prisma.$transaction(async (prisma) => {
      const token = uuidv4();
      const data: Prisma.OrderCreateInput = {
        ...input,
        token,
        code: token,
        customer: customerId ? { connect: { id: customerId } } : undefined,
        status: OrderStatus.DRAFT,
      };
      return this.prisma.order.create({
        data,
        include: { items: true },
      });
    });
  }

  async generateCode() {
    // 2. Lấy ngày hiện tại theo format `YYMMDD`
    const today = new Date();
    const day = today.getDate().toString().padStart(2, "0");
    const month = (today.getMonth() + 1).toString().padStart(2, "0");
    const year = today.getFullYear().toString().slice(-2); // '25'

    const dateCode = `${year}${month}${day}`;
    const presix = "DH";
    // 3. Tìm đơn hàng gần nhất trong ngày
    const latestOrder = await this.prisma.order.findFirst({
      where: { code: { startsWith: `${presix}${dateCode}` } },
      orderBy: { created_at: "desc" },
      select: { code: true },
    });
    // 4. Tăng số thứ tự
    let newIndex = "0001";
    if (latestOrder) {
      const lastNumber = parseInt(latestOrder.code.slice(-4), 10) + 1;
      newIndex = lastNumber.toString().padStart(4, "0");
    }

    const newCode = `${presix}${dateCode}${newIndex}`;

    return newCode;
  }

  async update(token: string, data: Prisma.OrderUpdateInput) {
    return this.prisma.order.update({
      where: { token },
      data,
      include: {
        customer: true,
        pickup: {
          include: {
            store: true,
          },
        },
        tags: true,
        coupons: true,
        items: {
          include: {
            product: true,
            variant: true,
          },
        },
        payment: true,
        shipping: true,
      },
    });
  }

  async checkOut(
    token: string,
    checkoutOrder: Prisma.OrderUpdateInput,
    customerId?: number
  ) {
    const res = this.prisma.$transaction(async (prisma) => {
      const order = await this.findOneByToken(token);
      if (!order) {
        throw new NotFoundException(`Không tìm thấy đơn hàng`);
      }
      if (order.status !== OrderStatus.DRAFT) {
        throw new BadRequestException(`Trạng thái đơn hàng không hợp lệ`);
      }
      if (order.items.length === 0) {
        throw new BadRequestException(`Vui lòng thêm sản phẩm vào giỏ hàng`);
      }
      if (order.items.some((item) => item.product.available === false)) {
        throw new UnprocessableEntityException(`Sản phẩm không khả dụng`);
      }

      if (order.customer_id && order.customer_id !== customerId) {
        throw new UnprocessableEntityException(`Lỗi xác thực`);
      }

      // verify total price

      const code = await this.generateCode();
      const data: Prisma.OrderUpdateInput = {
        status: OrderStatus.PENDING,
        code,
        customer: customerId ? { connect: { id: customerId } } : undefined,
        sold_at: new Date(),
        payment: {
          create: {
            ...checkoutOrder.payment.create,
            status: PaymentStatus.PENDING,
          },
        },
        pickup: checkoutOrder.pickup
          ? {
              create: {
                ...checkoutOrder.pickup.create,
                status: OrderPickupStatus.PENDING,
              },
            }
          : undefined,
        ...checkoutOrder,
      };
      const res = await this.update(token, data);
      return res;
    });
    const data = await res;
    await this.sendMail(data);
    return data;
  }

  

  async sendMail(
    res: Prisma.OrderGetPayload<{
      include: {
        items: {
          include:{
            product: true;
            variant: true;
          }
        };
        customer: true;
        payment: true;
        shipping: true;
        pickup: {
          include: {
            store: true;
          };
        };
      };
    }>
  ) {
    try {
      const email =
        res.shipping?.email || res.pickup?.email || res.customer?.email;
      if (email) {
        await this.mailService.sendMail({
          subject: "Xác Nhận Đơn Hàng - TP Mobile Store",
          to: email,
          template: "orderConfirmation",
          context: res,
        });
      }

      let message = ""
      if(res.pickup){
        message = `Đơn hàng ${res.code} Vừa được tạo.
        Thông tin đơn hàng:
        - Tên khách hàng: ${res.pickup.fullname}
        - SDT: ${res.pickup.phone}
        - Email: ${res.pickup.email}
        - SP: ${res.items.map((item) => {
          return `${item.product.title}-${item.variant.title} - ${item.quantity} - ${formatCurrency(item.line_price)}đ`;
        })}
        - Tổng : ${formatCurrency(res.total_price)}
        - Note: ${res.note}
        - Địa chỉ lấy hàng: ${res.pickup.store.name}
        `
      }

      if(res.shipping){
        message = `Đơn hàng ${res.code} Vừa được tạo.
        Thông tin đơn hàng:
        - Ngày bán: ${res.sold_at.toLocaleDateString('vi-VN')}
        - Tên khách hàng: ${res.shipping.fullname}
        - SDT: ${res.shipping.phone}
        - Email: ${res.shipping.email}
        - Địa chỉ giao hàng: ${res.shipping.address_full}
        - SP: ${res.items.map((item) => {
          return `${item.product.title}-${item.variant.title} - ${item.quantity} - ${formatCurrency(item.line_price)}đ`;
        })}
        - Tổng : ${formatCurrency(res.total_price)}
        - Note: ${res.note}
        `
      }

      await this.telebotService.queueMessage(TELE_CHATID , message);
    } catch (error) {
      console.error("Error sending email:", error);
    }
  }
  async findOneByToken(token: string) {
    try {
      const order = await this.prisma.order.findUnique({
        where: { token, available: true },
        include: {
          items: {
            include: {
              product: {
                select: {
                  title: true,
                  id: true,
                  available: true,
                  category: true,
                  images: true,
                  price: true,
                  status: true,
                  slug: true,
                  thumnail_url: true,
                  compare_at_price: true,
                  updated_at: true,
                },
              },
              variant: {
                select: {
                  title: true,
                  id: true,
                  attribute_values: true,
                  available: true,
                  image: true,
                  inventory_quantity: true,
                  sku: true,
                  price: true,
                  price_origin: true,
                },
              },
            },
          },
          customer: true,
          payment: true,
          shipping: true,
          pickup: {
            include: {
              store: true,
            },
          },
        },
      });
      if (!order) {
        throw new NotFoundException(`order with token ${token} not found`);
      }

      return order;
    } catch (error) {
      throw new NotFoundException(`order with token ${token} not found`);
    }
  }

  async findOneByCode(code: string) {
    try {
      const order = await this.prisma.order.findUnique({
        where: { code, available: true },
        include: {
          items: {
            include: {
              product: {
                select: {
                  title: true,
                  id: true,
                  available: true,
                  category: true,
                  images: true,
                  price: true,
                  status: true,
                  slug: true,
                  thumnail_url: true,
                  compare_at_price: true,
                  updated_at: true,
                },
              },
              variant: {
                select: {
                  title: true,
                  id: true,
                  attribute_values: true,
                  available: true,
                  image: true,
                  inventory_quantity: true,
                  sku: true,
                  price: true,
                  price_origin: true,
                },
              },
            },
          },
          customer: true,
          payment: true,
          shipping: true,
          coupons :true,
          pickup: {
            include: {
              store: true,
            },
          },
        },
      });
      if (!order) {
        throw new NotFoundException(`Đơn hàng không tồn tại`);
      }

      return order;
    } catch (error) {
      throw new NotFoundException(`Đơn hàng không tồn tại`);
    }
  }

  async cancelOrder(id : number , code : string,body: {
    cancelReason: string
    cancelReasonCode: number
  }){
    const order = await this.prisma.order.findUnique({
      where: { code },
      include:{
        customer : true,
      }
    });
    if (!order || !order.available) {
      throw new NotFoundException(`Đơn hàng không tồn tại`);
    }
    if (order.status !== OrderStatus.PENDING && order.status !== OrderStatus.PROCESSING) {
      throw new BadRequestException(`Trạng thái đơn hàng không hợp lệ`);
    }

    if(order.customer.id !== id){
      throw new UnprocessableEntityException(`Lỗi xác thực`);
    }
      return this.prisma.order.update({
        where: { id },
        data : {
          status : OrderStatus.CANCELLED,
          note_private : `Hủy vì ${body.cancelReason} ${body.cancelReasonCode}`,
        }
      })
  }
}
