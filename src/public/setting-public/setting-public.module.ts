import { Module } from "@nestjs/common";
import { SettingPublicService } from "./setting-public.service";
import { SettingPublicController } from "./setting-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [SettingPublicController],
  providers: [SettingPublicService, PrismaService],
})
export class SettingPublicModule {}
