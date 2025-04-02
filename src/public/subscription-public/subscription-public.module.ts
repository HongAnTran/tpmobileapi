import { Module } from '@nestjs/common';
import { SubscriptionPublicService } from './subscription-public.service';
import { SubscriptionPublicController } from './subscription-public.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [SubscriptionPublicController],
  providers: [SubscriptionPublicService , PrismaService],
})
export class SubscriptionPublicModule {}
