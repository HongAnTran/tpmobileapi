import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { TagsService } from './tags.service';
import { Prisma } from '@prisma/client';

@Controller('tags')
export class TagsController {
  constructor(private readonly tagsService: TagsService) {}

  @Post()
  create(@Body() createTagDto: Prisma.TagsCreateInput) {
    return this.tagsService.create(createTagDto);
  }

  @Get()
  findAll(@Query('skip') skip?: string, @Query('take') take?: string,
    @Query('product_id') productId?: string) {
    const where: Prisma.TagsWhereInput = {
      products : productId ? {some : {id : +productId}} : undefined
    };

    return this.tagsService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
      where,
    });
  }


  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.tagsService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateTagDto: Prisma.TagsUpdateInput) {
    return this.tagsService.update(+id, updateTagDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.tagsService.remove(+id);
  }
}
