import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { QuestionPublicService } from './question-public.service';
import { CreateQuestionPublicDto } from './dto/create-question-public.dto';
import { UpdateQuestionPublicDto } from './dto/update-question-public.dto';

@Controller('public/questions')
export class QuestionPublicController {
  constructor(private readonly questionPublicService: QuestionPublicService) {}

  @Post()
  create(@Body() createQuestionPublicDto: CreateQuestionPublicDto) {
    return this.questionPublicService.create(createQuestionPublicDto);
  }

  @Get()
  findAll(@Query('product_id') product_id: string) {
    if (product_id) {
      return this.questionPublicService.findAll(+product_id);
    }

    throw new Error('product_id is required');
    
  }

}
