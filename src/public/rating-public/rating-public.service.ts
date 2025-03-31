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
    await this.prisma.product.update({
      where: {
        id: createRatingDto.product.connect.id,
      },
      data: {
        rating:{
          
        }
      },
    });
    await this.updateProductRating(product.connect.id);
    return res
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
    const average = parseFloat((sum / count).toFixed(1));
  
    const distribution = allRatings.reduce((acc, r) => {
      acc[r.rate] = (acc[r.rate] || 0) + 1;
      return acc;
    }, {} as Record<number, number>);
  
    // Lọc bỏ rating seeding
    const realRatings = allRatings.filter(r => !r.is_seeding);
    const countReal = realRatings.length;
    const sumReal = realRatings.reduce((acc, r) => acc + r.rate, 0);
    const averageReal = countReal > 0 ? parseFloat((sumReal / countReal).toFixed(1)) : null;
  
    const distributionReal = realRatings.reduce((acc, r) => {
      acc[r.rate] = (acc[r.rate] || 0) + 1;
      return acc;
    }, {} as Record<number, number>);
  
    // Cập nhật Product với cả rating tổng và rating thực
    await this.prisma.product.update({
      where: { id: productId },
      data: { 
        rating: { 
          average, count, distribution,
          real: countReal > 0 ? { average: averageReal, count: countReal, distribution: distributionReal } : null
         },
      
      },
    });
  }
  
}
