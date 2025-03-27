import { Module } from "@nestjs/common";
import { OrderPublicService } from "./order-public.service";
import { OrderPublicController } from "./order-public.controller";
import { MailService } from "src/mail/mail.service";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [OrderPublicController],
  providers: [OrderPublicService, MailService, PrismaService],
})
export class OrderPublicModule {}
