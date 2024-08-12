import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { CategoryArticle, Prisma } from '@prisma/client';

@Injectable()
export class CategoryArticleService {
  constructor(private prisma: PrismaService) { }

  async category(categoryWhereUniqueInput: Prisma.CategoryArticleWhereUniqueInput): Promise<CategoryArticle | null> {
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
    const count = await this.prisma.categoryArticle.count({ where })

    return {
      datas,
      total  : count

    }
  }


  async createCategory(data: Prisma.CategoryArticleCreateInput): Promise<CategoryArticle> {
    return this.prisma.categoryArticle.create({
      data,
    });
  }

  async updateCategory(params: {
    where: Prisma.CategoryArticleWhereUniqueInput;
    data: Prisma.CategoryArticleUpdateInput;
  }): Promise<CategoryArticle> {
    const { where, data } = params;
    return this.prisma.categoryArticle.update({
      data,
      where,
    });
  }

  async deleteCategory(where: Prisma.CategoryArticleWhereUniqueInput): Promise<CategoryArticle> {
    return this.prisma.categoryArticle.delete({
      where,
    });
  }
}
