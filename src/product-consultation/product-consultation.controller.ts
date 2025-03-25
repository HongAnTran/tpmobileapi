import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from "@nestjs/common";
import { ProductConsultationService } from "./product-consultation.service";
import { CreateProductConsultationDto } from "./dto/create-product-consultation.dto";
import { UpdateProductConsultationDto } from "./dto/update-product-consultation.dto";

@Controller("product-consultation")
export class ProductConsultationController {
  constructor(
    private readonly productConsultationService: ProductConsultationService
  ) {}

  @Post()
  create(@Body() createProductConsultationDto: CreateProductConsultationDto) {
    return this.productConsultationService.create(createProductConsultationDto);
  }

  @Get()
  findAll(
    @Query()
    query: {
      page?: string;
      limit?: string;
      status?: number;
    }
  ) {
    const { limit, page, status } = query;
    const take = limit ? (Number(limit) <= 50 ? Number(limit) : 50) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;
    return this.productConsultationService.findAll({
      skip,
      take,
      where: {
        status,
      },
    });
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.productConsultationService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateProductConsultationDto: UpdateProductConsultationDto
  ) {
    return this.productConsultationService.update(
      +id,
      updateProductConsultationDto
    );
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.productConsultationService.remove(+id);
  }

  @Patch(":id/contacted")
  markAsContacted(@Param("id") id: string) {
    return this.productConsultationService.markAsContacted(+id);
  }

  @Patch(":id/completed")
  markAsCompleted(@Param("id") id: string) {
    return this.productConsultationService.markAsCompleted(+id);
  }

  @Patch(":id/cancel")
  cancelConsultation(@Param("id") id: string) {
    return this.productConsultationService.cancelConsultation(+id);
  }
}
