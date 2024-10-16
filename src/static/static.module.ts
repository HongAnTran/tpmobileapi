import { Module } from '@nestjs/common';
import { StaticService } from './static.service';
import { StaticController } from './static.controller';
import { PrismaService } from 'src/prisma.service';
import { MulterModule } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { CloudinaryModule } from 'src/cloudinary/cloudinary.module';
@Module({
  imports: [MulterModule.register({
    storage: memoryStorage()
  }) , CloudinaryModule],

  controllers: [StaticController],
  providers: [StaticService,PrismaService],
  exports :[StaticService]
})
export class StaticModule {}
