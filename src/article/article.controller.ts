import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from "@nestjs/common";
import { ArticleService } from "./article.service";
import { Prisma } from "@prisma/client";
import { Public } from "src/common/decorator/public.decorator";

@Controller("articles")
export class ArticleController {
  constructor(private readonly articleService: ArticleService) {}

  @Post()
  create(@Body() data: Prisma.ArticleCreateInput) {
    return this.articleService.create(data);
  }

  @Public()
  @Get()
  findAll(
    @Query("page") page?: string,
    @Query("limit") limit?: string,
    @Query("category_id") category_id?: string,
    @Query("keyword") keyword?: string,
    @Query("status") status?: string,
    @Query("sort_by") sortBy?: string,
    @Query("sort_type") sortType?: Prisma.SortOrder
  ) {
    const take = limit ? (Number(limit) <= 50 ? Number(limit) : 50) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;
    const where: Prisma.ArticleWhereInput = {
      category_id: category_id ? Number(category_id) : undefined,
      ...(keyword && { title: { contains: keyword, mode: "insensitive" } }),
      status: status ? Number(status) : undefined,
    };

    let orderBy: Prisma.ArticleOrderByWithRelationInput = {
      [sortBy]: sortType,
    };

    const params = {
      skip: skip,
      take: take,
      orderBy,
      ...where,
    };
    return this.articleService.findAll({
      ...params,
      select: {
        id: true,
        title: true,
        category: true,
        author_id: true,
        author: true,
        category_id: true,
        description: true,
        slug: true,
        thumnal_url: true,
        created_at: true,
        updated_at: true,
        status: true,
      },
    });
  }

  @Public()
  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.articleService.findOne(id);
  }
  @Patch(":id")
  update(@Param("id") id: string, @Body() data: Prisma.ArticleUpdateInput) {
    return this.articleService.update({
      where: { id: parseInt(id, 10) },
      data: data,
    });
  }
  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.articleService.remove({ id: parseInt(id, 10) });
  }
}
