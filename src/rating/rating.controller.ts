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
import { RatingService } from "./rating.service";
import { CreateRatingDto } from "./dto/create-rating.dto";
import { UpdateRatingDto } from "./dto/update-rating.dto";
import { Prisma } from "@prisma/client";

@Controller("rating")
export class RatingController {
  constructor(private readonly ratingService: RatingService) {}

  @Post()
  create(@Body() createRatingDto: CreateRatingDto) {
    const { customer_id, product_id, ...res } = createRatingDto;
    return this.ratingService.create({
      ...res,
      customer: { connect: { id: customer_id } },
      product: { connect: { id: product_id } },
    });
  }

  @Get()
  findAll(
    @Query()
    query: {
      page?: string;
      limit?: string;
      product_id?: string;
      customer_id?: string;
    }
  ) {
    const { customer_id, product_id, limit, page } = query;
    const take = limit ? (Number(limit) <= 50 ? Number(limit) : 50) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;
    const where: Prisma.RatingWhereInput = {
      product_id: +product_id || undefined,
      customer_id: +customer_id || undefined,
    };
    return this.ratingService.findAll({ where, skip, take });
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.ratingService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateRatingDto: UpdateRatingDto) {
    return this.ratingService.update(+id, updateRatingDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.ratingService.remove(+id);
  }
}
