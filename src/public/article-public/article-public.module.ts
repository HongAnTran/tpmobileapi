import { Module } from "@nestjs/common";
import { ArticlePublicService } from "./article-public.service";
import { ArticlePublicController } from "./article-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [ArticlePublicController],
  providers: [ArticlePublicService, PrismaService],
})
export class ArticlePublicModule {}
