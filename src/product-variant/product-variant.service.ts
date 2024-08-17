import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';
import { CreateProductVariantDto } from './dto/create-product-variant.dto';
import { UpdateProductVariantDto } from './dto/update-product-variant.dto';

@Injectable()
export class ProductVariantService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.ProductVariantCreateInput) {
    return this.prisma.productVariant.create({
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
    where?: Prisma.ProductVariantWhereInput;
  }) {
    return this.prisma.productVariant.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.productVariant.findUnique({
      where: { id },
      include  :{
        attribute_values : true,
        image : true
      }
    });
  }

  async update(id: number, data: Prisma.ProductVariantUpdateInput) {
    return this.prisma.productVariant.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.productVariant.delete({
      where: { id },
    });
  }


  async removeMany(ids: number[]) {
    return this.prisma.productVariant.deleteMany({
      where: {
        id: {
          in: ids,
        },
      },
    });
  }
  
}
