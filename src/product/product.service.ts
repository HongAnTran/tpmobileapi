import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Product, Prisma } from '@prisma/client';
@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) { }

  // Tìm một sản phẩm theo id duy nhất
  async product(
    productWhereUniqueInput: Prisma.ProductWhereUniqueInput,
  ): Promise<Product | null> {
    return this.prisma.product.findUnique({
      where: productWhereUniqueInput,
    });
  }
  // Tìm một sản phẩm theo slug
   // Tìm một sản phẩm theo slug
   async findBySlug(slug: string): Promise<Product | null> {
    return this.prisma.product.findUnique({
      where: {  slug : slug } as Prisma.ProductWhereUniqueInput, // Ép kiểu về ProductWhereUniqueInput
    });
  }

  // Lấy danh sách sản phẩm với các tùy chọn như phân trang, lọc, sắp xếp
  async products(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ProductWhereUniqueInput;
    where?: Prisma.ProductWhereInput;
    orderBy?: Prisma.ProductOrderByWithRelationInput;
  }): Promise<Product[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.product.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  // Tạo mới một sản phẩm
  async createProduct(data: Prisma.ProductCreateInput): Promise<Product> {
    return this.prisma.product.create({
      data,
    });
  }

  // Cập nhật thông tin một sản phẩm
  async updateProduct(params: {
    where: Prisma.ProductWhereUniqueInput;
    data: Prisma.ProductUpdateInput;
  }): Promise<Product> {
    const { where, data } = params;
    return this.prisma.product.update({
      data,
      where,
    });
  }

  // Xóa một sản phẩm
  async deleteProduct(where: Prisma.ProductWhereUniqueInput): Promise<Product> {
    return this.prisma.product.delete({
      where,
    });
  }
}
