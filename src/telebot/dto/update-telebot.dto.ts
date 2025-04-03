import { PartialType } from '@nestjs/swagger';
import { CreateTelebotDto } from './create-telebot.dto';

export class UpdateTelebotDto extends PartialType(CreateTelebotDto) {}
