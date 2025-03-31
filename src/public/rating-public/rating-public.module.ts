import { Module } from "@nestjs/common";
import { RatingPublicService } from "./rating-public.service";
import { RatingPublicController } from "./rating-public.controller";
import { PrismaService } from "src/prisma.service";

@Module({
  controllers: [RatingPublicController],
  providers: [RatingPublicService, PrismaService],
})
export class RatingPublicModule {}
