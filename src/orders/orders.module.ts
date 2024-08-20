import { Module } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { OrdersController } from './orders.controller';
import { PrismaService } from '../prisma.service';
import { MailService } from 'src/mail/mail.service';
import { OrderCleanupService } from 'src/common/services/orderCleanup.service';
@Module({
  controllers: [OrdersController],
  providers: [MailService,PrismaService,OrdersService , OrderCleanupService],
})
export class OrdersModule {}
