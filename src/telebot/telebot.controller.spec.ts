import { Test, TestingModule } from '@nestjs/testing';
import { TelebotController } from './telebot.controller';
import { TelebotService } from './telebot.service';

describe('TelebotController', () => {
  let controller: TelebotController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TelebotController],
      providers: [TelebotService],
    }).compile();

    controller = module.get<TelebotController>(TelebotController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
