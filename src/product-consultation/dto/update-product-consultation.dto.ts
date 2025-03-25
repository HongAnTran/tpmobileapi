import { PartialType } from '@nestjs/swagger';
import { CreateProductConsultationDto } from './create-product-consultation.dto';

export class UpdateProductConsultationDto extends PartialType(CreateProductConsultationDto) {}
