import {
  Controller,
  Get,
  NotFoundException,
  Param,
  Query,
} from "@nestjs/common";
import { CategoryArticlePublicService } from "./category-article-public.service";
import { Prisma } from "@prisma/client";

@Controller("public/category-articles")
export class CategoryArticlePublicController {
  constructor(
    private readonly categoryArticlePublicService: CategoryArticlePublicService
  ) {}
  @Get(":id")
  async findOne(@Param("id") id: string) {
    try {
      const idNumber = Number(id);
      let query: Prisma.CategoryArticleWhereUniqueInput = { slug: id };
      if (!isNaN(idNumber)) {
        query = { id: idNumber };
      }
      const category = await this.categoryArticlePublicService.category(query);

      if (!category) {
        throw new NotFoundException(`category with ID ${id} not found`);
      }

      return category;
    } catch (error) {
      throw new NotFoundException(`category with ID ${id} not found`);
    }
  }

  @Get()
  async findAll(
    @Query()
    query: {
      skip?: string;
      take?: string;
      orderBy?: string;
      orderType?: string;
      published?: number;
    }
  ) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    const published =
      typeof query.published === "undefined"
        ? undefined
        : Boolean(+query.published);
    return this.categoryArticlePublicService.categories({
      skip: skip,
      take: take,
      where: {
        published: published,
      },
      orderBy: {
        [query.orderBy]: query.orderType,
      },
    });
  }
}
