import { Test, TestingModule } from '@nestjs/testing';
import { ProductConsultationService } from './product-consultation.service';

describe('ProductConsultationService', () => {
  let service: ProductConsultationService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ProductConsultationService],
    }).compile();

    service = module.get<ProductConsultationService>(ProductConsultationService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
