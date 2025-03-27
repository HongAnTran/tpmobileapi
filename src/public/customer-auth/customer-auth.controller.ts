import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { CustomerAuthService } from "./customer-auth.service";
import { LoginDto } from "./dto/login.dto";

@Controller("public/customer-auth")
export class CustomerAuthController {
  constructor(private readonly customerAuthService: CustomerAuthService) {}

  @Post()
  login(@Body() createCustomerAuthDto: LoginDto) {
    return this.customerAuthService.signIn(createCustomerAuthDto);
  }
}
