import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  BadRequestException,
  Put,
} from "@nestjs/common";
import { CustomerPublicService } from "./customer-public.service";
import { UpdateCustomerPublicDto } from "./dto/update-customer-public.dto";
import { AuthCustomerGuard } from "../customer-auth/jwtCustomer.guard";
import { Prisma } from "@prisma/client";

@Controller("public/customers")
@UseGuards(AuthCustomerGuard)
export class CustomerPublicController {
  constructor(private readonly customerPublicService: CustomerPublicService) {}

  @Get("profile")
  profile(@Req() req: any) {
    const { id } = req.customer;
    return this.customerPublicService.profile(id);
  }
  @Get("carts")
  carts(@Req() req: any) {
    const { id } = req.customer;
    return this.customerPublicService.getMyCart(id);
  }
  @Put("carts")
  saveCart(@Req() req: any , @Body() body: Prisma.CartCreateInput) {
    const { id } = req.customer;
    return this.customerPublicService.saveMyCart(id,body);
  }
  @Patch("update")
  update(
    @Req() req: any,
    @Body() updateCustomerPublicDto: UpdateCustomerPublicDto
  ) {
    const { id } = req.customer;
    return this.customerPublicService.update(id, updateCustomerPublicDto);
  }

  @Get("address")
  getAddress(@Req() req: any) {
    const { id } = req.customer;
    return this.customerPublicService.getMyAddress(id);
  }

  @Post("address")
  createAddress(@Req() req: any, @Body() body: Prisma.AddressCreateInput) {
    const { id } = req.customer;
    return this.customerPublicService.createAddress(id, body);
  }

  @Patch("address/:idAddress")
  editAddress(@Req() req: any,@Param() idAddress : string, @Body() body: Prisma.AddressUpdateInput) {
    const { id } = req.customer;
    if (!idAddress) {
      throw new BadRequestException("idAddress is required");
    }
    return this.customerPublicService.updateAddress(id,+idAddress, body);
  }

  @Delete("address/:idAddress")
  deleteAddress(@Req() req: any,@Param() idAddress : string) {
    const { id } = req.customer;
    if (!idAddress) {
      throw new BadRequestException("idAddress is required");
    }
    return this.customerPublicService.deleteAddress(id,+idAddress);
  }
}
