import { Module } from "@nestjs/common";
import { OrdersService } from "./orders.service";
import { OrdersController } from "./orders.controller";
import { PrismaService } from "../prisma.service";
import { OrderCleanupService } from "src/common/services/orderCleanup.service";
import { SettingsService } from "src/settings/settings.service";
import { MailModule } from "src/mail/mail.module";
@Module({
  imports: [MailModule],
  controllers: [OrdersController],
  providers: [
    PrismaService,
    OrdersService,
    OrderCleanupService,
    SettingsService,
  ],
})
export class OrdersModule {}
