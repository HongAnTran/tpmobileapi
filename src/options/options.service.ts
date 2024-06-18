import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';
import { CreateOptionDto } from './dto/create-option.dto';
import { UpdateOptionDto } from './dto/update-option.dto';

@Injectable()
export class OptionsService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.OptionCreateInput) {
    return this.prisma.option.create({
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
    where?: Prisma.OptionWhereInput;
  }) {
    return this.prisma.option.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.option.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.OptionUpdateInput) {
    return this.prisma.option.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.option.delete({
      where: { id },
    });
  }
}
