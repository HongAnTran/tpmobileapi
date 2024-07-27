import { Module } from '@nestjs/common';
import { ProductImageService } from './product-image.service';
import { ProductImageController } from './product-image.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [ProductImageController],
  providers: [ProductImageService,PrismaService],
})
export class ProductImageModule {}
