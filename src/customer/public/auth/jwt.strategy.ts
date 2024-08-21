import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private prisma: PrismaService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET, // Thay đổi secret key cho bảo mật
    });
  }

  async validate(payload: any) {
    const customer = await this.prisma.customer.findUnique({ where: { id: payload.sub } });
    if (!customer) {
      return null;
    }
    return { id: customer.id, email: customer.email };
  }
}
