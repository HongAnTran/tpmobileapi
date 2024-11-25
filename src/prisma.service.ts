import { Injectable, OnModuleInit, OnModuleDestroy } from "@nestjs/common";
import { PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  // Kết nối Prisma khi ứng dụng khởi động
  async onModuleInit() {
    await this.$connect();
  }

  // Ngắt kết nối Prisma khi ứng dụng dừng
  async onModuleDestroy() {
    await this.$disconnect();
  }
}
