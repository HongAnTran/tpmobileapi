import { Module } from "@nestjs/common";
import { ProductPublicModule } from "./product-public/product-public.module";

@Module({
  imports: [ProductPublicModule],
})
export class PublicModule {}
