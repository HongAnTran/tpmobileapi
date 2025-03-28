import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  UseGuards,
} from "@nestjs/common";
import { CustomerAuthService } from "./customer-auth.service";
import { LoginDto } from "./dto/login.dto";
import { RegisterDto } from "./dto/register.dto";
import { AuthCustomerGuard } from "./jwtCustomer.guard";
import { Public } from "src/common/decorator/public.decorator";


@Controller("public/auth")
export class CustomerAuthController {
  constructor(private readonly customerAuthService: CustomerAuthService) {}

  @Get("profile")
  @UseGuards(AuthCustomerGuard)
  profile(@Req () req: any) {
    const { id } = req.customer;
    return this.customerAuthService.profile(id);
  }


  @Post("login")
  login(@Body() login: LoginDto) {
    return this.customerAuthService.signIn(login);
  }

  @Post("register")
  register(@Body() createCustomerAuthDto: RegisterDto) {
    return this.customerAuthService.register(createCustomerAuthDto);
  }

  @Get("active/:token")
  active(@Param("token") token: string) {
    return this.customerAuthService.activeAccount(token);
  }
}
