import { Module } from "@nestjs/common";
import { ConsultationPublicService } from "./consultation-public.service";
import { ConsultationPublicController } from "./consultation-public.controller";
import { PrismaService } from "src/prisma.service";
import { TelebotModule } from "src/telebot/telebot.module";

@Module({
  imports: [TelebotModule],
  controllers: [ConsultationPublicController],
  providers: [ConsultationPublicService, PrismaService],
})
export class ConsultationPublicModule {}
