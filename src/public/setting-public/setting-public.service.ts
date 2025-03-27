import { Injectable, NotFoundException } from "@nestjs/common";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class SettingPublicService {
  constructor(private prisma: PrismaService) {}

  async findOneKey(key: string) {
    const setting = await this.prisma.setting.findUnique({
      where: { key },
    });
    if (!setting) {
      throw new NotFoundException(`Setting with id ${key} not found`);
    }
    return setting;
  }
}
