import { Injectable, UnauthorizedException } from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { AccountService } from "src/account/account.service";
import * as bcrypt from "bcrypt";
import { JwtService } from "@nestjs/jwt";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class AuthService {
  constructor(
    private readonly accountService: AccountService,
    private jwtService: JwtService,
    private PrismaService: PrismaService
  ) {}

  async signIn(payload: LoginDto) {
    const account = await this.accountService.findOneByEmail(payload.email);
    if (!account) {
      throw new UnauthorizedException();
    }
    if (!bcrypt.compareSync(payload.password, account.password)) {
      throw new UnauthorizedException();
    }
    const { user} = account;
    const accessToken = this.jwtService.sign(
      { id: user.id  , roles : account.roles.map((role) => role.code) },
      { expiresIn: "1d", secret: process.env.JWT_SECRET }
    );
    const refreshToken = this.jwtService.sign(
      { id: user.id },
      { expiresIn: "30d", secret: process.env.JWT_REFRESH_SECRET }
    );
    return { accessToken, refreshToken };
  }

  async logout() {
    return { message: "Logout successfully" };
  }

  async validateUser(email: string, pass: string) {
    const user = await this.accountService.findOneByEmail(email);
    if (user && bcrypt.compareSync(pass, user.password)) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async refreshToken(refreshToken: string) {
    try {
      const payload = this.jwtService.verify(refreshToken,{
        secret: process.env.JWT_REFRESH_SECRET,
      });
      const account = await this.accountService.findOne(payload.id);

      const accessToken = this.jwtService.sign(
        { id: account.user_id  , roles : account.roles.map((role) => role.code) },
        { expiresIn: "1d", secret: process.env.JWT_SECRET }
      );
      return { accessToken };
    } catch (error) {
      throw new UnauthorizedException();
    }
  }

  async getProfile(id: number) {
    const res = await this.PrismaService.user.findUnique({
      where: {
        id,
      },
      include: {
        account:{
          select:{
            status: true,
            email: true,
            roles: {
              select: {
                code: true,
              },
            },
          }
        }
      },
    });
    return res;
  }
}
