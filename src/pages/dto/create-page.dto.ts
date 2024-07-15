// src/pages/dto/create-page.dto.ts
export class CreatePageDto {
  readonly title: string;
  readonly slug: string;
  readonly content_html: string;
  readonly short_description?: string;
  readonly meta_data?: Record<string, any>;
}
