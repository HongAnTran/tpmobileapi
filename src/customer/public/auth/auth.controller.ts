import { Controller, Post, Body, Put, Req } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginCustomerDto } from './dtos/auth.dto';
import { RegisterCustomerDto } from './dtos/auth.dto';
import { Request } from 'express';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(@Body() loginDto: LoginCustomerDto): Promise<{ access_token: string }> {
    return this.authService.login(loginDto);
  }

  @Post('register')
  async register(@Body() registerDto: RegisterCustomerDto): Promise<{ access_token: string }> {
    return this.authService.register(registerDto);
  }

  @Put('refresh')
  async refreshToken(@Req() req: Request): Promise<{ access_token: string }> {
    const userId = req.user['id'];
    return this.authService.refreshToken(userId);
  }
}
