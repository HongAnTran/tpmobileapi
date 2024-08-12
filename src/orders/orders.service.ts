import { PrismaService } from 'src/prisma.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { Prisma } from '@prisma/client';
import { Injectable, NotFoundException } from '@nestjs/common';
import { OrderStatus } from 'src/common/types/Order.type';
import * as crypto from 'crypto';

@Injectable()
export class OrdersService {
  constructor(private prisma: PrismaService) { }

  async create(data: Prisma.OrderCreateInput) {
    return this.prisma.order.create({
      data,
    });
  }

  async createOderReview(input: Pick<Prisma.OrderCreateInput, "items" | "note" | "total_price" | "temp_price" | "discount" | "ship_price">) {
    const token = crypto.randomBytes(12).toString('hex');
    const code = "DH" + crypto.randomBytes(6).toString("hex");
    const data: Prisma.OrderCreateInput = { ...input, token, code: code, status: OrderStatus.DRAFT }
    return this.prisma.order.create({
      data,
      include: {
        items: true,

      }
    });
  }
  // Cập nhật đơn hàng từ trạng thái "Đang chờ xử lý" sang "Đang xử lý" (Processing)
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
      }
    });
  }
  // Cập nhật đơn hàng từ trạng thái "Đang xử lý" sang "Đang giao" (Shipped)
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
      }
    });
  }
  // Cập nhật đơn hàng từ trạng thái "Đang giao" sang "Hoàn tất" (Completed)
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
      }
    });
  }
  // Cập nhật đơn hàng từ bất kỳ trạng thái nào sang "Đã hủy" (Cancelled)
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
      }
    });
  }

  async findAll({
    skip,
    take,
    where,
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.OrderWhereInput;
  }) {
    return this.prisma.order.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    try {

      const order = await this.prisma.order.findUnique({
        where: { id },
        include: {
          items: true,
          customer: true, payment: true, shipping: true
        }
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
        where: { token },
        include: {
          items: true,
          customer: true, payment: true, shipping: true
        }
      });
      if (!order) {
        throw new NotFoundException(`order with token ${token} not found`);
      }

      return order
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
        shipping: true
      }
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

    return await this.prisma.order.deleteMany({
      where: {
        status: OrderStatus.DRAFT,
        created_at: { lt: deleteBefore },
      },
    });
  }
}
