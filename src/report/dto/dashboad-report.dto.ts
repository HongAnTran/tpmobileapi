import { IsDate, IsOptional, IsNotEmpty } from "class-validator";
import { Type } from "class-transformer";

export class DashboardReportDto {
  @IsNotEmpty()
  @Type(() => Date)
  @IsDate()
  startDate: Date;

  @IsOptional()
  @Type(() => Date)
  @IsDate()
  endDate?: Date;
}
