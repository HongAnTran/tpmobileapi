import { Controller, Get, Param, Query } from "@nestjs/common";
import { ProductPublicService } from "./product-public.service";
import { Prisma } from "@prisma/client";

@Controller("public/products")
export class ProductPublicController {
  constructor(private readonly productPublicService: ProductPublicService) {}
  @Get()
  findAll(
    @Query()
    query: {
      page?: string;
      limit?: string;
      status?: string;
      categories?: string;
      category_id?: string;
      ids?: string;
      include?: string;
      keyword?: string;
      price?: string;
      sortBy?: string;
      sortType?: Prisma.SortOrder;
    }
  ) {
    const HUN = 1000000;
    const {
      ids,
      include,
      keyword,
      status,
      price,
      sortBy,
      sortType,
      page,
      limit,
      categories,
      category_id,
      ...attributes
    } = query;
    const MAX_LIMIT = 50;
    const take = limit
      ? Number(limit) <= MAX_LIMIT
        ? Number(limit)
        : MAX_LIMIT
      : MAX_LIMIT;
    const skip = page ? (Number(page) - 1) * take : undefined;

    const productIds = ids ? ids.split(",").map((id) => Number(id)) : [];
    const categoriesSlugArr = categories ? categories.split(",") : [];
    const categoryId = Number(category_id);
    // const includeParams = include ? include.split(",") : [];
    const priceRange = price
      ? price.split(",").map((num) => {
          const number = Number(num);
          return number ? number * HUN : 0;
        })
      : [];

    let queryOptions: Prisma.ProductWhereInput | Prisma.ProductWhereInput[] =
      undefined;
    let queryOptionsCategory:
      | Prisma.ProductWhereInput
      | Prisma.ProductWhereInput[] = undefined;

    const keys = Object.keys(attributes);

    const attributesQuery = keys.map((key) => {
      return {
        attributes: {
          some: {
            values: {
              some: {attributeValue:{ value: { in: attributes[key]?.split(",") || [] }} },
            },
            attribute: {
              key: key,
            },
          },
        },
      };
    });
    if (attributesQuery.length) {
      queryOptions = {
        AND: attributesQuery,
      };
    }
    if (categoryId) {
      queryOptionsCategory = {
        OR: [
          { category_id: categoryId },
          { sub_categories: { some: { category_id: categoryId } } },
        ],
      };
    }
    if (categoriesSlugArr.length) {
      queryOptionsCategory = {
        OR: [
          {
            sub_categories: {
              some: { category: { slug: { in: categoriesSlugArr } } },
            },
          },
          {
            category: { slug: { in: categoriesSlugArr } },
          },
        ],
      };
    }

    const where: Prisma.ProductWhereInput = {
      status: status ? Number(status) : undefined,
      id: productIds.length ? { in: productIds } : undefined,
      price: priceRange.length
        ? {
            gte: priceRange[0],
            lte: priceRange[1],
          }
        : undefined,
      ...queryOptionsCategory,
      ...queryOptions,
      ...(keyword && { title: { contains: keyword, mode: "insensitive" } }),
    };

    let orderBy: Prisma.ProductOrderByWithRelationInput = {
      [sortBy]: sortType,
    };

    return this.productPublicService.products({
      skip,
      take,
      where,
      select: {
        available: true,
        category: {
          select: {
            id: true,
            published: true,
            slug: true,
            title: true,
          },
        },
        category_id: true,
        compare_at_price: true,
        images: {
          where: { is_featured: true },
          select: {
            id: true,
            alt_text: true,
            url: true,
            is_featured: true,
            position: true,
          },
          take: 1,
        },
        id: true,
        price: true,
        price_max: true,
        price_min: true,
        slug: true,
        title: true,
        status: true,
        brand: { select: { id: true, slug: true, name: true } },
        updated_at: true,
        meta_tags: true,
        tags: true,
        attributes: {
          include: {
            attribute: true,
            values: true,
          },
        },
      },
      orderBy,
    });
  }
  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.productPublicService.product(id);
  }
}
