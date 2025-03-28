import { Module } from "@nestjs/common";
import { join } from "path";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { ConfigModule } from "@nestjs/config";
import { PrismaService } from "./prisma.service";
import { MailerModule } from "@nestjs-modules/mailer";
import { PugAdapter } from "@nestjs-modules/mailer/dist/adapters/pug.adapter";
import { ServeStaticModule } from "@nestjs/serve-static";
import { ScheduleModule } from "@nestjs/schedule";
import { SentryModule } from "@sentry/nestjs/setup";
import { PublicModule } from "./public/public.module";
import { PrivateModule } from "./private/private.module";
import { JwtModule } from "@nestjs/jwt";

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MailerModule.forRoot({
      transport: {
        host: "smtp.zoho.com",
        port: 465,
        secure: true,
        auth: {
          user: process.env.ADMIN_EMAIL_ADDRESS,
          pass: process.env.ADMIN_EMAIL_PASSWORD, // Mật khẩu hoặc App Password
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
        JwtModule.register({
          global: true,
          secret: process.env.JWT_SECRET,
          signOptions: { expiresIn: "30m" },
        }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, "..", process.env.STATIC_FOLDER),
      serveRoot: `/${process.env.STATIC_FOLDER}`,
    }),
    ScheduleModule.forRoot(),
    SentryModule.forRoot(),
    PrivateModule,
    PublicModule,
  ],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
