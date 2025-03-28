import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { PagePublicService } from './page-public.service';

@Controller('public/pages')
export class PagePublicController {
  constructor(private readonly pagePublicService: PagePublicService) {}
  @Get("slug/:slug")
  findOneBySlug(@Param("slug") slug: string) {
    return this.pagePublicService.findOneBySlug(slug);
  }
}
