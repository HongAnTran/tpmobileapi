import { BadRequestException, Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma.service";
import { PaymentStatus, Prisma } from "@prisma/client";
import { OrderStatus } from "src/common/types/Order.type";

@Injectable()
export class RatingPublicService {
  constructor(private prisma: PrismaService) {}

  async create(createRatingDto: Prisma.RatingCreateInput) {
    const { customer, is_seeding, product } = createRatingDto;
    if (!is_seeding) {
      const customerId = customer.connect.id;
      const productId = product.connect.id;
      const customerData = await this.prisma.customer.findUnique({
        where: {
          id: customerId,
        },
        select: {
          orders: {
            where: {
              status: OrderStatus.SUCCESS,
            },
            select: {
              items: {
                select: {
                  product_id: true,
                },
              },
            },
          },
        },
      });

      if (!customerData) {
        throw new BadRequestException("Khách hàng không tồn tại.");
      }

      const hasPurchased = customerData.orders.some((order) =>
        order.items.some((item) => item.product_id === productId)
      );

      if (!hasPurchased) {
        throw new BadRequestException(
          "Bạn chỉ có thể đánh giá sản phẩm đã mua."
        );
      }
    }

    return this.prisma.rating.create({ data: createRatingDto });
  }
}
