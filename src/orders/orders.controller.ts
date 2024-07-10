import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { Order, Prisma } from '@prisma/client';
import * as crypto from 'crypto';
import { MailService } from 'src/mail/mail.service';
@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService , private readonly mailService : MailService) { }

  @Post()
  create(@Body() createOrderDto: Pick<Prisma.OrderCreateInput, "items" | "note" | "total_price" | "temp_price" | "discount" | "ship_price">) {

    const token = crypto.randomBytes(32).toString('hex');
    const code = crypto.randomBytes(32).toString('hex');
    const data: Prisma.OrderCreateInput = { ...createOrderDto, token, code: code, status: 3 }
    return this.ordersService.create(data);
  }



  @Post("/checkout")
  checkout(@Body() checkoutOrder: Order) {
    const data: Prisma.OrderUpdateInput = { ...checkoutOrder, status: 5 }
    this.mailService.sendMail({
      from : "tranhongaknr.2001@gmail.com",
      html : `"<div>Đặt hàng</div>" ${checkoutOrder.token}`,
      subject : "Đơn đặt hàng mới",
      text  : "",
      to : "ordertpmobile@gmail.com"
    })
    

    return this.ordersService.update(checkoutOrder.id, data);
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
