import { Test, TestingModule } from '@nestjs/testing';
import { QuestionPublicService } from './question-public.service';

describe('QuestionPublicService', () => {
  let service: QuestionPublicService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [QuestionPublicService],
    }).compile();

    service = module.get<QuestionPublicService>(QuestionPublicService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
