import { Injectable, NotFoundException } from "@nestjs/common";
import { Customer } from "@prisma/client";
import { PrismaService } from "src/prisma.service";
import { CreateCustomerDto } from "../dto/create-customer.dto";
import { UpdateCustomerDto } from "../dto/update-customer.dto";

@Injectable()
export class CustomerSystemService {
  constructor(private prisma: PrismaService) {}

  async create(createCustomerDto: CreateCustomerDto): Promise<Customer> {
    const { account_id, ...res } = createCustomerDto;
    return this.prisma.customer.create({
      data: {
        ...res,
        full_name:
          createCustomerDto.last_name + " " + createCustomerDto.first_name,
        account: { connect: { id: account_id } },
      },
    });
  }

  async findAll(): Promise<Customer[]> {
    return this.prisma.customer.findMany({
      include: { account: true },
    });
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

  async update(
    id: number,
    updateCustomerDto: UpdateCustomerDto
  ): Promise<Customer> {
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
