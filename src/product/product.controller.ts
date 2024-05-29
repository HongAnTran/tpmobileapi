import { Controller, Get, Post, Body, Patch, Param, Delete, Query, NotFoundException } from '@nestjs/common';
import { ProductService } from './product.service';
import { Prisma, Product } from '@prisma/client';

@Controller('products')
export class ProductController {
  constructor(private readonly productService: ProductService) { }


  @Post()
  async create(@Body() createProductDto: Prisma.ProductCreateInput) {
    return this.productService.createProduct(createProductDto)
  }

  @Get()
  findAll(@Query() query: {
    skip?: string;
    take?: string;
    cursor?: Prisma.ProductWhereUniqueInput;
    where?: Prisma.ProductWhereInput;
    orderBy?: Prisma.ProductOrderByWithRelationInput;
  }) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    return this.productService.products({
      ...query,
      skip,
      take,
      include: {
        variants: true,
        images: true,
        category: true,
        options: true,
        specifications: true
      }
    });
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    try {
      const idNumber = Number(id)
      let query: Prisma.ProductWhereUniqueInput = { slug: id }
      if (!isNaN(idNumber)) {
        query = { id: idNumber }
      }
      const product = await this.productService.product(query, {
        category: true,
        images: true,
        options: true,
        specifications: true,
        variants: true
      });
      if (!product) {
        throw new NotFoundException(`Product with ID ${id} not found`);
      }
      return product;
    } catch (error) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateProductDto: Prisma.ProductUpdateInput,
  ) {
    return this.productService.updateProduct({
      where: { id: Number(id) },
      data: updateProductDto,
    });
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.productService.deleteProduct({ id: Number(id) });
  }
}
