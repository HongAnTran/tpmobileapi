import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class SpecificationsPublicService {
  constructor(private prisma: PrismaService) {}

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
}
