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
    const categoryId = Number(category_id)

    const includeParams = include ? include.split(",") : []

    const priceRange = price ? price.split(",").map(num => {
      const number = Number(num)
      return number ? number * HUN : 0
    }) : []

    let queryOptions: Prisma.ProductWhereInput | Prisma.ProductWhereInput[] = undefined
    let queryOptionsCategory: Prisma.ProductWhereInput | Prisma.ProductWhereInput[] = undefined


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

    if (categoryId) {
      queryOptionsCategory = {
        OR: [
          { category_id: categoryId },
          { sub_categories: { some: { category_id: categoryId } } }
        ]

      }
    }

    if (categoriesSlugArr.length) {
      queryOptionsCategory = {
        OR: [{ sub_categories: { some: { category: { slug: { in: categoriesSlugArr } } } }, category: { slug: { in: categoriesSlugArr } } }]
      }
    }


    const where: Prisma.ProductWhereInput = {
      status: status ? Number(status) : undefined,
      id: productIds.length ? { in: productIds } : undefined,
      price: priceRange.length ? {
        gte: priceRange[0],
        lte: priceRange[1]
      } : undefined,

      // sub_categories: category_id ? { some: { id: +category_id } } : categoriesSlugArr.length ? {
      //   some: { category: { slug: { in: categoriesSlugArr } } }
      // } : undefined,
      ...queryOptionsCategory,
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
        category: {
          select: {
            id: true,
            published: true,
            slug: true,
            title: true
          }
        },
        category_id: true,
        compare_at_price: true,
        images: { select: { id: true, alt_text: true, url: true, is_featured: true, position: true }, orderBy: { position: "asc" }, take: 2 },
        id: true,
        price: true,
        price_max: true,
        price_min: true,
        slug: true,
        title: true,
        status: true,
        brand: { select: { id: true, slug: true, name: true } },
        updated_at: true,
        meta_tags : true,
        tags : true,
        variants : {select : {id:true,option1 : true,option2 :true}},
        options : true,
        attributes : true
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

  @Delete('image:id')
  removeImage(@Param('id') id: string) {
    return this.productService.deleteProductImage({ id: Number(id) });
  }
}
