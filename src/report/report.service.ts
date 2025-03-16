import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/prisma.service";
import { DashboardReportDto } from "./dto/dashboad-report.dto";
import { OrderStatus } from "src/common/types/Order.type";

@Injectable()
export class ReportService {
  constructor(private prisma: PrismaService) {}

  async reportDashboard(query: DashboardReportDto) {
    const { startDate, endDate } = query;

    const totalOrders = await this.prisma.order.count({
      where: {
        created_at: {
          gte: new Date(startDate),
          lte: endDate ? new Date(endDate) : new Date(),
        },
      },
    });

    const totalRevenue = await this.prisma.order.aggregate({
      _sum: {
        total_price: true,
      },
      where: {
        created_at: {
          gte: new Date(startDate),
          lte: endDate ? new Date(endDate) : new Date(),
        },
      },
    });
    const completedOrders = await this.prisma.order.count({
      where: {
        status: OrderStatus.SUCCESS,
        created_at: {
          gte: new Date(startDate),
          lte: endDate ? new Date(endDate) : new Date(),
        },
      },
    });

    const totalUsers = await this.prisma.user.count({
      where: {
        created_at: {
          gte: new Date(startDate),
          lte: endDate ? new Date(endDate) : new Date(),
        },
      },
    });

    return {
      totalOrders,
      completedOrders,
      totalRevenue: totalRevenue._sum.total_price || 0,
      totalUsers,
    };
  }
}
