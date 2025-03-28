import { Module } from '@nestjs/common';
import { SettingsService } from './settings.service';
import { SettingsController } from './settings.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [SettingsController],
  providers: [PrismaService,SettingsService],
})
export class SettingsModule {}
