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

  @Cron('0 9 17 * *') // 9h sáng ngày 17 hàng tháng
  async handleSendMailAt9AM() {
    await this.handleSendMail();
  }

  @Cron('0 12 17 * *') // 10h sáng ngày 17 hàng tháng
  async handleSendMailAt12AM() {
    await this.handleSendMail();
  }

  @Cron('0 0 17 * *') // 11h sáng ngày 17 hàng tháng
  async handleSendMailAt0AM() {
    await this.handleSendMail();
  }

  private async handleSendMail() {
    try {
      const result = await this.ordersService.sendMailRemind();
      this.logger.log(`result`, result);
    } catch (error) {
      this.logger.error('Failed to handleSendMail', error);
    }
  }
}
