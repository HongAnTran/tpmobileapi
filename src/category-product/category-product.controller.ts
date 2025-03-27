import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Query,
  NotFoundException,
  Patch,
  UseGuards,
} from "@nestjs/common";
import { CategoryProductService } from "./category-product.service";
import { Category, Prisma } from "@prisma/client";
import { AuthGuard } from "src/auth/jwt.guard";
@Controller("category-product")
@UseGuards(AuthGuard)
export class CategoryProductController {
  constructor(
    private readonly categoryProductService: CategoryProductService
  ) {}

  @Get(":id")
  async findOne(@Param("id") id: string): Promise<Category | null> {
    try {
      const idNumber = Number(id);
      let query: Prisma.CategoryWhereUniqueInput = { slug: id };
      if (!isNaN(idNumber)) {
        query = { id: idNumber };
      }
      const category = await this.categoryProductService.category(query);

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
    return this.categoryProductService.categories({
      skip: skip,
      take: take,
      orderBy: {
        [query.orderBy]: query.orderType,
      },
    });
  }
  @Post()
  async create(@Body() data: Prisma.CategoryCreateInput): Promise<Category> {
    return this.categoryProductService.createCategory(data);
  }

  @Patch(":id")
  async update(
    @Param("id") id: string,
    @Body() data: Prisma.CategoryUpdateInput
  ): Promise<Category> {
    return this.categoryProductService.updateCategory({
      where: { id: Number(id) },
      data,
    });
  }

  @Delete(":id")
  async remove(@Param("id") id: string): Promise<Category> {
    return this.categoryProductService.deleteCategory({ id: Number(id) });
  }
}
