import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { SubscriptionsService } from "./subscriptions.service";
import { UpdateSubscriptionDto } from "./dto/update-subscription.dto";

@Controller("subscriptions")
export class SubscriptionsController {
  constructor(private readonly subscriptionsService: SubscriptionsService) {}

  @Get()
  findAll() {
    return this.subscriptionsService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.subscriptionsService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateSubscriptionDto: UpdateSubscriptionDto
  ) {
    return this.subscriptionsService.update(+id, updateSubscriptionDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.subscriptionsService.remove(+id);
  }
}
