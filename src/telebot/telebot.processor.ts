// telebot.processor.ts
import { Process, Processor } from '@nestjs/bull';
import { Job } from 'bull';
import { Telegraf } from 'telegraf';

@Processor('telegram-queue') // Tên queue phải khớp với cấu hình
export class TelebotProcessor {
  private bot: Telegraf;

  constructor() {
    this.bot = new Telegraf(process.env.TELEBOT_TOKEN); // Thay bằng token của bạn
  }

  @Process('send-telegram-message') // Tên job phải khớp với lúc thêm vào queue
  async handleSendMessage(job: Job<{ chatId: string; message: string }>) {
    const { chatId, message } = job.data;
    try {
      await this.bot.telegram.sendMessage(chatId, message);
      console.log(`Đã gửi tin nhắn từ queue đến ${chatId}: ${message}`);
    } catch (error) {
      console.error('Lỗi khi xử lý job gửi tin nhắn:', error);
      throw error; // Nếu lỗi, Bull sẽ thử lại theo cấu hình
    }
  }
}