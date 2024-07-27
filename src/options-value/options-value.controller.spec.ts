import { Test, TestingModule } from '@nestjs/testing';
import { OptionsValueController } from './options-value.controller';
import { OptionsValueService } from './options-value.service';

describe('OptionsValueController', () => {
  let controller: OptionsValueController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [OptionsValueController],
      providers: [OptionsValueService],
    }).compile();

    controller = module.get<OptionsValueController>(OptionsValueController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
