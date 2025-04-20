import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Query,
  UseGuards,
  Req,
} from "@nestjs/common";
import { QuestionPublicService } from "./question-public.service";
import { CreateQuestionPublicDto } from "./dto/create-question-public.dto";
import { AuthCustomerGuard } from "../customer-auth/jwtCustomer.guard";

@Controller("public/questions")
export class QuestionPublicController {
  constructor(private readonly questionPublicService: QuestionPublicService) {}

  @Post()
  create(@Body() createQuestionPublicDto: CreateQuestionPublicDto) {
    return this.questionPublicService.create(createQuestionPublicDto);
  }

  @Get()
  findAll(@Query("product_id") product_id: string) {
    if (product_id) {
      return this.questionPublicService.findAll(+product_id);
    }

    throw new Error("product_id is required");
  }

  @Get("me")
  @UseGuards(AuthCustomerGuard)
  myQuestion(@Req() req: any) {
    const { id } = req.customer;
    return this.questionPublicService.myQuestion(id);
  }

  @Patch()
  like(@Body() body: { questionId: number; like: boolean }) {
    return this.questionPublicService.like(body);
  }
}
