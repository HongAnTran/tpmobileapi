import { Injectable, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { OrdersService } from 'src/orders/orders.service';

@Injectable()
export class OrderCleanupService {
  private readonly logger = new Logger(OrderCleanupService.name);

  constructor(private readonly ordersService: OrdersService) {}

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  async handleCron() {
    try {
      const retentionDays = parseInt(process.env.DRAFT_ORDER_RETENTION_DAYS, 10) || 3;
      const result = await this.ordersService.removeDraftOrdersOlderThan(retentionDays);
      this.logger.log(`Deleted ${result.count} draft orders`);
    } catch (error) {
      this.logger.error('Failed to delete draft orders', error);
    }
  }
}
