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
    status?: string
    category_id?: Product["category_id"]
    ids?: string
    include?: string,
    keyword?: string
  }) {
    const { category_id, ids, include, keyword, status } = query

    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;

    const productIds = ids ? ids.split(",").map(id => Number(id)) : []
    const includeParams = include ? include.split(",") : [
      "category",
      // "options",
      // "specifications",
      // "variants"
    ]
    const where: Prisma.ProductWhereInput = {
      status: status ? Number(status) : undefined,
      category_id: query.category_id ? Number(category_id) : undefined,
      id: productIds.length ? { in: productIds } : undefined,
      ...(keyword && { title: { contains: keyword } }),
    };


    let includeQuery = includeParams.reduce((pre, item) => {
      pre[item] = true
      return pre
    }, {})

    return this.productService.products({
      skip,
      take,
      where,
      select: {
        ...includeQuery,
        available: true,
        barcode: true,
        category: true,
        category_id: true,
        compare_at_price: true,
        featured_image: true,
        id: true,
        created_at: true,
        price: true,
        price_max: true,
        price_min: true,
        slug: true,
        published_at: true,
        title: true,
        status: true,
        vendor: true,
        updated_at: true,
        images: true,

      }
    });
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const product = await this.productService.product(id);
    return product
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
