import { PartialType } from '@nestjs/swagger';
import { CreateRatingDto } from './create-rating.dto';
import { IsOptional, IsInt, IsString, IsArray, ArrayMaxSize } from 'class-validator';

export class UpdateRatingDto extends PartialType(CreateRatingDto) {
  @IsOptional()
  @IsInt()
  rate?: number;

  @IsOptional()
  @IsString()
  content?: string;

  @IsOptional()
  @IsArray()
  @ArrayMaxSize(3) // Giả định giới hạn tối đa 10 ảnh
  @IsString({ each: true })
  images?: string[];

  @IsOptional()
  @IsInt()
  like_count?: number;
}
