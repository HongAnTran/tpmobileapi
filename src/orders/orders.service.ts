import { PrismaService } from "src/prisma.service";
import { Order, Prisma } from "@prisma/client";
import { Injectable, NotFoundException } from "@nestjs/common";
import { OrderStatus } from "src/common/types/Order.type";
import * as crypto from "crypto";
import { ResponseList } from "src/common/types/Common.type";
import { MailService } from "src/mail/mail.service";

@Injectable()
export class OrdersService {
  constructor(
    private prisma: PrismaService,

    private readonly mailService: MailService
  ) {}

  async create(data: Prisma.OrderCreateInput) {
    return this.prisma.order.create({
      data,
    });
  }

  async processOrder(id: number) {
    return this.prisma.order.update({
      where: { id },
      data: {
        status: OrderStatus.PROCESSING,
      },
      include: {
        customer: true,
        items: true,
        payment: true,
        shipping: true,
      },
    });
  }
  async shipOrder(id: number) {
    return this.prisma.order.update({
      where: { id },
      data: {
        status: OrderStatus.SHIPPED,
      },
      include: {
        customer: true,
        items: true,
        payment: true,
        shipping: true,
      },
    });
  }
  async completeOrder(id: number) {
    return this.prisma.order.update({
      where: { id },
      data: {
        status: OrderStatus.SUCCESS,
      },
      include: {
        customer: true,
        items: true,
        payment: true,
        shipping: true,
      },
    });
  }
  async cancelOrder(id: number) {
    return this.prisma.order.update({
      where: { id },
      data: {
        status: OrderStatus.CANCELLED,
      },
      include: {
        customer: true,
        items: true,
        payment: true,
        shipping: true,
      },
    });
  }

  async findAll({
    skip,
    take,
    where,
    select,
    orderBy,
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.OrderWhereInput;
    select?: Prisma.OrderSelect;
    orderBy?: Prisma.OrderOrderByWithRelationInput;
  }) {
    const orders = await this.prisma.order.findMany({
      where: { ...where, available: true },
      skip,
      take,
      select,
      orderBy: orderBy ? orderBy : { id: "desc" },
    });
    const count = await this.prisma.order.count({
      where: { ...where, available: true },
    });
    const response: ResponseList<Order> = {
      total: count,
      datas: orders,
    };
    return response;
  }

  async findOne(id: number) {
    try {
      const order = await this.prisma.order.findUnique({
        where: { id, available: true },
        include: {
          items: true,
          customer: true,
          payment: true,
          shipping: true,
        },
      });

      if (!order) {
        throw new NotFoundException(`order with ID ${id} not found`);
      }
      return order;
    } catch (error) {
      throw new NotFoundException(`order with ID ${id} not found`);
    }
  }

  async findOneByToken(token: string) {
    try {
      const order = await this.prisma.order.findUnique({
        where: { token, available: true },
        include: {
          items: true,
          customer: true,
          payment: true,
          shipping: true,
        },
      });
      if (!order) {
        throw new NotFoundException(`order with token ${token} not found`);
      }

      return order;
    } catch (error) {
      throw new NotFoundException(`order with token ${token} not found`);
    }
  }

  async update(id: number, data: Prisma.OrderUpdateInput) {
    return this.prisma.order.update({
      where: { id },
      data,
      include: {
        customer: true,
        items: true,
        payment: true,
        shipping: true,
      },
    });
  }

  async remove(id: number) {
    return this.prisma.order.delete({
      where: { id },
    });
  }

  // Xóa các đơn hàng nháp cũ hơn số ngày được chỉ định
  async removeDraftOrdersOlderThan(days: number) {
    const deleteBefore = new Date();
    deleteBefore.setDate(deleteBefore.getDate() - days);

    return await this.prisma.order.updateMany({
      where: {
        status: OrderStatus.DRAFT,
        created_at: { lt: deleteBefore },
      },
      data: { available: false },
    });
  }

  async sendMailRemind() {
    return this.mailService.sendMail({
      subject: "Nhắc lịch đóng thuế cho Tuỳn cuti",
      to: "tieutieulinhqaz@gmail.com",
      template: "remind",
    });
  }
}
