import { PrismaService } from './../prisma.service';
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';

@Injectable()
export class SpecificationsService {

  constructor(private prisma: PrismaService) { }

  async createType(data: Prisma.SpecificationsTypeCreateInput) {
    return this.prisma.specificationsType.create({
      data,
    });
  }
  async createGroup(data: Prisma.SpecificationsGroupCreateInput) {
    return this.prisma.specificationsGroup.create({
      data,
    });
  }
  async findAllType() {
    return this.prisma.specificationsType.findMany();
  }
  async findAllGroup({
    where
  }: {
    where?: Prisma.SpecificationsGroupWhereInput

  }) {
    return this.prisma.specificationsGroup.findMany({ where });
  }

  async create(data: Prisma.ProductSpecificationsCreateInput) {
    return this.prisma.productSpecifications.create({
      data,
    });
  }

  async findAll({
    skip,
    take,
    where
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.ProductSpecificationsWhereInput

  }) {
    return this.prisma.productSpecifications.findMany({
      where,
      skip,
      take
    });
  }

  async findOne(id: number) {
    return this.prisma.productSpecifications.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.ProductSpecificationsUpdateInput) {
    return this.prisma.productSpecifications.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.productSpecifications.delete({
      where: { id },
    });
  }

  async removeType(id: number) {
    return this.prisma.specificationsType.delete({
      where: { id },
    });
  }

  async removeGroup(id: number) {
    return this.prisma.specificationsGroup.delete({
      where: { id },
    });
  }
}
