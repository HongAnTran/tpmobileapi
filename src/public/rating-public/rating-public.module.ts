import { Module } from '@nestjs/common';
import { RatingPublicService } from './rating-public.service';
import { RatingPublicController } from './rating-public.controller';

@Module({
  controllers: [RatingPublicController],
  providers: [RatingPublicService],
})
export class RatingPublicModule {}
