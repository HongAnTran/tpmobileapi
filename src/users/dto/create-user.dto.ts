// src/users/dto/create-user.dto.ts

import { IsString, IsOptional, IsInt, IsJSON  } from 'class-validator';

export class CreateUserDto {
  @IsString()
  name: string;

  @IsString()
  password: string;

  @IsString()
  username: string;

  @IsOptional()
  @IsString()
  avt?: string;

  @IsInt()
  roleId: number;

  @IsOptional()
  @IsJSON()
  meta_data?: any;
}
