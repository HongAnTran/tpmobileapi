import { Test, TestingModule } from '@nestjs/testing';
import { AttributeValuesService } from './attributes-value.service';

describe('AttributesValueService', () => {
  let service: AttributeValuesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AttributeValuesService],
    }).compile();

    service = module.get<AttributeValuesService>(AttributeValuesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});