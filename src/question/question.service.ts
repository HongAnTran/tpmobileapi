import { Injectable, NotFoundException } from "@nestjs/common";
import { CreateAnswerDto } from "./dto/create-answer";
import { Prisma, Question } from "@prisma/client";
import { PrismaService } from "src/prisma.service";
import { QuestionStatus } from "src/common/types/Questions.type";

@Injectable()
export class QuestionService {
  constructor(private readonly prisma: PrismaService) {}

  async reply(userId: number, createQuestionDto: CreateAnswerDto) {
    return this.prisma.answer.create({
      data: {
        content: createQuestionDto.content,
        question: {
          connect: { id: createQuestionDto.questionId },
        },
        author: {
          connect: { id: userId },
        },
      },
    });
  }

  async updateStatus(id: number, body: { status: QuestionStatus }) {
    const question = await this.prisma.question.findUnique({
      where: { id },
    });
    if (!question) {
      throw new NotFoundException(`Question with id ${id} not found`);
    }

    return this.prisma.question.update({
      where: { id },
      data: { status: body.status },
    });
  }

  async findAll(query: {
    page: number;
    limit: number;
    productId?: number;
    customerId?: number;
    status?: QuestionStatus;
  }) {
    const { page, limit, productId, customerId } = query;
    const skip = (page - 1) * limit; // Tính toán số bản ghi cần bỏ qua
    const take = limit; // Số bản ghi cần lấy

    const rows = await this.prisma.question.findMany({
      where: {
        product_id: productId ? productId : undefined, // Lọc theo productId nếu có
        customer_id: customerId ? customerId : undefined, // Lọc theo customerId nếu có
        status: query.status ? query.status : undefined, // Lọc theo status nếu có
      },
      skip,
      take,
      include: {
        answers: true,
        product: true,
      },
    });
    const count = await this.prisma.question.count({
      where: {
        product_id: productId ? productId : undefined, // Lọc theo productId nếu có
        customer_id: customerId ? customerId : undefined, // Lọc theo customerId nếu có
      },
    });
    return { rows, count };
  }

  async remove(id: number): Promise<Question> {
    return this.prisma.question.delete({
      where: { id },
    });
  }
}
