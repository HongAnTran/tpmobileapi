import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Injectable()
export class AppService {
  constructor(private prisma: PrismaService) {}

  // async moveData(oldCategoryId: number, newCategoryId: number): Promise<void> {
  //   // Lấy tất cả sản phẩm thuộc danh mục cũ
  //   const products = await this.prisma.product.findMany({
  //     where: {
  //       category_id: oldCategoryId,

  //     },
  //   });

  //   // Di chuyển sản phẩm sang danh mục mới
  //   for (const product of products) {
  //     await this.prisma.product.update({
  //       where: { id: product.id },
  //       data: {
  //         categoryId: newCategoryId,
  //       },
  //     });
  //   }

  //   console.log(`Moved ${products.length} products from category ${oldCategoryId} to category ${newCategoryId}.`);
  // }
}
