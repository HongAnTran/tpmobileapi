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
    page?: string;
    limit?: string;
    status?: string
    categories?: string
    category_id?: string
    ids?: string
    include?: string,
    keyword?: string,
    color?: string
    capacity?: string
    price?: string
    ram?: string
    sortBy?: string
    sortType?: Prisma.SortOrder
  }) {
    const HUN = 1000000
    const { ids, include, keyword, status, color, capacity, price, ram, sortBy, sortType, page, limit, categories, category_id } = query
    const take = limit ? Number(limit) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;

    const productIds = ids ? ids.split(",").map(id => Number(id)) : []
    const categoriesSlugArr = categories ? categories.split(",") : []
    const includeParams = include ? include.split(",") : [
      "categories",
    ]

    const priceRange = price ? price.split(",").map(num => {
      const number = Number(num)
      return number ? number * HUN : 0
    }) : []

    let queryOptions: Prisma.ProductWhereInput | Prisma.ProductWhereInput[] = undefined


    const capacityValues = capacity?.split(",") || []
    const colorValues = color?.split(",") || []



    if (colorValues.length && capacityValues.length) {
      queryOptions = {
        AND: [
          {
            options: {
              some: {
                values: {
                  has: color
                }
              }
            }
          },
          {
            options: {
              some: {
                values: {
                  hasSome: capacityValues
                }
              }
            }
          }
        ]
      }
    } else if (colorValues.length) {
      queryOptions = {
        options: { some: { values: { hasSome: colorValues } } }
      }
    }
    else if (capacityValues.length) {
      queryOptions = {
        options: { some: { values: { hasSome: capacityValues } } }
      }
    }
    const where: Prisma.ProductWhereInput = {
      status: status ? Number(status) : undefined,
      id: productIds.length ? { in: productIds } : undefined,
      price: priceRange.length ? {
        gte: priceRange[0],
        lte: priceRange[1]
      } : undefined,

      categories: category_id ? { some: { id: +category_id } } : categoriesSlugArr.length ? {
        some: { slug: { in: categoriesSlugArr } }
      } : undefined,
      ...queryOptions,
      ...(keyword && { title: { contains: keyword, mode: "insensitive" } }),
    };

    let orderBy: Prisma.ProductOrderByWithRelationInput = { [sortBy]: sortType }

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
        categories: {
          select: {
            id: true,
            title: true,
            slug: true,

          }
        },
        compare_at_price: true,
        featured_image: true,
        product_images: true,
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

      },
      orderBy
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
