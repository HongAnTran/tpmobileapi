import { Module } from "@nestjs/common";
import { CategoryArticlePublicService } from "./category-article-public.service";
import { CategoryArticlePublicController } from "./category-article-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [CategoryArticlePublicController],
  providers: [CategoryArticlePublicService, PrismaService],
})
export class CategoryArticlePublicModule {}
