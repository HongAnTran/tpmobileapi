import {
  Controller,
  Get,
  Post,
  Body,
  Put,
  Param,
  Delete,
  Query,
  NotFoundException,
} from "@nestjs/common";
import { CategoryArticleService } from "./category-article.service";
import { CategoryArticle, Prisma } from "@prisma/client";
import { Public } from "src/common/decorator/public.decorator";

@Controller("category-article")
export class CategoryArticleController {
  constructor(
    private readonly categoryArticleService: CategoryArticleService
  ) {}

  @Public()
  @Get(":id")
  async findOne(@Param("id") id: string): Promise<CategoryArticle | null> {
    try {
      const idNumber = Number(id);
      let query: Prisma.CategoryArticleWhereUniqueInput = { slug: id };
      if (!isNaN(idNumber)) {
        query = { id: idNumber };
      }
      const category = await this.categoryArticleService.category(query);

      if (!category) {
        throw new NotFoundException(`category with ID ${id} not found`);
      }

      return category;
    } catch (error) {
      throw new NotFoundException(`category with ID ${id} not found`);
    }
  }

  @Public()
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
    return this.categoryArticleService.categories({
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

  @Post()
  async create(
    @Body() data: Prisma.CategoryArticleCreateInput
  ): Promise<CategoryArticle> {
    return this.categoryArticleService.createCategory(data);
  }

  @Put(":id")
  async update(
    @Param("id") id: string,
    @Body() data: Prisma.CategoryArticleUpdateInput
  ): Promise<CategoryArticle> {
    return this.categoryArticleService.updateCategory({
      where: { id: Number(id) },
      data,
    });
  }

  @Delete(":id")
  async remove(@Param("id") id: string): Promise<CategoryArticle> {
    return this.categoryArticleService.deleteCategory({ id: Number(id) });
  }
}
