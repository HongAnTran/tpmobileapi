import { Injectable, OnModuleInit, OnModuleDestroy } from "@nestjs/common";
import { PrismaClient } from "@prisma/client";

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  // Kết nối Prisma khi ứng dụng khởi động
  async onModuleInit() {
    try {
      await this.$connect();
    } catch (error) {
      console.log(error);
    }
  }

  // Ngắt kết nối Prisma khi ứng dụng dừng
  async onModuleDestroy() {
    await this.$disconnect();
  }
}
