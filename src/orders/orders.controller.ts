import { Controller, Get, Post, Body, Patch, Param, Delete, HttpStatus, BadRequestException, Put } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { Order, Prisma } from '@prisma/client';
import * as crypto from 'crypto';
import { MailService } from 'src/mail/mail.service';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService, private readonly mailService: MailService) { }

  @Post()
  create(@Body() createOrderDto: Pick<Prisma.OrderCreateInput, "items" | "note" | "total_price" | "temp_price" | "discount" | "ship_price">) {

    const token = crypto.randomBytes(16).toString('hex');
    const code = crypto.randomBytes(16).toString('hex');
    const data: Prisma.OrderCreateInput = { ...createOrderDto, token, code: code, status: 3 }
    return this.ordersService.create(data);
  }

  @Put("/checkout/:id")
  async checkout(@Param('id') id: string, @Body() checkoutOrder: Pick<Prisma.OrderUpdateInput , "customer" |"discount" | "note" | "payment" | "promotions" | "ship_price"  | "shipping">) {
    try {
      const data: Prisma.OrderUpdateInput = { status: 5, ...checkoutOrder }
      const res = await this.ordersService.update(+id, data);
      this.mailService.sendMail({
        from: process.env.ADMIN_EMAIL_ADDRESS,
        subject: "TP Mobile Store - Đơn đặt hàng mới",
        to: process.env.ADMIN_EMAIL_ADDRESS,
        template: "newOrder",
        context: res
      })
      return res
    } catch (error) {
      throw new BadRequestException('Something bad happened', { cause: new Error(), description: error })
    }
  }

  @Get()
  findAll() {
    return this.ordersService.findAll({});
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.ordersService.findOne(+id);
  }

  @Get('token/:token')
  findOneByToken(@Param('token') token: string) {
    return this.ordersService.findOneByToken(token);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateOrderDto: Prisma.OrderUpdateInput) {
    return this.ordersService.update(+id, updateOrderDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.ordersService.remove(+id);
  }
}
