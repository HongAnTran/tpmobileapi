import {
  Controller,
  Get,
  Param,
  NotFoundException,
  Query,
} from "@nestjs/common";
import { CategoryPublicService } from "./category-public.service";
import { Prisma } from "@prisma/client";

@Controller("public/categories")
export class CategoryPublicController {
  constructor(private readonly categoryPublicService: CategoryPublicService) {}
  @Get(":id")
  async findOne(@Param("id") id: string) {
    try {
      const idNumber = Number(id);
      let query: Prisma.CategoryWhereUniqueInput = { slug: id };
      if (!isNaN(idNumber)) {
        query = { id: idNumber };
      }
      const category = await this.categoryPublicService.category(query);

      if (!category) {
        throw new NotFoundException(`Product with ID ${id} not found`);
      }
      return category;
    } catch (error) {
      throw new NotFoundException(`category with ID ${id} not found`);
    }
  }
  @Get()
  async findAll(
    @Query()
    query: {
      skip?: string;
      take?: string;
      orderBy?: string;
      orderType?: string;
    }
  ) {
    const skip = query.skip ? parseInt(query.skip, 10) : undefined;
    const take = query.take ? parseInt(query.take, 10) : undefined;
    return this.categoryPublicService.categories({
      skip: skip,
      take: take,
      orderBy: {
        [query.orderBy]: query.orderType,
      },
    });
  }
}
