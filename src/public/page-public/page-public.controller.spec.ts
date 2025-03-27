import { Test, TestingModule } from '@nestjs/testing';
import { PagePublicController } from './page-public.controller';
import { PagePublicService } from './page-public.service';

describe('PagePublicController', () => {
  let controller: PagePublicController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PagePublicController],
      providers: [PagePublicService],
    }).compile();

    controller = module.get<PagePublicController>(PagePublicController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
