import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { ArticleService } from './article.service';
import { UpdateArticleDto } from './dto/update-article.dto';
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
    @Query('cursor') cursor?: string,
    @Query('where') where?: Prisma.ArticleWhereInput,
    @Query('orderBy') orderBy?: Prisma.ArticleOrderByWithRelationInput,
  ) {
    const params = {
      skip: skip ? parseInt(skip, 10) : undefined,
      take: take ? parseInt(take, 10) : undefined,
      cursor: cursor ? { id: parseInt(cursor, 10) } : undefined,
      where,
      orderBy,
    };
    return this.articleService.findAll(params);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.articleService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body()  data: Prisma.ArticleUpdateInput) {
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
