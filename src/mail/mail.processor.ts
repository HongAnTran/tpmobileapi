// mail.processor.ts
import { Processor, Process } from "@nestjs/bull";
import { Job } from "bull";
import { MailerService } from "@nestjs-modules/mailer"; 
import { Logger } from "@nestjs/common";

@Processor("mail-queue")
export class MailProcessor {
  private readonly logger = new Logger(MailProcessor.name);

  constructor(private readonly mailerService: MailerService) {}

  @Process("send-email")
  async handleSendEmail(job: Job) {
    const { to, subject, template, context } = job.data;
    try {
      await this.mailerService.sendMail({
        from: process.env.ADMIN_EMAIL_ADDRESS,
        to,
        subject,
        template,
        context,
      });

      this.logger.log(
        `Email sent successfully to ${to} with subject: ${subject}`
      );
    } catch (error) {
      this.logger.error(
        `Failed to send email to ${to}: ${error.message}`,
        error.stack
      );
      throw error;
    }
  }
}
