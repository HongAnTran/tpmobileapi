// redis.service.ts
import { Injectable } from "@nestjs/common";
import Redis from "ioredis";

@Injectable()
export class RedisService {
  private readonly redis: Redis;

  constructor() {
    this.redis = new Redis({
      host: process.env.REDIS_HOST || "localhost",
      port: Number(process.env.REDIS_PORT) || 6379,
      password: process.env.REDIS_PASSWORD || undefined,
    });
  }

  getRedisClient() {
    return this.redis;
  }

  async getByKey(key: string): Promise<string | null> {
    const value = await this.redis.get(key);
    return value ? JSON.parse(value) : null;
  }

  async setByKey(key: string, value: any, expireInSeconds?: number) {
    const jsonValue = JSON.stringify(value);
    await this.redis.set(key, jsonValue, "EX", expireInSeconds || 3600); // default 1 hour
  }

  async deleteByKey(key: string) {
    await this.redis.del(key);
  }

  async pushChatHistory(
    userId: number,
    message: { role: string; text: string }
  ) {
    const key = `chat:user:${userId}:history`;
    await this.redis.rpush(key, JSON.stringify(message));
    await this.redis.ltrim(key, -10, -1); // giữ lại 10 dòng cuối
  }

  async getNormalChatHistory(
    userId: number
  ): Promise<{ role: string; text: string }[]> {
    const key = `chat:user:${userId}:history`;
    const data = await this.redis.lrange(key, 0, -1);

    return data.map((json) => JSON.parse(json)).filter((msg) => !msg.isRemind);
  }

  async clearHistory(userId: number) {
    await this.redis.del(`chat:user:${userId}:history`);
  }
}
