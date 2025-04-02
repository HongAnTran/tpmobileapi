import { Injectable } from '@nestjs/common';
import { CreateSubscriptionPublicDto } from './dto/create-subscription-public.dto';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class SubscriptionPublicService {
  constructor(
    private readonly prismaService: PrismaService, 
  ) {}

  create(createSubscriptionPublicDto: CreateSubscriptionPublicDto) {
    return this.prismaService.promotionSubscription.create({
      data: createSubscriptionPublicDto,
    });
  }
}
