import { Module } from '@nestjs/common';
import { AttributePublicService } from './attribute-public.service';
import { AttributePublicController } from './attribute-public.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [AttributePublicController],
  providers: [AttributePublicService , PrismaService],
})
export class AttributePublicModule {}
