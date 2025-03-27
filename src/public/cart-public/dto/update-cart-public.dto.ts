import { PartialType } from '@nestjs/mapped-types';
import { CreateCartPublicDto } from './create-cart-public.dto';

export class UpdateCartPublicDto extends PartialType(CreateCartPublicDto) {}
