// src/settings/settings.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Setting } from '@prisma/client';
import { CreateSettingDto } from './dto/create-setting.dto';
import { UpdateSettingDto } from './dto/update-setting.dto';
import { ResponseList } from 'src/common/types/Common.type';

@Injectable()
export class SettingsService {
  constructor(private prisma: PrismaService) { }

  async create(createSettingDto: CreateSettingDto): Promise<Setting> {
    const { key, value, description } = createSettingDto;
    return this.prisma.setting.create({
      data: {
        key,
        value,
        description,
      },
    });
  }

  async findAll(): Promise<ResponseList<Setting>> {
    const [datas, total] = await Promise.all([this.prisma.setting.findMany(), this.prisma.setting.count()])
    return {
      datas,
      total
    }
  }

  async findOne(id: number): Promise<Setting | null> {
    const setting = await this.prisma.setting.findUnique({
      where: { id },
      include: { SettingHistory: true }
    });
    if (!setting) {
      throw new NotFoundException(`Setting with id ${id} not found`);
    }
    return setting;
  }

  async findOneKey(key: string): Promise<Setting | null> {
    const setting = await this.prisma.setting.findUnique({
      where: { key },
      include: { SettingHistory: true }

    });
    if (!setting) {
      throw new NotFoundException(`Setting with id ${key} not found`);
    }
    return setting;
  }

  async update(id: number, updateSettingDto: UpdateSettingDto): Promise<Setting> {
    const { value, description } = updateSettingDto;

    // Find the setting to be updated
    const setting = await this.prisma.setting.findUnique({
      where: { id },
    });

    if (!setting) {
      throw new NotFoundException(`Setting with id ${id} not found`);
    }



    // Perform the update
    const settingNew = await this.prisma.setting.update({
      where: { id },
      data: {
        value,
        description,
      },
    });



    // Save the current state to history
    await this.prisma.settingHistory.create({
      data: {
        updatedAt: new Date(),
        newValue: settingNew.value,
        oldValue: value,
        setting_id: setting.id,
      }
    });

    return settingNew
  }

  async remove(id: number): Promise<Setting> {
    return this.prisma.setting.delete({
      where: { id },
    });
  }
}
