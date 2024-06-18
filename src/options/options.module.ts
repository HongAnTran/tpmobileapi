import { Module } from '@nestjs/common';
import { OptionsService } from './options.service';
import { OptionsController } from './options.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [OptionsController],
  providers: [PrismaService,OptionsService],
})
export class OptionsModule {}
