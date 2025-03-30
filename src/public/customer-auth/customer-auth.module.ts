import { Module } from "@nestjs/common";
import { CustomerAuthService } from "./customer-auth.service";
import { CustomerAuthController } from "./customer-auth.controller";
import { PrismaService } from "src/prisma.service";
import { MailModule } from "src/mail/mail.module";

@Module({
  imports: [MailModule],
  controllers: [CustomerAuthController],
  providers: [CustomerAuthService, PrismaService],
})
export class CustomerAuthModule {}
