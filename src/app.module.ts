import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { ProductModule } from './product/product.module';
import { PrismaService } from './prisma.service';
import { CategoryProductModule } from './category-product/category-product.module';
import { UsersModule } from './users/users.module';
import { SpecificationsModule } from './specifications/specifications.module';
import { ArticleModule } from './article/article.module';
import { CategoryArticleModule } from "./category-article/category-article.module"
import { ProductVariantModule } from './product-variant/product-variant.module';
import { OptionsModule } from './options/options.module';
@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    ProductModule,
    CategoryProductModule,
    UsersModule,
    SpecificationsModule,
    ArticleModule,
    CategoryArticleModule,
    ProductVariantModule,
    OptionsModule
  ],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule { }  
