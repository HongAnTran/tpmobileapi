import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from 'src/prisma.service';

@Injectable()
export class PagePublicService {
  constructor(private readonly prisma: PrismaService) {}


   async findOneBySlug(slug: string) {
     const page = await this.prisma.page.findUnique({
       where: { slug },
     });
     if (!page) {
       throw new NotFoundException(`Page with id ${slug} not found`);
     }
     return page;
   }
}
