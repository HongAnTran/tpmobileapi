import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class ArticlePublicService {
  constructor(private prisma: PrismaService) {}

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ArticleWhereUniqueInput;
    where?: Prisma.ArticleWhereInput;
    orderBy?: Prisma.ArticleOrderByWithRelationInput;
    select?: Prisma.ArticleSelect;
  }) {
    const { skip, take, cursor, where, orderBy, select } = params;
    const datas = await this.prisma.article.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
      select,
    });

    const total = await this.prisma.article.count({
      where,
    });

    return {
      datas,
      total,
    };
  }

  async findOne(id: string) {
    try {
      const idNumber = Number(id);
      let query: Prisma.ArticleWhereUniqueInput = { slug: id };
      if (!isNaN(idNumber)) {
        query = { id: idNumber };
      }
      const article = await this.prisma.article.findUnique({
        where: query,
        include: {
          category: true,
          author: true,
        },
      });
      if (!article) {
        throw new NotFoundException(`Article with ID ${id} not found`);
      }
      return article;
    } catch (error) {
      throw new NotFoundException(`Article with ID ${id} not found`);
    }
  }
}
