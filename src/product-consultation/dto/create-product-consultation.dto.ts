import { IsNotEmpty, IsOptional, IsEmail } from "class-validator";

export class CreateProductConsultationDto {
  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  phone: string;

  @IsOptional()
  @IsEmail()
  email?: string;

  @IsOptional()
  message?: string;

  @IsNotEmpty()
  product_id: number;

  @IsOptional()
  tags?: object;
}
