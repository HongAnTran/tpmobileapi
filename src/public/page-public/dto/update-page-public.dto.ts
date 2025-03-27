import { PartialType } from '@nestjs/mapped-types';
import { CreatePagePublicDto } from './create-page-public.dto';

export class UpdatePagePublicDto extends PartialType(CreatePagePublicDto) {}
