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

    const res = await this.prisma.rating.create({ data: createRatingDto });
    await this.updateProductRating(product.connect.id);
    return res
  }

  async findAll(product_id: number , query: { page?: string; limit?: string }) {
    const MAX_LIMIT = 50;
    const take = query.limit
      ? Number(query.limit) <= MAX_LIMIT
        ? Number(query.limit)
        : MAX_LIMIT 
      : MAX_LIMIT;
    const skip = query.page ? (Number(query.page) - 1) * take : undefined;
    const ratings = await this.prisma.rating.findMany({
      take: take,
      skip: skip,
      where: {
        product_id,
      },
      orderBy: {
        created_at: "desc",
      },
      include: {
        tags:{
          select:{
            id:true,
            title:true,
            code:true,

          }
        },
        customer: {
          select: {
            id: true,
            avatar: true,
            full_name: true,
            email: true,
          },
        },
      },
    });

    const total = await this.prisma.rating.count({
      where: {
        product_id,
      },
    });
    return {
      datas: ratings,
      total: total,
    }
  }
    

  async updateProductRating(productId: number) {
    // Lấy tất cả ratings
    const allRatings = await this.prisma.rating.findMany({
      where: { product_id: productId },
      select: { rate: true, is_seeding: true },
    });
  
    if (allRatings.length === 0) {
      await this.prisma.product.update({
        where: { id: productId },
        data: { rating: null },
      });
      return;
    }
    // Tính toán rating tổng
    const count = allRatings.length;
    const sum = allRatings.reduce((acc, r) => acc + r.rate, 0);
    const average = count > 0 ? parseFloat((sum / count).toFixed(1)) : 0
    // Lọc bỏ rating seeding
    const realRatings = allRatings.filter(r => !r.is_seeding);
    const countReal = realRatings.length;
    const sumReal = realRatings.reduce((acc, r) => acc + r.rate, 0);
    const averageReal = countReal > 0 ? parseFloat((sumReal / countReal).toFixed(1)) : 0;
    await this.prisma.product.update({
      where: { id: productId },

      data: { 
        rating_count: count,
        average_rating: average,
        rating: { 
          average : averageReal, count : countReal ,
         },
      
      },
    });
  }
  
}
