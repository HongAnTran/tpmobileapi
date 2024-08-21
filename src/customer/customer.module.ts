import { Module } from '@nestjs/common';
import { CustomerPublicModule } from './public/customerPublic.module';
import { CustomerSystemModule } from './system/customerSystem.module';

@Module({
  imports: [CustomerSystemModule, CustomerPublicModule],
  exports: [CustomerSystemModule, CustomerPublicModule], 
  
})
export class CustomerModule {}
