import { Module } from "@nestjs/common";
import { CustomerSystemModule } from "./system/customerSystem.module";

@Module({
  imports: [CustomerSystemModule],
  exports: [CustomerSystemModule],
})
export class CustomerModule {}
