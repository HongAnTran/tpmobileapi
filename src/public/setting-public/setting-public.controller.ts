import { Controller, Get, Param } from "@nestjs/common";
import { SettingPublicService } from "./setting-public.service";

@Controller("public/settings")
export class SettingPublicController {
  constructor(private readonly settingPublicService: SettingPublicService) {}

  @Get("key/:id")
  findOneKey(@Param("id") key: string) {
    return this.settingPublicService.findOneKey(key);
  }
}
