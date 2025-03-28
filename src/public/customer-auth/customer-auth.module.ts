import { Module } from '@nestjs/common';
import { CustomerAuthService } from './customer-auth.service';
import { CustomerAuthController } from './customer-auth.controller';
import { PrismaService } from 'src/prisma.service';
import { MailService } from 'src/mail/mail.service';

@Module({
  controllers: [CustomerAuthController],
  providers: [CustomerAuthService , PrismaService , MailService],
})
export class CustomerAuthModule {}
