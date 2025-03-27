import { Module } from "@nestjs/common";
import { StorePublicService } from "./store-public.service";
import { StorePublicController } from "./store-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [StorePublicController],
  providers: [StorePublicService, PrismaService],
})
export class StorePublicModule {}
