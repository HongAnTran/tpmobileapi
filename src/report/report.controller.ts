import { Controller, Get, Query, BadRequestException } from "@nestjs/common";
import { ReportService } from "./report.service";
import { DashboardReportDto } from "./dto/dashboad-report.dto";

@Controller("report")
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  @Get("dashboard")
  findAll(@Query() query: DashboardReportDto) {
    if (!query.startDate) {
      throw new BadRequestException("startDate is required");
    }

    return this.reportService.reportDashboard(query);
  }
}
