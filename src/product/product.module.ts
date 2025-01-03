import { Module } from '@nestjs/common';
import { ProductService } from './product.service';
import { ProductController } from './product.controller';
import { PrismaService } from '../prisma.service';
@Module({
  providers: [PrismaService,ProductService],
  controllers: [ProductController]
})
export class ProductModule {}
