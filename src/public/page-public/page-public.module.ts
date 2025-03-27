import { Module } from '@nestjs/common';
import { PagePublicService } from './page-public.service';
import { PagePublicController } from './page-public.controller';

@Module({
  controllers: [PagePublicController],
  providers: [PagePublicService],
})
export class PagePublicModule {}
