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
  Put,
} from "@nestjs/common";
import { CustomerAuthService } from "./customer-auth.service";
import { LoginDto } from "./dto/login.dto";
import { RegisterDto } from "./dto/register.dto";
import { AuthCustomerGuard } from "./jwtCustomer.guard";
import { ChangePassDto } from "./dto/changePass.dto";

@Controller("public/auth")
export class CustomerAuthController {
  constructor(private readonly customerAuthService: CustomerAuthService) {}

  @Post("login")
  login(@Body() login: LoginDto) {
    return this.customerAuthService.signIn(login);
  }

  @Post("logout")
  logout() {
    return this.customerAuthService.logout();
  }

  @Post("register")
  register(@Body() createCustomerAuthDto: RegisterDto) {
    return this.customerAuthService.register(createCustomerAuthDto);
  }

  @Get("active/:token")
  active(@Param("token") token: string) {
    return this.customerAuthService.activeAccount(token);
  }

  @Put("reset-password")
  resetPassword(@Body() body: { email: string }) {
    return this.customerAuthService.resetPassword(body.email);
  }
  @Put("active-password")
  activePassword(@Body() body: { password: string; token: string }) {
    return this.customerAuthService.resetPasswordConfirm(
      body.token,
      body.password
    );
  }

  @Put("change-password")
  @UseGuards(AuthCustomerGuard)
  changePass(@Req() req: any, @Body() body: ChangePassDto) {
    const { id } = req.customer;
    return this.customerAuthService.changePass(id, body);
  }
}
