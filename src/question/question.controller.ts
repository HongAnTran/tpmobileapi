import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
  Req,
  Query,
} from "@nestjs/common";
import { QuestionService } from "./question.service";
import { CreateAnswerDto } from "./dto/create-answer";
import { UpdateQuestionDto } from "./dto/update-question.dto";
import { AuthGuard } from "src/auth/jwt.guard";
import { AuthenticatedRequest } from "src/common/types/Auth.type";

@Controller("question")
@UseGuards(AuthGuard)
export class QuestionController {
  constructor(private readonly questionService: QuestionService) {}

  @Post("reply")
  create(@Req() req: AuthenticatedRequest,@Body() createQuestionDto: CreateAnswerDto) {
    const userId = req.user.id; // Lấy userId từ request
    return this.questionService.create(userId,createQuestionDto);
  }

  @Get()
  findAll(@Query() query: { page: string; limit: string , productId?: string , customerId?: string}) {
    const page = parseInt(query.page) || 1; // Chuyển đổi sang số nguyên, mặc định là 1
    const limit = parseInt(query.limit) || 50; // Chuyển đổi sang số nguyên, mặc định là 50
    const productId = query.productId ? parseInt(query.productId) : undefined; // Chuyển đổi sang số nguyên nếu có
    const customerId = query.customerId ? parseInt(query.customerId) : undefined; // Chuyển đổi sang số nguyên nếu có
    return this.questionService.findAll({ page, limit, productId, customerId });
  }



  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.questionService.remove(+id);
  }
}
