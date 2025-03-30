import {
  Controller,
  Post,
  Body,
  Param,
  Put,
  BadRequestException,
  Get,
} from "@nestjs/common";
import { OrderPublicService } from "./order-public.service";
import { Prisma } from "@prisma/client";

@Controller("public/orders")
export class OrderPublicController {
  constructor(
    private readonly orderPublicService: OrderPublicService,
  ) {}

  @Post()
  create(
    @Body()
    createOrderDto: Pick<
      Prisma.OrderCreateInput,
      | "items"
      | "note"
      | "total_price"
      | "temp_price"
      | "discount"
      | "ship_price"
    >
  ) {
    return this.orderPublicService.createOrderReview(createOrderDto);
  }

  @Put("/checkout/:token")
  async checkout(
    @Param("token") token: string,
    @Body()
    checkoutOrder: Pick<
      Prisma.OrderUpdateInput,
      | "customer"
      | "discount"
      | "note"
      | "payment"
      | "promotions"
      | "ship_price"
      | "shipping"
    >
  ) {
    try {
      const res = await this.orderPublicService.checkOut(token , checkoutOrder)
      return res;
    } catch (error) {
      console.log(error)
      throw new BadRequestException(
        "Đã có lỗi xảy ra vui lòng thử lại trong ít phút"
      );
    }
  }

  @Get("/token/:token")
  findOneByToken(@Param("token") token: string) {
    return this.orderPublicService.findOneByToken(token);
  }
}
