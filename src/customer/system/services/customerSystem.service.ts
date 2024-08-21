import { Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { Prisma, Customer } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

import * as bcrypt from 'bcryptjs';
import { hashPassword } from 'src/common/helper/hassPassword';
import { CreateCustomerDto } from '../dto/create-customer.dto';
import { UpdateCustomerDto } from '../dto/update-customer.dto';

@Injectable()
export class CustomerSystemService {
  constructor(private prisma: PrismaService) { }

  async create(createCustomerDto: CreateCustomerDto): Promise<Customer> {
    const hashedPassword = await hashPassword(createCustomerDto.password);
    const customerData = {
      ...createCustomerDto,
      password: hashedPassword,
    };
    return this.prisma.customer.create({ data: customerData });
  }

  async findAll(): Promise<Customer[]> {
    return this.prisma.customer.findMany();
  }

  async findOne(id: number): Promise<Customer | null> {
    const customer = await this.prisma.customer.findUnique({
      where: { id },
    });
    if (!customer) {
      throw new NotFoundException(`Customer with id ${id} not found`);
    }
    return customer;
  }

  async update(id: number, updateCustomerDto: UpdateCustomerDto): Promise<Customer> {
    if (updateCustomerDto.password) {
      updateCustomerDto.password = await bcrypt.hash(updateCustomerDto.password, 10);
    }
    return this.prisma.customer.update({
      where: { id },
      data: updateCustomerDto,
    });
  }

  async remove(id: number): Promise<Customer> {
    return this.prisma.customer.delete({
      where: { id },
    });
  }




}
