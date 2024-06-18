import { Module } from '@nestjs/common';
import { ProductVariantService } from './product-variant.service';
import { ProductVariantController } from './product-variant.controller';
import { PrismaService } from '../prisma.service';

@Module({
  controllers: [ProductVariantController],
  providers: [PrismaService,ProductVariantService],
})
export class ProductVariantModule {}
