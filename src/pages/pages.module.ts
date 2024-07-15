import { Module } from '@nestjs/common';
import { PagesService } from './pages.service';
import { PagesController } from './pages.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [PagesController],
  providers: [PrismaService,PagesService],
})
export class PagesModule {}
