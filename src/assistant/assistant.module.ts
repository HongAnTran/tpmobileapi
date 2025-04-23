import { Module } from "@nestjs/common";
import { AssistantService } from "./assistant.service";
import { RedisModule } from "src/redis/redis.module";
import { GeminiService } from "./gemini.service";

@Module({
  imports: [RedisModule],
  providers: [AssistantService, GeminiService],
})
export class AssistantModule {}
