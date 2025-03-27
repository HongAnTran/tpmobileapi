import { Controller, Get, Query } from "@nestjs/common";
import { StorePublicService } from "./store-public.service";

@Controller("public/stores")
export class StorePublicController {
  constructor(private readonly storePublicService: StorePublicService) {}

  @Get()
  async findAll(@Query() query: { latitude?: string; longitude?: string }) {
    const { latitude, longitude } = query;
    const stores = await this.storePublicService.findAll();

    return stores;
  }
}
