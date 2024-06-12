import { PrismaService } from './../prisma.service';
import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';

@Injectable()
export class SpecificationsService {

  constructor(private prisma: PrismaService) {}

  async createType(data: Prisma.SpecificationsTypeCreateInput) {
    return this.prisma.specificationsType.create({
      data,
    });
  }
  async findAllType() {
    return this.prisma.specificationsType.findMany();
  }

  async create(data: Prisma.ProductSpecificationsCreateInput) {
    return this.prisma.productSpecifications.create({
      data,
    });
  }

  async findAll() {
    return this.prisma.productSpecifications.findMany();
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
}
