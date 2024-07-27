import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
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
  findAll(
    @Query('skip') skip?: string,
    @Query('take') take?: string,
    @Query('option_id') optionId?: string,
    @Query('variant_id') variantId?: string) {
    const where: Prisma.OptionValueWhereInput = {
      option_id: optionId ? +optionId : undefined,
      variants: variantId ? { some: { id: +variantId } } : undefined
    };

    return this.optionsValueService.findAll({
      skip: Number(skip) ?? undefined,
      take: Number(take) ?? undefined,
      where,
    });
  }



  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.optionsValueService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateOptionsValueDto: Prisma.OptionValueUpdateInput) {
    return this.optionsValueService.update(+id, updateOptionsValueDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.optionsValueService.remove(+id);
  }
}
