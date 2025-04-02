import { IsEmail, IsNotEmpty } from "class-validator";

export class CreateSubscriptionPublicDto {
      @IsNotEmpty()
      @IsEmail()
      email: string;
}
