import { Module } from '@nestjs/common';
import { CustomerSystemService } from './services/customerSystem.service';
import { CustomerSystemController } from './controllers/customerSystem.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [CustomerSystemController],
  providers: [PrismaService,CustomerSystemService],
  exports: [CustomerSystemService],
})
export class CustomerSystemModule {}
