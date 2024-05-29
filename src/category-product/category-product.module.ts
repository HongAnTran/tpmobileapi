import { Module } from '@nestjs/common';
import { CategoryProductController } from './category-product.controller';
import { CategoryProductService } from './category-product.service';
import { PrismaService } from '../prisma.service';

@Module({
  controllers: [CategoryProductController],
  providers: [PrismaService,CategoryProductService]
})
export class CategoryProductModule {}
