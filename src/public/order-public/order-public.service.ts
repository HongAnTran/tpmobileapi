import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { OrderStatus } from "src/common/types/Order.type";
import { PrismaService } from "src/prisma.service";
import * as crypto from "crypto";

@Injectable()
export class OrderPublicService {
  constructor(private prisma: PrismaService) {}

  async createOderReview(
    input: Pick<
      Prisma.OrderCreateInput,
      | "items"
      | "note"
      | "total_price"
      | "temp_price"
      | "discount"
      | "ship_price"
    >
  ) {
    const token = crypto.randomBytes(12).toString("hex");
    const code = "DH" + crypto.randomBytes(3).toString("hex");
    const data: Prisma.OrderCreateInput = {
      ...input,
      token,
      code: code.toUpperCase(),
      status: OrderStatus.DRAFT,
    };
    return this.prisma.order.create({
      data,
      include: {
        items: true,
      },
    });
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
}
