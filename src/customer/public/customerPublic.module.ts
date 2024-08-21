// src/customer/user/customer.module.ts
import { Module } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service'; // Đảm bảo rằng PrismaService được cung cấp ở mức ứng dụng chính
import { AddressService } from './services/address.service';
import { AddressController } from './controllers/address.controller';
import { JwtAuthGuard } from './auth/jwt.guard';
@Module({
  imports: [],
  controllers: [ AddressController],
  providers: [AddressService, PrismaService , JwtAuthGuard],
  exports: [AddressService], // Export service nếu cần sử dụng ở các module khác
})
export class CustomerPublicModule { }
