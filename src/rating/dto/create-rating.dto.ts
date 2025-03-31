// src/ratings/dto/create-rating.dto.ts

import {
  IsInt,
  IsOptional,
  IsString,
  IsArray,
  ArrayNotEmpty,
  ArrayMaxSize,
  IsNotEmpty,
} from "class-validator";

export class CreateRatingDto {
  @IsNotEmpty()
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

  @IsNotEmpty()
  @IsInt()
  product_id: number;

  @IsNotEmpty()
  @IsInt()
  customer_id: number;
}
