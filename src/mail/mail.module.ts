// mail.module.ts
import { Module } from "@nestjs/common";
import { BullModule } from "@nestjs/bull";
import { MailService } from "./mail.service";
import { MailProcessor } from "./mail.processor";

@Module({
  imports: [
    BullModule.forRoot({
      redis: {
        host: "localhost",
        port: parseInt(process.env.REDIS_PORT) || 6379,
        password: process.env.REDIS_PASSWORD || undefined,
      },
    }),
    BullModule.registerQueue({
      name: "mail-queue",
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
  providers: [MailService, MailProcessor],
  exports: [MailService, BullModule],
})
export class MailModule {}
