import { PartialType } from '@nestjs/swagger';
import { CreateProductDto } from './create-product.dto';

export class UpdateArticleDto extends PartialType(CreateProductDto) {}
