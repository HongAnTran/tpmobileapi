import { Test, TestingModule } from '@nestjs/testing';
import { OptionsValueService } from './options-value.service';

describe('OptionsValueService', () => {
  let service: OptionsValueService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [OptionsValueService],
    }).compile();

    service = module.get<OptionsValueService>(OptionsValueService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
