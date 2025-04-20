import { IsInt, IsOptional, IsString } from "class-validator";

export class UpdateFileDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsInt()
  folder_id?: number;
}
