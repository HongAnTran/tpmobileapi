// src/settings/dto/create-setting.dto.ts

import { IsString, IsOptional, IsJSON, IsNotEmpty, IsArray, IsBoolean } from 'class-validator';

export class CreateSettingDto {
  @IsString()
  @IsNotEmpty()
  key: string;

  @IsOptional()
  value?: any;

  @IsOptional()
  @IsString()
  description?: string;

  @IsBoolean()
  active?: boolean;

  @IsOptional()
  @IsArray()
  access_control?: number[];
}
