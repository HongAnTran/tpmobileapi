import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateArticleDto } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class ArticleService {
  constructor(private prisma: PrismaService) { }
  async create(data: Prisma.ArticleCreateInput) {
    return this.prisma.article.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ArticleWhereUniqueInput;
    where?: Prisma.ArticleWhereInput;
    orderBy?: Prisma.ArticleOrderByWithRelationInput;
    select?: Prisma.ArticleSelect;

  }) {
    const { skip, take, cursor, where, orderBy, select } = params;
    const articles = await this.prisma.article.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,

      select
    });

    const total = await this.prisma.article.count({
      where,
    });

    return {
      articles,
      total,
    };
  }

  async findOne(id: string) {
    try {
      const idNumber = Number(id)
      let query: Prisma.ArticleWhereUniqueInput = { slug: id }
      if (!isNaN(idNumber)) {
        query = { id: idNumber }
      }
      const article = await this.prisma.article.findUnique({
        where: query,
        include: {
          category: true,
          author: true,
        }
      });
      if (!article) {
        throw new NotFoundException(`Article with ID ${id} not found`);
      }
      return article;
    } catch (error) {
      throw new NotFoundException(`Article with ID ${id} not found`);
    }
  }

  async update(params: {
    where: Prisma.ArticleWhereUniqueInput;
    data: Prisma.ArticleUpdateInput;
  }) {
    const { where, data } = params;
    return this.prisma.article.update({
      data,
      where,
    });
  }

  async remove(where: Prisma.ArticleWhereUniqueInput) {
    return this.prisma.article.delete({
      where,
    });
  }
}
