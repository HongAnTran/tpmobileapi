import { Module } from '@nestjs/common';
import { QuestionPublicService } from './question-public.service';
import { QuestionPublicController } from './question-public.controller';
import { PrismaService } from 'src/prisma.service';
import { TelebotModule } from 'src/telebot/telebot.module';

@Module({
  imports: [TelebotModule],
  controllers: [QuestionPublicController],
  providers: [QuestionPublicService , PrismaService],
})
export class QuestionPublicModule {}
