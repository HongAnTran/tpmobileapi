import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { SpecificationsService } from './specifications.service';
import { Prisma } from '@prisma/client';

@Controller('specifications')
export class SpecificationsController {
  constructor(private readonly specificationsService: SpecificationsService) { }

  @Post('types')
  createType(@Body() data: Prisma.SpecificationsTypeCreateInput) {
    return this.specificationsService.createType(data);
  }

  @Post('groups')
  createGroup(@Body() data: Prisma.SpecificationsGroupCreateInput) {
    return this.specificationsService.createGroup(data);
  }

  @Get('types')
  findAllType() {
    return this.specificationsService.findAllType();
  }
  @Get('groups')
  findAllGroup(@Query() query: {
    type_id?: string
  }) {
    return this.specificationsService.findAllGroup({
      where: Number(query.type_id) ? { type_id: Number(query.type_id) } : undefined
    });
  }

  @Post()
  create(@Body() data: Prisma.ProductSpecificationsCreateInput) {
    return this.specificationsService.create(data);
  }

  @Get()
  findAll(@Query() query: {
    skip?: string;
    take?: string;
    group_id?: string
    product_id?: string
    keyword?: string
  }) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    const where: Prisma.ProductSpecificationsWhereInput = query.group_id ? {
      group_id: query.group_id ? parseInt(query.group_id, 10) : undefined,
      product: query.product_id ? { some: { id: parseInt(query.group_id, 10) } } : undefined,
      value: query.keyword ? { contains: query.keyword, mode: "insensitive" } : undefined
    } : {}

    return this.specificationsService.findAll({
      where,
      skip,
      take
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.specificationsService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() data: Prisma.ProductSpecificationsUpdateInput) {
    return this.specificationsService.update(+id, data);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.specificationsService.remove(+id);
  }
  @Delete('types/:id')
  removeType(@Param('id') id: string) {
    return this.specificationsService.removeType(+id);
  }
  @Delete('groups/:id')
  removeGroup(@Param('id') id: string) {
    return this.specificationsService.removeGroup(+id);
  }
}
