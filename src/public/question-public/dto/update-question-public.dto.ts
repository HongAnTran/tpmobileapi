import { PartialType } from '@nestjs/mapped-types';
import { CreateQuestionPublicDto } from './create-question-public.dto';

export class UpdateQuestionPublicDto extends PartialType(CreateQuestionPublicDto) {}
