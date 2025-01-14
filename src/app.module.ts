import { Module } from "@nestjs/common";
import { join } from "path";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { ConfigModule } from "@nestjs/config";
import { ProductModule } from "./product/product.module";
import { PrismaService } from "./prisma.service";
import { CategoryProductModule } from "./category-product/category-product.module";
import { UsersModule } from "./users/users.module";
import { SpecificationsModule } from "./specifications/specifications.module";
import { ArticleModule } from "./article/article.module";
import { CategoryArticleModule } from "./category-article/category-article.module";
import { ProductVariantModule } from "./product-variant/product-variant.module";
import { OrdersModule } from "./orders/orders.module";
import { MailerModule } from "@nestjs-modules/mailer";
import { PugAdapter } from "@nestjs-modules/mailer/dist/adapters/pug.adapter";
import { PagesModule } from "./pages/pages.module";
import { SettingsModule } from "./settings/settings.module";
import { CartsModule } from "./carts/carts.module";
import { LocationModule } from "./location/location.module";
import { CustomerModule } from "./customer/customer.module";
import { StoreModule } from "./store/store.module";
import { RatingModule } from "./rating/rating.module";
import { QuestionModule } from "./question/question.module";
import { BrandModule } from "./brand/brand.module";
import { TagsModule } from "./tags/tags.module";
import { ProductImageModule } from "./product-image/product-image.module";
import { AttributesModule } from "./attributes/attributes.module";
import { AttributesValueModule } from "./attributes-value/attributes-value.module";
import { ProductAttributesModule } from "./product-attributes/product-attributes.module";
import { StaticModule } from "./static/static.module";
import { ServeStaticModule } from "@nestjs/serve-static";
import { ScheduleModule } from "@nestjs/schedule";
import { CloudinaryModule } from "./cloudinary/cloudinary.module";
import { SentryModule } from "@sentry/nestjs/setup";

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MailerModule.forRoot({
      transport: {
        host: "smtp.gmail.com",
        port: 465,
        secure: true,
        auth: {
          type: "OAuth2",
          user: process.env.ADMIN_EMAIL_ADDRESS,
          clientId: process.env.GOOGLE_MAILER_CLIENT_ID,
          clientSecret: process.env.GOOGLE_MAILER_CLIENT_SECRET,
          refreshToken: process.env.GOOGLE_MAILER_REFRESH_TOKEN,
        },
      },
      template: {
        dir: join(__dirname, "..", "src", "templates"),
        adapter: new PugAdapter({
          inlineCssEnabled: true,
        }),
        options: {
          strict: true,
        },
      },
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, "..", process.env.STATIC_FOLDER),
      serveRoot: `/${process.env.STATIC_FOLDER}`,
    }),
    ScheduleModule.forRoot(),
    SentryModule.forRoot(),
    ProductModule,
    CategoryProductModule,
    UsersModule,
    SpecificationsModule,
    ArticleModule,
    CategoryArticleModule,
    ProductVariantModule,
    OrdersModule,
    PagesModule,
    SettingsModule,
    CartsModule,
    LocationModule,
    CustomerModule,
    StoreModule,
    RatingModule,
    QuestionModule,
    BrandModule,
    TagsModule,
    ProductImageModule,
    AttributesModule,
    AttributesValueModule,
    ProductAttributesModule,
    StaticModule,
    CloudinaryModule,
  ],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
