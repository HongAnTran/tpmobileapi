import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtStrategy } from './jwt.strategy';
import { PrismaService } from 'src/prisma.service';

@Module({
  imports: [
    JwtModule.register({
      secret: process.env.JWT_SECRET, 
      signOptions: { expiresIn: "3d" }, 
    }),
  ],
  providers: [AuthService, JwtStrategy,PrismaService],
  controllers: [AuthController],
  exports: [AuthService],
})
export class AuthModule {}
