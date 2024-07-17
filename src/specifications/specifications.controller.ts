import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { SpecificationsService } from './specifications.service';
import { Prisma } from '@prisma/client';

@Controller('specifications')
export class SpecificationsController {
  constructor(private readonly specificationsService: SpecificationsService) { }

  @Post('type')
  createType(@Body() data: Prisma.SpecificationsTypeCreateInput) {
    return this.specificationsService.createType(data);
  }

  @Get('types')
  findAllType() {
    return this.specificationsService.findAllType();
  }

  @Post()
  create(@Body() data: Prisma.ProductSpecificationsCreateInput) {
    return this.specificationsService.create(data);
  }

  @Get()
  findAll(@Query() query: {
    skip?: string;
    take?: string;
    type_id?: string
    keyword?: string
  }) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    const where: Prisma.ProductSpecificationsWhereInput = query.type_id ? {
      type_id: query.type_id ? parseInt(query.type_id, 10) : undefined,
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
}
