import { IsEmail, IsNotEmpty } from "class-validator";

export class ChangePassDto {
  @IsNotEmpty()
  password: string;
  @IsNotEmpty()
  new_password: string;
}