import { Module } from "@nestjs/common";
import { ProductPublicModule } from "./product-public/product-public.module";
import { OrderPublicModule } from "./order-public/order-public.module";
import { CategoryPublicModule } from "./category-public/category-public.module";
import { ArticlePublicModule } from "./article-public/article-public.module";
import { CategoryArticlePublicModule } from "./category-article-public/category-article-public.module";
import { SettingPublicModule } from "./setting-public/setting-public.module";
import { StorePublicModule } from "./store-public/store-public.module";
import { CartPublicModule } from "./cart-public/cart-public.module";
import { CustomerAuthModule } from "./customer-auth/customer-auth.module";
import { PagePublicModule } from "./page-public/page-public.module";
import { AttributePublicModule } from "./attribute-public/attribute-public.module";
import { SpecificationsPublicModule } from "./specifications-public/specifications-public.module";
import { ConsultationPublicModule } from './consultation-public/consultation-public.module';
import { RatingPublicModule } from './rating-public/rating-public.module';
import { CustomerPublicModule } from './customer-public/customer-public.module';

@Module({
  imports: [
    ProductPublicModule,
    OrderPublicModule,
    CategoryPublicModule,
    ArticlePublicModule,
    CategoryArticlePublicModule,
    SettingPublicModule,
    StorePublicModule,
    CartPublicModule,
    CustomerAuthModule,
    PagePublicModule,
    AttributePublicModule,
    SpecificationsPublicModule,
    ConsultationPublicModule,
    RatingPublicModule,
    CustomerPublicModule,
  ],
})
export class PublicModule {}
