import { Test, TestingModule } from '@nestjs/testing';
import { ProductConsultationController } from './product-consultation.controller';
import { ProductConsultationService } from './product-consultation.service';

describe('ProductConsultationController', () => {
  let controller: ProductConsultationController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProductConsultationController],
      providers: [ProductConsultationService],
    }).compile();

    controller = module.get<ProductConsultationController>(ProductConsultationController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
