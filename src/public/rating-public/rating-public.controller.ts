import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Query,
} from "@nestjs/common";
import { RatingPublicService } from "./rating-public.service";
import { CreateRatingPublicDto } from "./dto/create-rating-public.dto";
import { AuthCustomerGuard } from "../customer-auth/jwtCustomer.guard";

@Controller("public/ratings")
export class RatingPublicController {
  constructor(private readonly ratingPublicService: RatingPublicService) {}

  @Post()
  @UseGuards(AuthCustomerGuard)
  create(@Req() req: any, @Body() createRatingDto: CreateRatingPublicDto) {
    const { id } = req.customer;
    const { product_id, ...res } = createRatingDto;
    return this.ratingPublicService.create({
      ...res,
      customer: { connect: { id: id } },
      product: { connect: { id: product_id } },
    });
  }

  @Get(":product_id")
  findAll(@Param("product_id") product_id: string , @Query() query: { page?: string; limit?: string }) {

    return this.ratingPublicService.findAll(+product_id, query);
  }
}
