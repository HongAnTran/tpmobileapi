import { Module } from "@nestjs/common";
import { CategoryPublicService } from "./category-public.service";
import { CategoryPublicController } from "./category-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [CategoryPublicController],
  providers: [CategoryPublicService, PrismaService],
})
export class CategoryPublicModule {}
