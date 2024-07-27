import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';


@Injectable()
export class OptionsValueService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.OptionValueCreateInput) {
    return this.prisma.optionValue.create({
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
    where?: Prisma.OptionValueWhereInput;
  }) {
    return this.prisma.optionValue.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.optionValue.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.OptionValueUpdateInput) {
    return this.prisma.optionValue.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.optionValue.delete({
      where: { id },
    });
  }
}
