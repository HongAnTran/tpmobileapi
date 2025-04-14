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
import { AttributesService } from "./attributes.service";
import { Prisma } from "@prisma/client";
import { AuthGuard } from "src/auth/jwt.guard";
@Controller("attributes")
@UseGuards(AuthGuard)
export class AttributesController {
  constructor(private readonly attributesService: AttributesService) {}

  @Post()
  create(@Body() createAttributesDto: Prisma.AttributesCreateInput) {
    return this.attributesService.create(createAttributesDto);
  }

  @Get()
  findAll(@Query("skip") skip?: string, @Query("take") take?: string) {
    return this.attributesService.findAll({
      skip: skip ? Number(skip) : undefined,
      take: take ? Number(take) : undefined,
    });
  }
  @Get("productAttributeValue")
  getProductAttributeValue() {
    return this.attributesService.getProductAttributeValue();
  }
  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.attributesService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateAttributesDto: Prisma.AttributesUpdateInput
  ) {
    return this.attributesService.update(+id, updateAttributesDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.attributesService.remove(+id);
  }


}
