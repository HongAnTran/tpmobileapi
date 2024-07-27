import { Controller, Get, Post, Body, Patch, Param, Delete, ParseIntPipe, Query } from '@nestjs/common';
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
  findAll(@Query('skip', ParseIntPipe) skip?: number, @Query('take', ParseIntPipe) take?: number,
    @Query('product_id', ParseIntPipe) productId?: number) {
    const where: Prisma.TagsWhereInput = {
      products : productId ? {some : {id : productId}} : undefined
    };

    return this.tagsService.findAll({
      skip: skip ?? undefined,
      take: take ?? undefined,
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
