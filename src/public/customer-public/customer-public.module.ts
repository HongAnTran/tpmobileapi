import { Module } from "@nestjs/common";
import { CustomerPublicService } from "./customer-public.service";
import { CustomerPublicController } from "./customer-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [CustomerPublicController],
  providers: [CustomerPublicService, PrismaService],
})
export class CustomerPublicModule {}
