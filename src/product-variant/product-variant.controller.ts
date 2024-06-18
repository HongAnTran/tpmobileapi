import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { ProductVariantService } from './product-variant.service';
import { CreateProductVariantDto } from './dto/create-product-variant.dto';
import { UpdateProductVariantDto } from './dto/update-product-variant.dto';
import { Prisma } from '@prisma/client';

@Controller('product-variant')
export class ProductVariantController {
  constructor(private readonly productVariantService: ProductVariantService) { }

  @Post()
  create(@Body() createProductVariantDto: Prisma.ProductVariantCreateInput) {
    return this.productVariantService.create(createProductVariantDto);
  }

  @Get()
  findAll(@Query('productId') productId?: string) {
    const where: Prisma.ProductVariantWhereInput = {};
    if (productId) {
      where.product_id = Number(productId);
    }
    return this.productVariantService.findAll({ where });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.productVariantService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateProductVariantDto: Prisma.ProductVariantUpdateInput) {
    return this.productVariantService.update(+id, updateProductVariantDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.productVariantService.remove(+id);
  }
}
