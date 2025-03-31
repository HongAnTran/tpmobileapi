import { Test, TestingModule } from '@nestjs/testing';
import { RatingPublicController } from './rating-public.controller';
import { RatingPublicService } from './rating-public.service';

describe('RatingPublicController', () => {
  let controller: RatingPublicController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [RatingPublicController],
      providers: [RatingPublicService],
    }).compile();

    controller = module.get<RatingPublicController>(RatingPublicController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
