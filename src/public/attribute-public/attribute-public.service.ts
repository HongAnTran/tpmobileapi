import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class AttributePublicService {

  constructor(private prisma: PrismaService) {}

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
  async findAllValues({
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

}
