import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SubscriptionPublicService } from './subscription-public.service';
import { CreateSubscriptionPublicDto } from './dto/create-subscription-public.dto';

@Controller('subscription-public')
export class SubscriptionPublicController {
  constructor(private readonly subscriptionPublicService: SubscriptionPublicService) {}

  @Post()
  create(@Body() createSubscriptionPublicDto: CreateSubscriptionPublicDto) {
    return this.subscriptionPublicService.create(createSubscriptionPublicDto);
  }

  
}
