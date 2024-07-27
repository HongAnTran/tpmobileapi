import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';


@Injectable()
export class ProductImageService {
  constructor(private prisma: PrismaService) { }

  async create(data: Prisma.ProductImageCreateInput) {
    return this.prisma.productImage.create({
      data,
    });
  }

  async findAll({
    skip,
    take,
    where,
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.ProductImageWhereInput;
  }) {
    return this.prisma.productImage.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.productImage.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.ProductImageUpdateInput) {
    return this.prisma.productImage.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.productImage.delete({
      where: { id },
    });
  }
}
