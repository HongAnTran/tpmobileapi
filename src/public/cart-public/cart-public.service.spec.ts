import { Test, TestingModule } from '@nestjs/testing';
import { CartPublicService } from './cart-public.service';

describe('CartPublicService', () => {
  let service: CartPublicService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CartPublicService],
    }).compile();

    service = module.get<CartPublicService>(CartPublicService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
