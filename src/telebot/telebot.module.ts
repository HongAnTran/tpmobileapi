// telebot.module.ts
import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { TelebotService } from './telebot.service';
import { TelebotProcessor } from './telebot.processor';

@Module({
  imports: [
    BullModule.registerQueue({
      name: "telegram-queue",
      limiter: {
        max: 10,
        duration: 1000,
      },
      settings: {
        maxStalledCount: 3,
      },
      defaultJobOptions: {
        removeOnComplete: true,
        removeOnFail: false,
        attempts: 3,
        backoff: 5000,
      },
    }),
  ],
  providers: [TelebotService,TelebotProcessor],
  exports: [TelebotService],
})
export class TelebotModule {}