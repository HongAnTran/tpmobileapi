import { Module } from '@nestjs/common';
import { PagePublicService } from './page-public.service';
import { PagePublicController } from './page-public.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [PagePublicController],
  providers: [PagePublicService , PrismaService],
})
export class PagePublicModule {}
