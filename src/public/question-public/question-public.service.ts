import { Injectable } from '@nestjs/common';
import { CreateQuestionPublicDto } from './dto/create-question-public.dto';
import { PrismaService } from 'src/prisma.service';
import { TelebotService } from 'src/telebot/telebot.service';
import { TELE_CHATID } from 'src/common/config/config';

@Injectable()
export class QuestionPublicService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly telegramService: TelebotService
  ) {}

 async create(createQuestionPublicDto: CreateQuestionPublicDto) {
    const {product_id,customer_id ,...res} = createQuestionPublicDto;
    const resuilt = await this.prismaService.question.create({
      data: {
        ...res,
        product: {
          connect: {
            id: product_id,
          },
        },
        customer: customer_id ? {
          connect: {
            id: customer_id,
          },
        } : undefined,
      },
      include:{
        product:{
          select:{
            title: true,
          }
        }
      }
    })
    const message = `Có câu hỏi mới trong ${resuilt.product.title} với nội dung: ${res.content}`;
     await this.telegramService.queueMessage(TELE_CHATID, message)
    return resuilt
  }

  findAll(product_id: number) {
    return this.prismaService.question.findMany({
      where: {
        product_id: product_id,
      },
      include: {
        customer: {
          select: {
            full_name: true,
            phone: true,
            email: true,
            avatar: true,
            gender: true,
          },
        },
      },
    });
  }
}
