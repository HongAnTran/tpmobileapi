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
import { MailService } from "src/mail/mail.service";
import { OrderStatus } from "src/common/types/Order.type";

@Controller("public/orders")
export class OrderPublicController {
  constructor(
    private readonly orderPublicService: OrderPublicService,
    private readonly mailService: MailService
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
    return this.orderPublicService.createOderReview(createOrderDto);
  }

  @Put("/checkout/:id")
  async checkout(
    @Param("id") id: string,
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
      const data: Prisma.OrderUpdateInput = {
        status: OrderStatus.PENDING,
        ...checkoutOrder,
      };
      const res = await this.orderPublicService.update(+id, data);
      this.mailService.sendMail({
        from: process.env.ADMIN_EMAIL_ADDRESS,
        subject: "TP Mobile Store - Đơn đặt hàng mới",
        to: process.env.ADMIN_EMAIL_ADDRESS,
        template: "newOrder",
        context: res,
      });
      return res;
    } catch (error) {
      throw new BadRequestException("Something bad happened", {
        cause: new Error(),
        description: error,
      });
    }
  }

  @Get("/token/:token")
  findOneByToken(@Param("token") token: string) {
    return this.orderPublicService.findOneByToken(token);
  }
}
