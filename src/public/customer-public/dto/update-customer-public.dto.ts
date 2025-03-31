import { Gender } from "@prisma/client";
import { IsString, IsOptional, IsEnum, IsDate } from "class-validator";
export class UpdateCustomerPublicDto {
  @IsOptional()
  @IsString()
  first_name?: string;

  @IsOptional()
  @IsString()
  last_name?: string;

  @IsOptional()
  @IsString()
  phone?: string;

  @IsOptional()
  @IsString()
  avatar?: string;

  @IsOptional()
  @IsEnum(Gender)
  gender?: Gender;

  @IsOptional()
  @IsDate()
  birthday?: Date;
}
