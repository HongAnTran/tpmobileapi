import { PartialType } from '@nestjs/swagger';
import { CreatePageDto } from './create-page.dto';

export class UpdatePageDto extends PartialType(CreatePageDto) {
  readonly title?: string;
  readonly content_html?: string;
  readonly short_description?: string;
  readonly meta_data?: Record<string, any>;
}