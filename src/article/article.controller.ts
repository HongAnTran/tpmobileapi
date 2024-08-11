import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { ArticleService } from './article.service';
import { Prisma } from '@prisma/client';

@Controller('articles')
export class ArticleController {
  constructor(private readonly articleService: ArticleService) { }

  @Post()
  create(@Body() data: Prisma.ArticleCreateInput) {
    return this.articleService.create(data);
  }

  @Get()
  findAll(
    @Query('skip') skip?: string,
    @Query('take') take?: string,
    @Query('category_id') category_id?: string,
    @Query('keyword') keyword?: string,
    @Query('status') status?: string,
    @Query('orderBy') orderBy?: Prisma.ArticleOrderByWithRelationInput,

  ) {

    const where: Prisma.ArticleWhereInput = {
      category_id: category_id ? Number(category_id) : undefined,
      ...(keyword && { title: { contains: keyword, mode: "insensitive" } }),
      status: status ? Number(status) : undefined
    }
    const params = {
      skip: skip ? parseInt(skip, 10) : undefined,
      take: take ? parseInt(take, 10) : undefined,
      orderBy,
      ...where
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
        status: true
      }
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.articleService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() data: Prisma.ArticleUpdateInput) {
    return this.articleService.update({
      where: { id: parseInt(id, 10) },
      data: data,
    });
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.articleService.remove({ id: parseInt(id, 10) });
  }
}
