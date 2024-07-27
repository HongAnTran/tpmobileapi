import { Module } from '@nestjs/common';
import { AttributeValuesService } from './attributes-value.service';
import { AttributeValuesController } from './attributes-value.controller';
import { PrismaService } from 'src/prisma.service';
@Module({
  controllers: [AttributeValuesController],
  providers: [AttributeValuesService,PrismaService],
})
export class AttributesValueModule {}
