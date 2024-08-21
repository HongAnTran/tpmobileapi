// src/customer/user/dtos/auth.dto.ts
import { IsEmail, IsNotEmpty, IsString, MinLength } from 'class-validator';

export class RegisterCustomerDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @MinLength(6)
  @IsNotEmpty()
  password: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  phone: string;

  @IsString()
  @IsNotEmpty()
  provider: string;
}

export class LoginCustomerDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @MinLength(6)
  @IsNotEmpty()
  password: string;
}

export class ChangePasswordDto {
  @IsString()
  @MinLength(6)
  @IsNotEmpty()
  currentPassword: string;

  @IsString()
  @MinLength(6)
  @IsNotEmpty()
  newPassword: string;
}
