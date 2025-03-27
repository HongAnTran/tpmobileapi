import { Test, TestingModule } from '@nestjs/testing';
import { CartPublicController } from './cart-public.controller';
import { CartPublicService } from './cart-public.service';

describe('CartPublicController', () => {
  let controller: CartPublicController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CartPublicController],
      providers: [CartPublicService],
    }).compile();

    controller = module.get<CartPublicController>(CartPublicController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
