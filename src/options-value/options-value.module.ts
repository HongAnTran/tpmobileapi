import { Module } from '@nestjs/common';
import { OptionsValueService } from './options-value.service';
import { OptionsValueController } from './options-value.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [OptionsValueController],
  providers: [OptionsValueService,PrismaService],
})
export class OptionsValueModule {}
