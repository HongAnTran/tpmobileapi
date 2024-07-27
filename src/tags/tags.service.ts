import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class TagsService {
  constructor(private prisma: PrismaService) {}

  async create(data: Prisma.TagsCreateInput) {
    return this.prisma.tags.create({
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
    where?: Prisma.TagsWhereInput;
  }) {
    return this.prisma.tags.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.tags.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.TagsUpdateInput) {
    return this.prisma.tags.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.tags.delete({
      where: { id },
    });
  }
}
