import { Test, TestingModule } from '@nestjs/testing';
import { CustomerPublicController } from './customer-public.controller';
import { CustomerPublicService } from './customer-public.service';

describe('CustomerPublicController', () => {
  let controller: CustomerPublicController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CustomerPublicController],
      providers: [CustomerPublicService],
    }).compile();

    controller = module.get<CustomerPublicController>(CustomerPublicController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
