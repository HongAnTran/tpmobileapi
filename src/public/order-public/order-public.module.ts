import { Module } from "@nestjs/common";
import { OrderPublicService } from "./order-public.service";
import { OrderPublicController } from "./order-public.controller";
import { PrismaService } from "src/prisma.service";
import { MailModule } from "src/mail/mail.module";

@Module({
  imports: [MailModule],
  controllers: [OrderPublicController],
  providers: [OrderPublicService, PrismaService],
})
export class OrderPublicModule {}
