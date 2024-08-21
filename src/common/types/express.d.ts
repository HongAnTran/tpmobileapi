// src/types/express.d.ts
import { User } from '@prisma/client'; // Hoặc đường dẫn đúng đến kiểu User của bạn

declare global {
  namespace Express {
    interface Request {
      user?: User; // Hoặc kiểu chính xác cho người dùng của bạn
    }
  }
}
