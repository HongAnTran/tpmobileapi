import { PartialType } from "@nestjs/swagger";
import { CreateAccountDto } from "../../auth/dto/create-account.dto";

export class UpdateAccountDto extends PartialType(CreateAccountDto) {}
