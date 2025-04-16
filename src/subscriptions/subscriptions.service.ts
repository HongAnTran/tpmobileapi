import { Injectable } from "@nestjs/common";
import { CreateSubscriptionDto } from "./dto/create-subscription.dto";
import { UpdateSubscriptionDto } from "./dto/update-subscription.dto";
import { PrismaService } from "../prisma.service";

@Injectable()
export class SubscriptionsService {
  constructor(private prisma: PrismaService) {}

  async findAll() {
    return await this.prisma.promotionSubscription.findMany();
  }

  async findOne(id: number) {
    return await this.prisma.promotionSubscription.findUnique({
      where: { id },
    });
  }

  async update(id: number, updateSubscriptionDto: UpdateSubscriptionDto) {
    return await this.prisma.promotionSubscription.update({
      where: { id },
      data: {
        isActive: updateSubscriptionDto.isActive,
      },
    });
  }

  async remove(id: number) {
    return await this.prisma.promotionSubscription.delete({
      where: { id },
    });
  }
}
