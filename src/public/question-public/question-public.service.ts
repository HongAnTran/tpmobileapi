import { Injectable, NotFoundException } from "@nestjs/common";
import { CreateQuestionPublicDto } from "./dto/create-question-public.dto";
import { PrismaService } from "src/prisma.service";
import { TelebotService } from "src/telebot/telebot.service";
import { TELE_CHATID } from "src/common/config/config";
import { QuestionStatus } from "src/common/types/Questions.type";

@Injectable()
export class QuestionPublicService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly telegramService: TelebotService
  ) {}

  async create(createQuestionPublicDto: CreateQuestionPublicDto) {
    const { product_id, customer_id, ...res } = createQuestionPublicDto;
    const resuilt = await this.prismaService.question.create({
      data: {
        ...res,
        product: {
          connect: {
            id: product_id,
          },
        },
        customer: customer_id
          ? {
              connect: {
                id: customer_id,
              },
            }
          : undefined,
      },
      include: {
        product: {
          select: {
            title: true,
          },
        },
      },
    });
    const message = `Có câu hỏi mới trong ${resuilt.product.title} với nội dung: ${res.content}`;
    await this.telegramService.queueMessage(TELE_CHATID, message);
    return resuilt;
  }

  findAll(product_id: number) {
    return this.prismaService.question.findMany({
      where: {
        product_id: product_id,
        status: QuestionStatus.APPROVED,
      },
      include: {
        answers: {
          select: {
            id: true,
            content: true,
            created_at: true,
          },
        },
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

  async like(body: { questionId: number; like: boolean }) {
    const { questionId, like } = body;
    const question = await this.prismaService.question.findUnique({
      where: {
        id: questionId,
      },
    });
    if (!question) {
      throw new NotFoundException("Không tìm thấy câu hỏi");
    }
    if (like) {
      return this.prismaService.question.update({
        where: {
          id: questionId,
        },
        data: {
          like_count: question.like_count + 1,
        },
      });
    } else {
      return this.prismaService.question.update({
        where: {
          id: questionId,
        },
        data: {
          like_count: question.like_count - 1,
        },
      });
    }
  }

  async myQuestion(customerId: number) {
    return this.prismaService.question.findMany({
      where: {
        customer_id: customerId,
      },
      include: {
        product: {
          select: {
            title: true,
            slug: true,
            id: true,
            images: true,
            thumnail_url: true,
            price: true,
          },
        },
      },
    });
  }
}
