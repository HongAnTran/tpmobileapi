import { Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";
import { JwtModule } from "@nestjs/jwt";
import { AuthGuard } from "./jwt.guard";
import { APP_GUARD } from "@nestjs/core";
import { AccountService } from "src/account/account.service";
import { PrismaService } from "src/prisma.service";
import { AccountModule } from "src/account/account.module";

@Module({
  imports: [
    AccountModule,
    JwtModule.register({
      global: true,
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: "60s" },
    }),
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AuthModule {}
