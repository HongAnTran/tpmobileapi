import { Module } from '@nestjs/common';
import { RatingService } from './rating.service';
import { RatingController } from './rating.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [RatingController],
  providers: [PrismaService,RatingService],
})
export class RatingModule {}
