import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
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
  findAll() {
    return this.specificationsService.findAll();
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
