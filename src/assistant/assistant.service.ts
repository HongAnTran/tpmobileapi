import { Injectable, OnModuleInit } from "@nestjs/common";
import { GeminiService } from "./gemini.service";
import { RedisService } from "src/redis/redis.service";
import { Telegraf } from "telegraf";
import { Cron, CronExpression } from "@nestjs/schedule";
export interface ChatMessage {
  role: "user" | "model";
  text: string;
}

@Injectable()
export class AssistantService implements OnModuleInit {
  private bot: Telegraf;
  constructor(
    private readonly geminiService: GeminiService,
    private readonly redisService: RedisService
  ) {
    this.bot = new Telegraf(process.env.TELEGRAM_BOT_AN_TOKEN);
  }

  onModuleInit() {
    this.bot.start(async (ctx) => {
      ctx.reply("Xin chào! Tôi là Trợ Lý Ảo vui vẻ ✨. Gõ gì đó để bắt đầu!");
    });

    this.bot.help((ctx) => {
      ctx.reply(
        "Cứ hỏi tôi bất kỳ điều gì hoặc chờ tôi nhắc nhở hằng ngày nha!"
      );
    });

    this.bot.on("text", async (ctx) => {
      const userId = ctx.from.id;
      const text = ctx.message.text;

      const reply = await this.askAI(userId, text);
      await ctx.reply(reply);
    });
    this.bot.command("reset", async (ctx) => {
      await this.redisService.clearHistory(ctx.from.id);
      await ctx.reply("🧹 Lịch sử chat đã được làm sạch!");
    });
    this.bot.command("remind", async (ctx) => {
      const redisClient = this.redisService.getRedisClient();
      const userId = ctx.from.id.toString();
      const chatId = ctx.chat.id.toString();
      await redisClient.set(`user:${userId}:chatId`, chatId);
      await redisClient.sadd("reminder:recipients", userId);
      await ctx.reply(
        "📌 Bạn đã đăng ký nhận nhắc nhở mỗi ngày rồi nha! Tôi sẽ giúp bạn đúng giờ, đủ task 😸"
      );
    });

    this.bot.launch();
  }

  async sendMessage(chatId: number | string, message: string) {
    await this.bot.telegram.sendMessage(chatId, message);
  }

  async sendReminders(prompt: string) {
    const redisClient = this.redisService.getRedisClient();
    const userIds = await redisClient.smembers("reminder:recipients");

    if (userIds.length === 0) return;

    const aiResponse = await this.geminiService.generateText(prompt);

    for (const userId of userIds) {
      const chatId = await redisClient.get(`user:${userId}:chatId`);
      if (!chatId) continue;
      try {
        await this.sendMessage(chatId, `${aiResponse}`);
      } catch (err) {
        console.error(`Không gửi được cho ${userId} - ${chatId}:`, err.message);
      }
    }
  }

  async askAI(userId: number, userMessage: string): Promise<string> {
    await this.redisService.pushChatHistory(userId, {
      role: "user",
      text: userMessage,
    });

    const history = await this.redisService.getNormalChatHistory(userId);

    const geminiHistory = history.map((msg) => ({
      role: msg.role,
      parts: [{ text: msg.text }],
    }));

    const aiResponse = await this.geminiService.generateText(
      userMessage,
      geminiHistory
    );

    await this.redisService.pushChatHistory(userId, {
      role: "model",
      text: aiResponse,
    });

    return aiResponse;
  }

  isDayWorkTime() {
    const today = new Date().getDay();
    if (today === 0 || today === 6) return false;

    return true;
  }

  @Cron(CronExpression.EVERY_DAY_AT_8AM)
  async morningReminder() {
    const prompt = `
            Hãy viết một tin nhắn nhắc nhở không được nghỉ đột xuất đi làm đúng giờ, log time, và hoàn thành task với phong cách vui nhộn, sáng tạo, thân thiện.
            Ví dụ dùng emoji, ví von hài hước, tông tích cực.
            `;

    await this.sendReminders(prompt);
  }

  @Cron(CronExpression.EVERY_DAY_AT_5PM)
  async afternoonChecklist() {
    if (!this.isDayWorkTime()) return;
    const prompt = `
        Viết một tin nhắn nhắc nhở review code trước khi push, code kỹ, test kỹ, ít bug và nhớ log time. 
        Văn phong hài hước, dễ thương, thân thiện.
        `;
    await this.sendReminders(prompt);
  }

  @Cron("45 11 * * 1-5")
  async lunchReminder() {
    const prompt = `
    Viết một lời nhắc đi ăn trưa lúc 11h45 với phong cách hài hước, dễ thương, thân thiện.
    Ví dụ: “⏰ Đã đến giờ nạp năng lượng! Đừng để bụng đói bug nhé 😸🍱”
  `;
    await this.sendReminders(prompt);
  }

  @Cron("0 9-17/2 * * 1-5") // 9h, 11h, 13h, 15h, 17h từ T2 đến T6
  async drinkWaterReminder() {
    const prompt = `
    Viết một lời nhắc nhở uống nước với phong cách hài hước, dễ thương, có thể dùng emoji.
    Ví dụ: "💧 Uống miếng nước đi nè bạn ơi! Đừng để cơ thể khô như code thiếu comment nha 😅"
  `;

    await this.sendReminders(prompt);
  }

  @Cron("30 10,15 * * 1-5") // 10:30 và 15:30 T2 đến T6
  async breakReminder() {
    const prompt = `
    Viết một lời nhắc nhở hãy nghỉ ngơi vài phút để thư giãn rồi làm việc tiếp, giọng điệu vui vẻ, thân thiện.
    Ví dụ: “🧘‍♂️ Nghỉ xíu nạp lại năng lượng nha~ Đừng để stress bug vô tâm hồn 😌”
  `;

    await this.sendReminders(prompt);
  }
}
