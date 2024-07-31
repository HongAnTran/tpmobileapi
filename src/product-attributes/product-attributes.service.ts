import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class ProductAttributesService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.ProductAttributesCreateInput) {
    return this.prisma.productAttributes.create({
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
    where?: Prisma.ProductAttributesWhereInput;
  }) {
    return this.prisma.productAttributes.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.productAttributes.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.ProductAttributesUpdateInput) {
    return this.prisma.productAttributes.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.productAttributes.delete({
      where: { id },
    });
  }
}
