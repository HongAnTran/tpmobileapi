import { Controller, Get, Post, Body, Patch, Param, Delete, Query, ParseIntPipe } from '@nestjs/common';
import { OptionsValueService } from './options-value.service';
import { Prisma } from '@prisma/client';


@Controller('options-value')
export class OptionsValueController {
  constructor(private readonly optionsValueService: OptionsValueService) { }

  @Post()
  create(@Body() createOptionsValueDto: Prisma.OptionValueCreateInput) {
    return this.optionsValueService.create(createOptionsValueDto);
  }

  @Get()
  findAll(@Query('skip', ParseIntPipe) skip?: number, @Query('take', ParseIntPipe) take?: number,
    @Query('option_id', ParseIntPipe) optionId?: number,
    @Query('variant_id', ParseIntPipe) variantId?: number) {
    const where: Prisma.OptionValueWhereInput = {
      option_id: optionId ? optionId : undefined,
      variants: variantId ? { some: { id: variantId } } : undefined
    };

    return this.optionsValueService.findAll({
      skip: skip ?? undefined,
      take: take ?? undefined,
      where,
    });
  }



  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.optionsValueService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() updateOptionsValueDto: Prisma.OptionValueUpdateInput) {
    return this.optionsValueService.update(id, updateOptionsValueDto);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.optionsValueService.remove(id);
  }
}
