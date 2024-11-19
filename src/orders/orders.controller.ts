import { Controller, Get, Post, Body, Patch, Param, Delete, HttpStatus, BadRequestException, Put, Query } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { Prisma } from '@prisma/client';
import * as crypto from 'crypto';
import { MailService } from 'src/mail/mail.service';
import { OrderStatus } from 'src/common/types/Order.type';
import { SettingsService } from 'src/settings/settings.service';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService,
     private readonly mailService: MailService,
     private readonly settingService: SettingsService,
    ) { }

    
  @Post()
  create(@Body() createOrderDto: Pick<Prisma.OrderCreateInput, "items" | "note" | "total_price" | "temp_price" | "discount" | "ship_price">) {
    return this.ordersService.createOderReview(createOrderDto);
  }

  @Post("/send")
  send() {
    return this.ordersService.sendMailRemind()
  }
  @Put("/checkout/:id")
  async checkout(@Param('id') id: string, @Body() checkoutOrder: Pick<Prisma.OrderUpdateInput, "customer" | "discount" | "note" | "payment" | "promotions" | "ship_price" | "shipping">) {
    try {
      const data: Prisma.OrderUpdateInput = { status: OrderStatus.PENDING, ...checkoutOrder }
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
  @Patch('/status/:id')
  updateStatus(@Param('id') id: string, @Body() updateOrderDto: Pick<Prisma.OrderUpdateInput, "status">) {
    return this.ordersService.update(+id, updateOrderDto);
  }

  // @Patch('/confirm/:id')
  // confirmOrder(@Param('id') id: string, @Body() updateOrderDto:Pick<Prisma.OrderUpdateInput , "status">) {
  //   return this.ordersService.update(+id, updateOrderDto);
  // }



  @Get()
  findAll(@Query() query: {
    page?: string;
    limit?: string;
    status?: string
    code?: string
    customerId?: string
    notStatus?: string
  }) {
    const { limit, page, status, code, customerId, notStatus } = query
    const take = limit ? Number(limit) <= 50 ? Number(limit) : 50 : 50
    const skip = page ? (Number(page) - 1) * take : undefined;


  

    return this.ordersService.findAll({
      take,
      skip,
      where: {
        status: +status ? +status : +notStatus ? { not: +notStatus } : undefined,
        code: code,
        customer_id: customerId ? +customerId : undefined
      },
      select :{
        id :true,
        status : true,
        customer_id : true,
        customer : true,
        total_price : true,
        shipping : {select : {status : true,shipping_method : true}},
        payment : {select : {status : true,method : true}},
        code : true,
        created_at : true,
        updated_at : true,
        temp_price : true
      }
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.ordersService.findOne(+id);
  }

  @Get('/token/:token')
  findOneByToken(@Param('token') token: string) {
    return this.ordersService.findOneByToken(token);
  }



  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.ordersService.remove(+id);
  // }
}
