// mail.service.ts
import { Injectable, Logger } from "@nestjs/common";
import { InjectQueue } from "@nestjs/bull";
import { Queue } from "bull";
import { CreateMailDto } from "./dto/create-mail.dto";
import { MailerService } from "@nestjs-modules/mailer";

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);

  constructor(
    @InjectQueue("mail-queue") private readonly mailQueue: Queue,
    private readonly mailerService: MailerService
  ) {}

  async sendMail(data: CreateMailDto): Promise<boolean> {
    try {
      await this.mailQueue.add("send-email", {
        to: data.to,
        subject: data.subject,
        template: data.template,
        context: data.context,
      });
      this.logger.log(
        `Email job queued for ${data.to} with subject: ${data.subject}`
      );
      return true;
    } catch (error) {
      this.logger.error(
        `Failed to queue email job for ${data.to}: ${error.message}`,
        error.stack
      );
      return false;
    }
  }

  async sendMailNoJob(data: CreateMailDto): Promise<boolean> {
    try {
      await this.mailerService.sendMail({
        from: `TP Mobile Store <${process.env.ADMIN_EMAIL_ADDRESS}>`,
        to: data.to,
        subject: data.subject,
        template: data.template,
        context: data.context,
      });
      this.logger.log(
        `Send Email for ${data.to} with subject: ${data.subject}`
      );
      return true;
    } catch (error) {
      this.logger.error(
        `Send Email Failed to ${data.to}: ${error.message}`,
        error.stack
      );
      throw error;
    }
  }
}
