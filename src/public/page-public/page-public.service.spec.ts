import { Test, TestingModule } from '@nestjs/testing';
import { PagePublicService } from './page-public.service';

describe('PagePublicService', () => {
  let service: PagePublicService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PagePublicService],
    }).compile();

    service = module.get<PagePublicService>(PagePublicService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
