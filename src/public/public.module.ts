import { Module } from "@nestjs/common";
import { ProductPublicModule } from "./product-public/product-public.module";
import { OrderPublicModule } from './order-public/order-public.module';
import { CategoryPublicModule } from './category-public/category-public.module';
import { ArticlePublicModule } from './article-public/article-public.module';
import { CategoryArticlePublicModule } from './category-article-public/category-article-public.module';
import { SettingPublicModule } from './setting-public/setting-public.module';
import { StorePublicModule } from './store-public/store-public.module';
import { CartPublicModule } from './cart-public/cart-public.module';
import { CustomerAuthModule } from './customer-auth/customer-auth.module';
import { PagePublicModule } from './page-public/page-public.module';

@Module({
  imports: [ProductPublicModule, OrderPublicModule, CategoryPublicModule, ArticlePublicModule, CategoryArticlePublicModule, SettingPublicModule, StorePublicModule, CartPublicModule, CustomerAuthModule, PagePublicModule],
})
export class PublicModule {}
