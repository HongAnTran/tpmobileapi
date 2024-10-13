import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCartDto } from './dto/create-cart.dto';
import { UpdateCartDto } from './dto/update-cart.dto';
import { PrismaService } from 'src/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class CartsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(createCartDto: Prisma.CartCreateInput) {
    return this.prisma.cart.create({
      data: {
        ...createCartDto,
      },
    });
  }

  async findAll() {
    return this.prisma.cart.findMany();
  }

  async findOne(id: number) {
    const cart = await this.prisma.cart.findUnique({
      where: { id },
    });
    if (!cart) {
      throw new NotFoundException(`Cart with ID ${id} not found`);
    }
    return cart;
  }

  async update(id: number, updateCartDto: Prisma.CartUpdateInput) {
    const cart = await this.prisma.cart.update({
      where: { id },
      data: {
        ...updateCartDto,
      },
    });
    if (!cart) {
      throw new NotFoundException(`Cart with ID ${id} not found`);
    }
    return cart;
  }

  async remove(id: number) {
    const cart = await this.prisma.cart.delete({
      where: { id },
    });
    if (!cart) {
      throw new NotFoundException(`Cart with ID ${id} not found`);
    }
    return cart;
  }
}
