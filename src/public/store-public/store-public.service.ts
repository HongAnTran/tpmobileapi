import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class StorePublicService {
  constructor(private prisma: PrismaService) {}

  async findAll() {
    return this.prisma.store.findMany({
      select: {
        id: true,
        detail_address: true,
        name: true,
        phone: true,
        url_map: true,
      },
    });
  }
}
