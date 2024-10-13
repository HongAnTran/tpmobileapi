import { IsInt, IsNotEmpty, IsOptional, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateCartDto {

  @IsInt()
  @IsOptional()
  userId: number;

  // @IsOptional()
  // @IsArray()
  // @ValidateNested({ each: true })
  // @Type(() => CartItemDto) // Assuming CartItemDto is another DTO for cart items
  // items?: CartItemDto[];

  // Other fields based on your Cart model
}
