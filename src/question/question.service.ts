import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateQuestionDto } from './dto/create-question.dto';
import { UpdateQuestionDto } from './dto/update-question.dto';
import { Question } from '@prisma/client'; 
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class QuestionService {
  constructor(private readonly prisma: PrismaService) {}

  // async create(createQuestionDto: CreateQuestionDto): Promise<Question> {
  //   return this.prisma.question.create({
  //     data: {...createQuestionDto , },
  //   });
  // }

  async findAll(): Promise<Question[]> {
    return this.prisma.question.findMany({
      include: {
        answers: true, // Nếu bạn muốn lấy kèm các câu trả lời
      },
    });
  }

  async findOne(id: number): Promise<Question> {
    const question = await this.prisma.question.findUnique({
      where: { id },
      include: {
        answers: true, // Nếu bạn muốn lấy kèm các câu trả lời
      },
    });

    if (!question) {
      throw new NotFoundException(`Question with id ${id} not found`);
    }

    return question;
  }

  async update(id: number, updateQuestionDto: UpdateQuestionDto): Promise<Question> {
    const question = await this.findOne(id); // Kiểm tra xem câu hỏi có tồn tại không

    return this.prisma.question.update({
      where: { id: question.id },
      data: updateQuestionDto,
    });
  }

  async remove(id: number): Promise<Question> {
    const question = await this.findOne(id); // Kiểm tra xem câu hỏi có tồn tại không

    return this.prisma.question.delete({
      where: { id: question.id },
    });
  }
}
