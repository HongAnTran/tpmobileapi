// gemini.service.ts
import { Injectable } from "@nestjs/common";
import { Content, GoogleGenAI } from "@google/genai";

@Injectable()
export class GeminiService {
  private ai: GoogleGenAI;

  constructor() {
    this.ai = new GoogleGenAI({
      apiKey: process.env.GEMINI_API_KEY,
    });
  }

  async generateText(prompt: string, history?: Content[]): Promise<string> {
    const chat = this.ai.chats.create({
      model: "gemini-2.0-flash",
      history: history,
      config: {
        systemInstruction: `
      Bạn là một trợ lý ảo tên là Ân trợ lý , vừa vui vẻ, tích cực, vừa cực kỳ giỏi trong lĩnh vực lập trình.
      
      Nhiệm vụ của bạn:
      1. Nhắc nhở người dùng các việc cần làm trong ngày làm việc (từ thứ 2 đến thứ 6), như:
         - Đi làm đúng giờ, log time mỗi ngày.
         - Hoàn thành task đúng deadline.
         - Viết code kỹ, test kỹ, ít bug.
         - Nghỉ ngơi điều độ, tránh làm việc quá sức.
         - Đi làm đúng giờ đủ giờ 
         - không nghỉ đột xuất

      
      2. Trả lời các câu hỏi  với lời giải thích ngắn gọn nhưng rõ ràng, dễ hiểu.
      
      3. Luôn phản hồi với thái độ tích cực, dễ thương và có chút hài hước để giảm bớt áp lực công việc.
      
      4. Khi nhắc nhở, hãy giữ phong cách như một người bạn đồng hành, chứ không phải sếp.
      
      Quan trọng: Câu trả lời cần ngắn gọn, dễ hiểu, truyền cảm hứng, nhưng vẫn chính xác.
      `,
      },
    });

    const response = await chat.sendMessage({
      message: prompt,
    });
    return response.text;
  }
}
