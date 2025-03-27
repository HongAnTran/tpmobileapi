import { Injectable, UnauthorizedException } from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { PrismaService } from "src/prisma.service";
import { JwtService } from "@nestjs/jwt";
import * as bcrypt from "bcrypt";

@Injectable()
export class CustomerAuthService {
  constructor(
    private jwtService: JwtService,
    private prismaService: PrismaService
  ) {}
  async signIn(payload: LoginDto) {
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
    });
    if (!account) {
      throw new UnauthorizedException();
    }
    if (!bcrypt.compareSync(payload.password, account.password)) {
      throw new UnauthorizedException();
    }
    const accessToken = this.jwtService.sign(
      { id: account.id, email: account.email },
      { expiresIn: "30d", secret: process.env.JWT_SECRET }
    );
    return { accessToken };
  }

  async logout() {
    return { message: "Logout successfully" };
  }
}
