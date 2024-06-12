import { Module } from '@nestjs/common';
import { SpecificationsService } from './specifications.service';
import { SpecificationsController } from './specifications.controller';
import { PrismaService } from '../prisma.service';

@Module({
  controllers: [SpecificationsController],
  providers: [PrismaService,SpecificationsService],
})
export class SpecificationsModule {}
