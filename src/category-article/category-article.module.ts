import { Module } from '@nestjs/common';
import { CategoryArticleController } from './category-article.controller';
import { CategoryArticleService } from './category-article.service';
import { PrismaService } from '../prisma.service';

@Module({
  controllers: [CategoryArticleController],
  providers: [PrismaService,CategoryArticleService]
})
export class CategoryArticleModule {}
