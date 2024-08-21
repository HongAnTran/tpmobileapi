import { IsString, IsOptional, IsEmail, IsDate, IsEnum } from 'class-validator';
import { Gender } from '@prisma/client';

export class CreateCustomerDto {
  @IsOptional()
  @IsEmail()
  email?: string;

  @IsString()
  password: string;

  @IsString()
  name: string;

  @IsString()
  phone: string;

  @IsOptional()
  @IsEnum(Gender)
  gender?: Gender;

  @IsOptional()
  @IsDate()
  birthday?: Date;

  @IsString()
  provider: string;

  @IsOptional()
  @IsString()
  provider_id?: string;
  
  @IsOptional()
  status?: number;
}
