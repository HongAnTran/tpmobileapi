import { IsInt, IsOptional, IsString } from "class-validator";

export class UpdateFolderDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsInt()
  parent_id?: number;
}
