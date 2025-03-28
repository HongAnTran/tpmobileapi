// src/users/dto/create-user.dto.ts

import { IsString, IsOptional, IsInt, IsJSON  } from 'class-validator';

export class CreateUserDto {
  @IsString()
  name: string;

  @IsString()
  email: string;

  @IsString()
  password: string;

  @IsOptional()
  @IsString()
  avatar?: string;

  @IsOptional()
  @IsInt()
  roleId?: number;

  @IsOptional()
  @IsJSON()
  meta_data?: any;
}
