import { Module } from '@nestjs/common';
import { ProductImageService } from './product-image.service';
import { ProductImageController } from './product-image.controller';
import { PrismaService } from 'src/prisma.service';
import { StaticService } from 'src/static/static.service';
import { CloudinaryService } from 'src/cloudinary/cloudinary.service';
@Module({
  controllers: [ProductImageController],
  providers: [ProductImageService,PrismaService ,StaticService , CloudinaryService],
})
export class ProductImageModule {}
