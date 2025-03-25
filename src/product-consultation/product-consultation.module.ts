import { Module } from "@nestjs/common";
import { ProductConsultationService } from "./product-consultation.service";
import { ProductConsultationController } from "./product-consultation.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [ProductConsultationController],
  providers: [ProductConsultationService, PrismaService],
})
export class ProductConsultationModule {}
