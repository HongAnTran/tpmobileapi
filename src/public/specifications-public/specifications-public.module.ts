import { Module } from '@nestjs/common';
import { SpecificationsPublicService } from './specifications-public.service';
import { SpecificationsPublicController } from './specifications-public.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [SpecificationsPublicController],
  providers: [SpecificationsPublicService , PrismaService],
})
export class SpecificationsPublicModule {}
