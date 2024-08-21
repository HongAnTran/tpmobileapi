// src/customer/user/services/address.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CreateAddressDto, UpdateAddressDto } from '../dtos/address.dto';
import { Address } from '@prisma/client';

@Injectable()
export class AddressService {
  constructor(private readonly prisma: PrismaService) {}

  async create(customerId: number, dto: CreateAddressDto): Promise<Address> {
    return this.prisma.address.create({
      data: { ...dto, customer_id: customerId },
    });
  }

  async findAll(customerId: number): Promise<Address[]> {
    return this.prisma.address.findMany({ where: { customer_id: customerId } });
  }

  async findOne(id: number): Promise<Address> {
    const address = await this.prisma.address.findUnique({ where: { id } });
    if (!address) {
      throw new NotFoundException(`Address with id ${id} not found`);
    }
    return address;
  }

  async update(id: number, dto: UpdateAddressDto): Promise<Address> {
    return this.prisma.address.update({
      where: { id },
      data: dto,
    });
  }

  async remove(id: number): Promise<Address> {
    return this.prisma.address.delete({
      where: { id },
    });
  }
}
