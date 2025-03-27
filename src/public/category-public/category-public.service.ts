import { Injectable } from "@nestjs/common";
import { Category, Prisma } from "@prisma/client";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class CategoryPublicService {
  constructor(private prisma: PrismaService) {}

  async category(categoryWhereUniqueInput: Prisma.CategoryWhereUniqueInput) {
    return this.prisma.category.findUnique({
      where: categoryWhereUniqueInput,
    });
  }

  async categories(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.CategoryWhereUniqueInput;
    where?: Prisma.CategoryWhereInput;
    orderBy?: Prisma.CategoryOrderByWithRelationInput;
  }) {
    const { skip, take, cursor, where, orderBy } = params;
    const datas = await this.prisma.category.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
    const count = await this.prisma.category.count({ where });
    return {
      datas,
      total: count,
    };
  }
}
