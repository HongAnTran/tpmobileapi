import { Module } from '@nestjs/common';
import { QuestionPublicService } from './question-public.service';
import { QuestionPublicController } from './question-public.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [QuestionPublicController],
  providers: [QuestionPublicService , PrismaService],
})
export class QuestionPublicModule {}
