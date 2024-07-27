import { PartialType } from '@nestjs/swagger';
import { CreateOptionsValueDto } from './create-options-value.dto';

export class UpdateOptionsValueDto extends PartialType(CreateOptionsValueDto) {}
