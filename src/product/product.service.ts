import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Product, Prisma, ProductVariant, Option } from '@prisma/client';
@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) { }

  // Tìm một sản phẩm theo id duy nhất
  async product(
    productWhereUniqueInput: Prisma.ProductWhereUniqueInput,
    include?: Prisma.ProductInclude

  ): Promise<Product | null> {
    return this.prisma.product.findUnique({
      where: productWhereUniqueInput,
      include : include
    });
  }
  // Lấy danh sách sản phẩm với các tùy chọn như phân trang, lọc, sắp xếp
  async products(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ProductWhereUniqueInput;
    where?: Prisma.ProductWhereInput;
    orderBy?: Prisma.ProductOrderByWithRelationInput;
    include?: Prisma.ProductInclude
  }): Promise<{ products: Product[], total: number }> {
    const { skip, take, cursor, where, orderBy, include } = params;
    const products = await this.prisma.product.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
      include
    });
    const total = await this.prisma.product.count({
      where
    });

    return {
      products,
      total
    };
  }
  // // Lấy danh sách sản phẩm variant
  // async productsVariant(productId: number): Promise<ProductVariant[]> {

  //   return this.prisma.productVariant.findMany({
  //     where: { product_id: productId }
  //   });
  // }
  // // Lấy danh sách soption
  // async productsOption(productId: number): Promise<Option[]> {
  //   return this.prisma.option.findMany({
  //     where: { product_id: productId }
  //   });
  // }

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
