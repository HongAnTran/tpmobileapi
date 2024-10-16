import { Module } from '@nestjs/common';
import { ProductImageService } from './product-image.service';
import { ProductImageController } from './product-image.controller';
import { PrismaService } from 'src/prisma.service';
import { StaticModule } from 'src/static/static.module';
@Module({
  controllers: [ProductImageController],
  providers: [ProductImageService,PrismaService ,StaticModule],
})
export class ProductImageModule {}
