import {
  Controller,
  Get,
  Query,
  BadRequestException,
  UseGuards,
} from "@nestjs/common";
import { ReportService } from "./report.service";
import { DashboardReportDto } from "./dto/dashboad-report.dto";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("report")
@UseGuards(AuthGuard)
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
