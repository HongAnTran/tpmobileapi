import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class AttributesService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.AttributesCreateInput) {
    return this.prisma.attributes.create({
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
    where?: Prisma.AttributesWhereInput;
  }) {
    return this.prisma.attributes.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.attributes.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.AttributesUpdateInput) {
    return this.prisma.attributes.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.attributes.delete({
      where: { id },
    });
  }
}
