import { Test, TestingModule } from '@nestjs/testing';
import { QuestionPublicController } from './question-public.controller';
import { QuestionPublicService } from './question-public.service';

describe('QuestionPublicController', () => {
  let controller: QuestionPublicController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [QuestionPublicController],
      providers: [QuestionPublicService],
    }).compile();

    controller = module.get<QuestionPublicController>(QuestionPublicController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
