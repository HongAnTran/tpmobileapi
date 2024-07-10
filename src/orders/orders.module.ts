import { Module } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { OrdersController } from './orders.controller';
import { PrismaService } from '../prisma.service';
import { MailService } from 'src/mail/mail.service';
@Module({
  controllers: [OrdersController],
  providers: [MailService,PrismaService,OrdersService],
})
export class OrdersModule {}
