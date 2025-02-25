import {
  IsString,
  IsOptional,
  IsEmail,
  IsDate,
  IsEnum,
  IsNotEmpty,
  IsInt,
} from "class-validator";
import { Gender } from "@prisma/client";
import { Transform } from "class-transformer";

export class CreateCustomerDto {
  @IsNotEmpty()
  @IsInt()
  @Transform(({ value }) => parseInt(value))
  account_id: number;

  @IsOptional()
  @IsEmail()
  email?: string;

  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
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
