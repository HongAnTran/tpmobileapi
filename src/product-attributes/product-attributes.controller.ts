import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from "@nestjs/common";
import { ProductAttributesService } from "./product-attributes.service";
import { Prisma } from "@prisma/client";
import { Public } from "src/common/decorator/public.decorator";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("product-attributes")
@UseGuards(AuthGuard)
export class ProductAttributesController {
  constructor(
    private readonly productAttributesService: ProductAttributesService
  ) {}

  @Post()
  create(
    @Body() createProductAttributeDto: Prisma.ProductAttributesCreateInput
  ) {
    return this.productAttributesService.create(createProductAttributeDto);
  }

  @Public()
  @Get()
  findAll(@Query("skip") skip?: string, @Query("take") take?: string) {
    return this.productAttributesService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
    });
  }
  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.productAttributesService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateProductAttributeDto: Prisma.ProductAttributesUpdateInput
  ) {
    return this.productAttributesService.update(+id, updateProductAttributeDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.productAttributesService.remove(+id);
  }
}
