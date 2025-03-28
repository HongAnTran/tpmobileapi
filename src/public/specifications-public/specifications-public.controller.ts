import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { SpecificationsPublicService } from './specifications-public.service';
import { Prisma } from '@prisma/client';

@Controller('public/specifications')
export class SpecificationsPublicController {
  constructor(private readonly specificationsPublicService: SpecificationsPublicService) {}

  @Get("types")
  findAllType() {
    return this.specificationsPublicService.findAllType();
  }

  @Get("groups")
  findAllGroup(@Query() query: { type_id?: string }) {
    return this.specificationsPublicService.findAllGroup({
      where: Number(query.type_id)
        ? { type_id: Number(query.type_id) }
        : undefined,
    });
  }
  @Get()
  findAll(
    @Query()
    query: {
      skip?: string;
      take?: string;
      group_id?: string;
      product_id?: string;
      keyword?: string;
    }
  ) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    const where: Prisma.ProductSpecificationsWhereInput = {
      group_id: query.group_id ? parseInt(query.group_id, 10) : undefined,
      product: query.product_id
        ? { some: { id: parseInt(query.product_id, 10) } }
        : undefined,
      value: query.keyword
        ? { contains: query.keyword, mode: "insensitive" }
        : undefined,
    };

    return this.specificationsPublicService.findAll({
      where,
      skip,
      take,
    });
  }

 
}
