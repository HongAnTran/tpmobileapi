import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Product, Prisma } from '@prisma/client';
@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) { }

  // Tìm một sản phẩm theo id duy nhất
  async product(id: string): Promise<Product | null> {
    try {
      const idNumber = Number(id)
      let query: Prisma.ProductWhereUniqueInput = { slug: id }
      if (!isNaN(idNumber)) {
        query = { id: idNumber }
      }
      const product = await this.prisma.product.findUnique({
        where: query,
        include: {
          category: true,
          options: true,
          specifications: true,
          variants: true
        },

      });
      if (!product) {
        throw new NotFoundException(`Product with ID ${id} not found`);
      }
      return product;
    } catch (error) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }
  }

  // Lấy danh sách sản phẩm với các tùy chọn như phân trang, lọc, sắp xếp
  async products(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ProductWhereUniqueInput;
    where?: Prisma.ProductWhereInput;
    orderBy?: Prisma.ProductOrderByWithRelationInput;
    select?: Prisma.ProductSelect
  }) {
    const { skip, take, cursor, where, orderBy,  select } = params;

    const products = await this.prisma.product.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
      select
    });

    const total = await this.prisma.product.count({
      where
    });

    return {
      products,
      total
    };
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
      include: {
        options: true,
        variants: true,
      }
    });
  }
}
