import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { AttributeValuesService } from './attributes-value.service';
import { Prisma } from '@prisma/client';

@Controller('attribute-values')
export class AttributeValuesController {
  constructor(private readonly attributeValuesService: AttributeValuesService) { }

  @Post()
  create(@Body() createAttributeValuesDto: Prisma.AttributeValuesCreateInput) {
    return this.attributeValuesService.create(createAttributeValuesDto);
  }

  @Get()
  findAll(@Query('skip') skip?: string, @Query('take') take?: string, @Query('attribute_id') attribute_id?: string) {
    const where: Prisma.AttributeValuesWhereInput = {
      attribute_id: +attribute_id ? +attribute_id : undefined
    }
    return this.attributeValuesService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
      where
    });
  }
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.attributeValuesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAttributeValuesDto: Prisma.AttributeValuesUpdateInput) {
    return this.attributeValuesService.update(+id, updateAttributeValuesDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.attributeValuesService.remove(+id);
  }
}
