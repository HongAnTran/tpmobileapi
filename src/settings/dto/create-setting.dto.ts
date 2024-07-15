// src/settings/dto/create-setting.dto.ts
export class CreateSettingDto {
  readonly key: string;
  readonly value: any;
  readonly description?: string;
}
