import {
  IsInt,
  IsOptional,
  IsString,
  IsArray,
  ArrayNotEmpty,
  ArrayMaxSize,
  IsNotEmpty,
} from "class-validator";

export class CreateRatingPublicDto {
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
}
