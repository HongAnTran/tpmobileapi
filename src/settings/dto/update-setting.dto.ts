import { PartialType } from '@nestjs/swagger';
import { CreateSettingDto } from './create-setting.dto';
import { IsArray, IsBoolean, IsJSON, IsOptional, IsString } from 'class-validator';

export class UpdateSettingDto {


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
