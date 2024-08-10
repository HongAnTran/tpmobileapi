import { Module } from '@nestjs/common';
import { StaticService } from './static.service';
import { StaticController } from './static.controller';
import { PrismaService } from 'src/prisma.service';
import { MulterModule } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
@Module({
  imports: [MulterModule.register({
    storage: memoryStorage()
  })],

  controllers: [StaticController],
  providers: [StaticService,PrismaService],
})
export class StaticModule {}
