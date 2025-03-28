import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { AttributePublicService } from './attribute-public.service';
import { Prisma } from '@prisma/client';


@Controller('public/attributes')
export class AttributePublicController {
  constructor(private readonly attributePublicService: AttributePublicService) {}
  @Get()
  findAll(@Query("skip") skip?: string, @Query("take") take?: string) {
    return this.attributePublicService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
    });
  }

  @Get("values")
  findAllValues(
    @Query("skip") skip?: string,
    @Query("take") take?: string,
    @Query("attribute_id") attribute_id?: string
  ) {
    const where: Prisma.AttributeValuesWhereInput = {
      attribute_id: +attribute_id ? +attribute_id : undefined,
    };
    return this.attributePublicService.findAllValues({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
      where,
    });
  }
}
