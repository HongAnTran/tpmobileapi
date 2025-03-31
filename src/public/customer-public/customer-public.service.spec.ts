import { Test, TestingModule } from '@nestjs/testing';
import { CustomerPublicService } from './customer-public.service';

describe('CustomerPublicService', () => {
  let service: CustomerPublicService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CustomerPublicService],
    }).compile();

    service = module.get<CustomerPublicService>(CustomerPublicService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
