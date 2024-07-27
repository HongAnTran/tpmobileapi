import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class AttributeValuesService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.AttributeValuesCreateInput) {
    return this.prisma.attributeValues.create({
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
    where?: Prisma.AttributeValuesWhereInput;
  }) {
    return this.prisma.attributeValues.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.attributeValues.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.AttributeValuesUpdateInput) {
    return this.prisma.attributeValues.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.attributeValues.delete({
      where: { id },
    });
  }
}
