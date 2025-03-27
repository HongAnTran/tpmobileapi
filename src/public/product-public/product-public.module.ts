import { Module } from "@nestjs/common";
import { ProductPublicService } from "./product-public.service";
import { ProductPublicController } from "./product-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [ProductPublicController],
  providers: [ProductPublicService, PrismaService],
})
export class ProductPublicModule {}
