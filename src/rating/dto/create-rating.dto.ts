// src/ratings/dto/create-rating.dto.ts

import { IsInt, IsOptional, IsString, IsArray, ArrayNotEmpty, ArrayMaxSize } from 'class-validator';

export class CreateRatingDto {
  @IsInt()
  rate: number;

  @IsOptional()
  @IsString()
  content?: string;

  @IsOptional()
  @IsArray()
  @ArrayNotEmpty()
  @ArrayMaxSize(3)
  @IsString({ each: true })
  images?: string[];

  @IsInt()
  product_id: number;

  @IsInt()
  customer_id: number;
}