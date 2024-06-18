import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { OptionsService } from './options.service';
import { CreateOptionDto } from './dto/create-option.dto';
import { UpdateOptionDto } from './dto/update-option.dto';
import { Prisma } from '@prisma/client';

@Controller('options')
export class OptionsController {
  constructor(private readonly optionsService: OptionsService) {}

  @Post()
  create(@Body() createOptionDto: Prisma.OptionCreateInput) {
    return this.optionsService.create(createOptionDto);
  }

  @Get()
  findAll(@Query('skip') skip?: string, @Query('take') take?: string,@Query('productId') productId?: string) {
    const where: Prisma.OptionWhereInput= {};
    if (productId) {
      where.product_id = Number(productId);
    }
    return this.optionsService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
      where,
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.optionsService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateOptionDto: Prisma.OptionUpdateInput) {
    return this.optionsService.update(+id, updateOptionDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.optionsService.remove(+id);
  }
}
