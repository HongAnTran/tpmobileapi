import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { ProductImageService } from './product-image.service';
import { Prisma } from '@prisma/client';

@Controller('product-image')
export class ProductImageController {
  constructor(private readonly productImageService: ProductImageService) { }

  @Post()
  create(@Body() createProductImageDto: Prisma.ProductImageCreateInput) {
    return this.productImageService.create(createProductImageDto);
  }

  @Post("/updates")
  updates() {
    return this.productImageService.updateProductImages();
  }

  @Get()
  findAll(
    @Query('skip') skip?: string,
    @Query('take') take?: string,
    @Query('product_id') product_id?: string,
  ) {

    const where: Prisma.ProductImageWhereInput = {
      product_id: product_id ? +product_id : undefined,
    }

    return this.productImageService.findAll({
      skip: Number(skip) ? Number(skip) : undefined,
      take: Number(take) ? Number(take) : undefined,
      where,
    });
  }



  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.productImageService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateProductImageDto: Prisma.ProductImageUpdateInput) {
    return this.productImageService.update(+id, updateProductImageDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.productImageService.remove(+id);
  }
}
