// telebot.service.ts
import { Injectable } from '@nestjs/common';
import { InjectQueue } from '@nestjs/bull';
import { Queue } from 'bull';
import { Telegraf } from 'telegraf';

@Injectable()
export class TelebotService {
  private bot: Telegraf;

  constructor(
    @InjectQueue('telegram-queue') private readonly telegramQueue: Queue,
  ) {
    // Khởi tạo bot với token từ BotFather
    this.bot = new Telegraf(process.env.TELEBOT_TOKEN); // Thay bằng token của bạn
  }

  // Hàm gửi tin nhắn trực tiếp (dùng để test hoặc gọi ngay lập tức)
  async sendMessage(chatId: string, message: string) {
    try {
      await this.bot.telegram.sendMessage(chatId, message);
      console.log(`Tin nhắn đã được gửi đến ${chatId}: ${message}`);
    } catch (error) {
      console.error('Lỗi khi gửi tin nhắn:', error);
      throw error;
    }
  }

  // Hàm đẩy công việc gửi tin nhắn vào Bull Queue
  async queueMessage(chatId: string, message: string) {
    try {
      await this.telegramQueue.add(
        'send-telegram-message', // Tên job
        { chatId, message }, // Dữ liệu gửi vào queue
        {
          attempts: 3, // Số lần thử lại nếu thất bại
          backoff: 5000, // Thời gian chờ giữa các lần thử lại (5 giây)
        },
      );
      console.log(`Đã thêm job gửi tin nhắn vào queue cho ${chatId}`);
    } catch (error) {
      console.error('Lỗi khi thêm job vào queue:', error);
      throw error;
    }
  }
}