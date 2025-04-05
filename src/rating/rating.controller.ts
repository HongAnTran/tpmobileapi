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
  Put,
} from "@nestjs/common";
import { RatingService } from "./rating.service";
import { UpdateRatingDto } from "./dto/update-rating.dto";
import { Prisma } from "@prisma/client";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("rating")
@UseGuards(AuthGuard)
export class RatingController {
  constructor(private readonly ratingService: RatingService) {}

  @Post()
  create(@Body() createRatingDto: Prisma.RatingCreateInput) {
    return this.ratingService.create(createRatingDto);
  }
  @Post("many")
  createMany(@Body() createRatingDto: Prisma.RatingCreateManyInput[]) {
    return this.ratingService.createMany(createRatingDto);
  }

  @Get()
  findAll(
    @Query()
    query: {
      page?: string;
      limit?: string;
      product_id?: string;
      customer_id?: string;
      sort_by?: string;
      sort_type?: string;
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

  @Put("products")
  updateProductRating(@Body() updateRatingDto: {
    ids : number[];
  }) {
    return this.ratingService.updateManyProductRating(updateRatingDto.ids);
  }
}
