import {
  Controller,
  Post,
  Get,
  Patch,
  Delete,
  Param,
  Body,
  Req,
  UseGuards,
} from "@nestjs/common";
import { AddressService } from "../services/address.service";
import { CreateAddressDto, UpdateAddressDto } from "../dtos/address.dto";
import { JwtAuthGuard } from "../auth/jwt.guard";
import { Request } from "express";

@Controller("customer/addresses")
export class AddressController {
  constructor(private readonly addressService: AddressService) {}

  @Post()
  @UseGuards(JwtAuthGuard) // Apply guard to protect this route
  async create(@Req() req: Request, @Body() dto: CreateAddressDto) {
    const customerId = req.user["id"];
    return this.addressService.create(customerId, dto);
  }

  @Get()
  @UseGuards(JwtAuthGuard) // Apply guard to protect this route
  async findAll(@Req() req: Request) {
    const customerId = req.user["id"]; // Giả sử bạn đã xác thực người dùng và thêm id vào req.user
    return this.addressService.findAll(customerId);
  }

  @Get(":id")
  @UseGuards(JwtAuthGuard) // Apply guard to protect this route
  async findOne(@Param("id") id: number) {
    return this.addressService.findOne(id);
  }

  @Patch(":id")
  @UseGuards(JwtAuthGuard) // Apply guard to protect this route
  async update(@Param("id") id: number, @Body() dto: UpdateAddressDto) {
    return this.addressService.update(id, dto);
  }

  @Delete(":id")
  @UseGuards(JwtAuthGuard) // Apply guard to protect this route
  async remove(@Param("id") id: number) {
    return this.addressService.remove(id);
  }
}
