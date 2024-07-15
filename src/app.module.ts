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
import { OrdersModule } from './orders/orders.module';
import { MailerModule } from '@nestjs-modules/mailer';
import { PugAdapter } from '@nestjs-modules/mailer/dist/adapters/pug.adapter';
import { join } from 'path';
import { PagesModule } from './pages/pages.module';
import { SettingsModule } from './settings/settings.module';
import { CartsModule } from './carts/carts.module';




const GOOGLE_MAILER_CLIENT_ID = '807787170087-2g0d336qe2qbou3ilms5gr505o3durto.apps.googleusercontent.com'
const GOOGLE_MAILER_CLIENT_SECRET = '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'
const GOOGLE_MAILER_REFRESH_TOKEN = '1//04j5pqvYDQBahCgYIARAAGAQSNwF-L9IrmY0gRSylpwPU1R-xKM5QZyXalEIlVEyItvHeru-4ccPdqfxigmFTc1VDDvaWkOd7Zb0'
const ADMIN_EMAIL_ADDRESS = 'tranhongankrn.2001@gmail.com'

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MailerModule.forRoot({
      transport: {
        host: 'smtp.gmail.com',
        port: 465,
        secure: true, // true for 465, false for other ports
        auth: {
          type  : "OAuth2",
          user  : ADMIN_EMAIL_ADDRESS,
          clientId  : GOOGLE_MAILER_CLIENT_ID,
          clientSecret  : GOOGLE_MAILER_CLIENT_SECRET,
          refreshToken :GOOGLE_MAILER_REFRESH_TOKEN,
        },
      },
      template: {
        dir: join(__dirname, '..', 'src', 'templates'),
        adapter: new PugAdapter({
          inlineCssEnabled: true,
        }),
        options: {
          strict: true,
        },
      },
    }),
    ProductModule,
    CategoryProductModule,
    UsersModule,
    SpecificationsModule,
    ArticleModule,
    CategoryArticleModule,
    ProductVariantModule,
    OptionsModule,
    OrdersModule,
    PagesModule,
    SettingsModule,
    CartsModule
  ],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule { }  
