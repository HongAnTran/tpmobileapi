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
import { ProductVariantService } from "./product-variant.service";
import { CreateProductVariantDto } from "./dto/create-product-variant.dto";
import { UpdateProductVariantDto } from "./dto/update-product-variant.dto";
import { Prisma } from "@prisma/client";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("product-variant")
@UseGuards(AuthGuard)
export class ProductVariantController {
  constructor(private readonly productVariantService: ProductVariantService) {}

  @Post()
  create(@Body() createProductVariantDto: Prisma.ProductVariantCreateInput) {
    return this.productVariantService.create(createProductVariantDto);
  }

  @Get()
  findAll(@Query("productId") productId?: string) {
    const where: Prisma.ProductVariantWhereInput = {};
    if (productId) {
      where.product_id = Number(productId);
    }
    return this.productVariantService.findAll({ where });
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.productVariantService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateProductVariantDto: Prisma.ProductVariantUpdateInput
  ) {
    return this.productVariantService.update(+id, updateProductVariantDto);
  }

  @Post("delete/many")
  removeMany(@Query("ids") ids?: string) {
    const idsVariant = ids.split(",").map(Number);
    return this.productVariantService.removeSoftMany(idsVariant);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.productVariantService.removeSoft(+id);
  }
}
