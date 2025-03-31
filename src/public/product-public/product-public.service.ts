import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma, Product } from "@prisma/client";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class ProductPublicService {
  constructor(private prisma: PrismaService) {}

  async product(id: string): Promise<Product | null> {
    try {
      const idNumber = Number(id);
      let query: Prisma.ProductWhereUniqueInput = { slug: id, available: true };
      if (!isNaN(idNumber)) {
        query = { id: idNumber, available: true };
      }
      const product = await this.prisma.product.findUnique({
        where: query,
        include: {
          sub_categories: {
            select: {
              category: { select: { id: true, slug: true, title: true } },
              category_id: true,
              id: true,
            },
            where: { category: { published: true } },
          },
          variants: {
            orderBy: { position: "asc" },
            include: {
              attribute_values: {
                select: {
                  id: true,
                  hex_color: true,
                  attribute_id: true,
                  value: true,
                  slug: true,
                },
              },
              image: true,
            },
          },
          category: { select: { id: true, slug: true, title: true } },
          images: {
            select: {
              id: true,
              alt_text: true,
              url: true,
              is_featured: true,
              position: true,
            },
            orderBy: { position: "asc" },
          },
          brand: { select: { id: true, name: true, slug: true } },
          tags: true,
          attributes: {
            select: {
              position: true,
              id: true,
              attribute: true,
              values: {
                select: {
                  position: true,
                  attributeValue: true,
                },
              },
            },
            orderBy: { position: "asc" },
          },
        },
      });
      if (!product) {
        throw new NotFoundException(`Product with ID ${id} not found`);
      }
      return product;
    } catch (error) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }
  }

  async products(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.ProductWhereUniqueInput;
    where?: Prisma.ProductWhereInput;
    orderBy?: Prisma.ProductOrderByWithRelationInput;
    select?: Prisma.ProductSelect;
  }) {
    const { skip, take, cursor, where, orderBy, select } = params;
    const datas = await this.prisma.product.findMany({
      skip,
      take,
      cursor,
      where: { ...where, available: true },

      orderBy,
      select,
    });

    const total = await this.prisma.product.count({
      where: { ...where, available: true },
    });
    return {
      total,
      datas,
    };
  }
}
