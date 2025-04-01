import { Injectable } from "@nestjs/common";
import { UpdateCustomerPublicDto } from "./dto/update-customer-public.dto";
import { PrismaService } from "src/prisma.service";
import { Prisma } from "@prisma/client";

@Injectable()
export class CustomerPublicService {
  constructor(private prismaService: PrismaService) {}

  async profile(id: number) {
    return this.prismaService.customer.findUnique({
      where: { id },
      select: {
        email: true,
        first_name: true,
        last_name: true,
        phone: true,
        full_name: true,
        gender: true,
        birthday: true,
        avatar: true,
        meta_data: true,
      },
    });
  }

  update(id: number, updateCustomerPublicDto: UpdateCustomerPublicDto) {
    let full_name = ""
    if(updateCustomerPublicDto.first_name && updateCustomerPublicDto.last_name) {
       full_name = `${updateCustomerPublicDto.first_name} ${updateCustomerPublicDto.last_name}`;
    }
    return this.prismaService.customer.update({
      where: { id },
      data: {
        ...updateCustomerPublicDto,
        full_name: full_name || undefined,
      },
    });
  }

  createAddress(id: number, body: Prisma.AddressCreateInput) {
    return this.prismaService.address.create({
      data: {
        ...body,
        customer:{
          connect: { id },
        }
      },
    });
  }

  updateAddress(id: number,idAddress : number, body: Prisma.AddressUpdateInput) {
    return this.prismaService.address.update({
      where: {
         id : idAddress , 
        customer_id: id,
       },
      data: body,
    });
  }


  deleteAddress(id: number,idAddress : number) {
    return this.prismaService.address.delete({
      where: {
        id : idAddress , 
        customer_id: id,
      },
    });
  }

  async getMyAddress(id: number) {
    const address = await this.prismaService.address.findMany({
      where: { customer_id: id },
      include: {
        province: true,
        district: true,
        ward: true,
      },
    });
    return address
  }
async getMyCart(id: number) {
    // get last cart of customer
    const cart = await this.prismaService.cart.findMany({
      where: { customer_id: id },
      include: {
        items : {include: {product: true , variant: true  }},
      },
      take: 1,
      orderBy:{
        created_at: "desc",
      }
    });
    if(!cart.length) {
      return {
        cart : null
      }
    }
    return {
      cart : cart[0]
    }
  }

 async saveMyCart(id: number, body: Prisma.CartCreateInput) {
      const {token} = body
    const cart = await this.prismaService.cart.findUnique({
      where: { token },
    });
    if(!cart) {
    return this.prismaService.cart.create({
      data: {
        ...body,
        customer:{
          connect: { id },
        }
      },
      include:{
        items : {include: {product: true , variant: true  }},
      }
    });
  } else {
    return this.prismaService.cart.update({
      where: { token },
      data: {
        ...body,
        customer:{
          connect: { id },
        }
      },
      include:{
        items : {include: {product: true , variant: true  }},
      }
    });
  }
  }
}
