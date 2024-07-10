import { Injectable } from '@nestjs/common';
import { MailerService } from '@nestjs-modules/mailer';
import { CreateMailDto } from './dto/create-mail.dto';

@Injectable()
export class MailService {
  constructor(private readonly mailerService: MailerService) { }


  async sendMail(data: CreateMailDto): Promise<boolean> {
    try {
      await this.mailerService.sendMail(data)
      return true
    } catch (error) {
      throw error
    }
  }
}