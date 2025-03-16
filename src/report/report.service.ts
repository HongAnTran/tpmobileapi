import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma.service";
import { DashboardReportDto } from "./dto/dashboad-report.dto";
import { OrderStatus } from "src/common/types/Order.type";

@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  async reportDashboard(query: DashboardReportDto) {
    const { startDate, endDate } = query;
    const condition = {
      created_at: {
        gte: new Date(startDate),
        lte: endDate ? new Date(endDate) : new Date(),
      },
    };
    const conditionOrder = {
      ...condition,
      status: { not: OrderStatus.DRAFT },
    };
    const totalOrders = await this.prisma.order.count({
      where: conditionOrder,
    });
    const totalRevenue = await this.prisma.order.aggregate({
      _sum: {
        total_price: true,
      },
      where: conditionOrder,
    });
    const completedOrders = await this.prisma.order.count({
      where: {
        ...condition,
        status: OrderStatus.SUCCESS,
      },
    });

    const totalUsers = await this.prisma.user.count({
      where: condition,
    });

    return {
      totalOrders,
      completedOrders,
      totalRevenue: totalRevenue._sum.total_price || 0,
      totalUsers,
    };
  }
}
