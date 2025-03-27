import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from "@nestjs/common";
import { StoreService } from "./store.service";
import { Prisma } from "@prisma/client";
import { Public } from "src/common/decorator/public.decorator";

@Controller("store")
export class StoreController {
  constructor(private readonly storeService: StoreService) {}

  @Post()
  create(@Body() createStoreDto: Prisma.StoreCreateInput) {
    return this.storeService.create(createStoreDto);
  }

  @Public()
  @Get()
  async findAll(@Query() query: { latitude?: string; longitude?: string }) {
    const { latitude, longitude } = query;
    const stores = await this.storeService.findAll();
    // if (Number(latitude) && Number(longitude)) {
    //   const storesByDistance = this.storeService.sortStoresByDistance({
    //     latitude: Number(latitude),
    //     longitude: Number(longitude),
    //   },stores);

    //   return storesByDistance
    // }
    return stores;
  }
  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.storeService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateStoreDto: Prisma.StoreUpdateInput
  ) {
    return this.storeService.update(+id, updateStoreDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.storeService.remove(+id);
  }
}
