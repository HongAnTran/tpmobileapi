// src/pages/pages.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Page } from '@prisma/client';
import { CreatePageDto } from './dto/create-page.dto';
import { UpdatePageDto } from './dto/update-page.dto';

@Injectable()
export class PagesService {
  constructor(private prisma: PrismaService) { }

  async create(createPageDto: CreatePageDto): Promise<Page> {
    const { title, slug, content_html, meta_data } = createPageDto;
    return this.prisma.page.create({
      data: {
        title,
        slug,
        content_html,
        meta_data,
      },
    });
  }

  async findAll(): Promise<Page[]> {
    return this.prisma.page.findMany();
  }

  async findOne(id: number): Promise<Page | null> {
    const page = await this.prisma.page.findUnique({
      where: { id },
    });
    if (!page) {
      throw new NotFoundException(`Page with id ${id} not found`);
    }
    return page;
  }

  async findOneBySlug(slug: string): Promise<Page | null> {
    const page = await this.prisma.page.findUnique({
      where: { slug },
    });
    if (!page) {
      throw new NotFoundException(`Page with id ${slug} not found`);
    }
    return page;
  }

  async update(id: number, updatePageDto: UpdatePageDto): Promise<Page> {
    return this.prisma.page.update({
      where: { id },
      data: updatePageDto,
    });
  }

  async remove(id: number): Promise<Page> {
    return this.prisma.page.delete({
      where: { id },
    });
  }
}
