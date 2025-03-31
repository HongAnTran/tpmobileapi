import { PartialType } from '@nestjs/mapped-types';
import { CreateConsultationPublicDto } from './create-consultation-public.dto';

export class UpdateConsultationPublicDto extends PartialType(CreateConsultationPublicDto) {}
