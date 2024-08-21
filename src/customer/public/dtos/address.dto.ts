// src/customer/user/dtos/address.dto.ts
import { IsInt, IsNotEmpty, IsString } from 'class-validator';

export class CreateAddressDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  phone: string;

  @IsString()
  @IsNotEmpty()
  detail_address: string;

  @IsInt()
  @IsNotEmpty()
  province_id: number;

  @IsInt()
  @IsNotEmpty()
  district_id: number;

  @IsInt()
  @IsNotEmpty()
  ward_id: number;
}

export class UpdateAddressDto {
  @IsString()
  @IsNotEmpty()
  name?: string;

  @IsString()
  @IsNotEmpty()
  phone?: string;

  @IsString()
  @IsNotEmpty()
  detail_address?: string;

  @IsInt()
  @IsNotEmpty()
  province_id?: number;

  @IsInt()
  @IsNotEmpty()
  district_id?: number;

  @IsInt()
  @IsNotEmpty()
  ward_id?: number;
}
