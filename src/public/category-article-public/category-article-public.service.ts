import { Injectable } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class CategoryArticlePublicService {
  constructor(private prisma: PrismaService) {}

  async category(
    categoryWhereUniqueInput: Prisma.CategoryArticleWhereUniqueInput
  ) {
    return this.prisma.categoryArticle.findUnique({
      where: categoryWhereUniqueInput,
    });
  }

  async categories(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.CategoryArticleWhereUniqueInput;
    where?: Prisma.CategoryArticleWhereInput;
    orderBy?: Prisma.CategoryArticleOrderByWithRelationInput;
  }) {
    const { skip, take, cursor, where, orderBy } = params;
    const datas = await this.prisma.categoryArticle.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
    const count = await this.prisma.categoryArticle.count({ where });

    return {
      datas,
      total: count,
    };
  }
}
