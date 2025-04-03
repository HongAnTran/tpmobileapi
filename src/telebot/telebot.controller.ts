import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { TelebotService } from './telebot.service';
import { CreateTelebotDto } from './dto/create-telebot.dto';
import { UpdateTelebotDto } from './dto/update-telebot.dto';

@Controller('telebot')
export class TelebotController {
  constructor(private readonly telebotService: TelebotService) {}

 
}
