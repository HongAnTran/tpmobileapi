import { Test, TestingModule } from '@nestjs/testing';
import { RatingPublicService } from './rating-public.service';

describe('RatingPublicService', () => {
  let service: RatingPublicService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [RatingPublicService],
    }).compile();

    service = module.get<RatingPublicService>(RatingPublicService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
