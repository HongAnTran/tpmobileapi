import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
} from "@nestjs/common";
import { AccountService } from "./account.service";
import { CreateAccountDto } from "./dto/create-account.dto";
import { UpdateAccountDto } from "./dto/update-account.dto";
import { Public } from "src/common/decorator/public.decorator";

@Controller("account")
export class AccountController {
  constructor(private readonly accountService: AccountService) {}

  @Public()
  @Post("register-public")
  create(@Body() createAccountDto: CreateAccountDto) {
    return this.accountService.createPublic(createAccountDto);
  }

  @Get("profile")
  profile(@Req() req: any) {
    const userId = req.user.id;
    return this.accountService.findOne(userId);
  }
  @Get()
  findAll() {
    return this.accountService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.accountService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateAccountDto: UpdateAccountDto) {
    return this.accountService.update(+id, updateAccountDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.accountService.remove(+id);
  }
}
