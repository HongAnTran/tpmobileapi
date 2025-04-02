import {
  Controller,
  Post,
  Body,
  Param,
  Put,
  BadRequestException,
  Get,
  UseGuards,
  Req,
  Delete,
} from "@nestjs/common";
import { OrderPublicService } from "./order-public.service";
import { Prisma } from "@prisma/client";
import { AuthCustomerGuard } from "../customer-auth/jwtCustomer.guard";

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

  @Post("customer")
  @UseGuards(AuthCustomerGuard)
  createByCustomer(
    @Req() req: any,
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
    const { id } = req.customer;
    return this.orderPublicService.createOrderReview(createOrderDto,id);
  }

  @Put("/checkout/:token")
  async checkout(
    @Param("token") token: string,
    @Body()
    checkoutOrder: Pick<
      Prisma.OrderUpdateInput,
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

  @Put("/checkout/customer/:token")
  @UseGuards(AuthCustomerGuard)
  async checkoutByCustomer(
    @Req() req: any,
    @Param("token") token: string,
    @Body()
    checkoutOrder: Pick<
      Prisma.OrderUpdateInput,
      | "discount"
      | "note"
      | "payment"
      | "promotions"
      | "ship_price"
      | "shipping"
    >
  ) {
    try {
    const { id } = req.customer;
      const res = await this.orderPublicService.checkOut(token ,  checkoutOrder , id)
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
  @Get("/code/:code")
  findOneByCode(@Param("code") code: string) {
    return this.orderPublicService.findOneByCode(code);
  }

  @Put("cancel/:code")
  @UseGuards(AuthCustomerGuard)
  cancelOrder(@Req() req: any, @Param() code: string , @Body() body: {
    cancelReason: string
    cancelReasonCode: number
  }) {
    const { id } = req.customer;
    if (!code) {
      throw new BadRequestException("code is required");
    }
    return this.orderPublicService.cancelOrder(id, code,body);
  }

}
