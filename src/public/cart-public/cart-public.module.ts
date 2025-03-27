import { Module } from '@nestjs/common';
import { CartPublicService } from './cart-public.service';
import { CartPublicController } from './cart-public.controller';

@Module({
  controllers: [CartPublicController],
  providers: [CartPublicService],
})
export class CartPublicModule {}
