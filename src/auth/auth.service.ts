import { Injectable, UnauthorizedException } from "@nestjs/common";
import { UsersService } from "../users/users.service";
import { LoginDto } from "./dto/login.dto";
import { AccountService } from "src/account/account.service";
import * as bcrypt from "bcrypt";
import { JwtService } from "@nestjs/jwt";

@Injectable()
export class AuthService {
  constructor(
    private readonly accountService: AccountService,
    private jwtService: JwtService
  ) {}

  async signIn(payload: LoginDto) {
    const profile = await this.accountService.findOneByEmail(payload.email);
    if (!profile) {
      throw new UnauthorizedException();
    }
    if (!bcrypt.compareSync(payload.password, profile.password)) {
      throw new UnauthorizedException();
    }
    const { password, ...result } = profile;
    const accessToken = this.jwtService.sign(
      { sub: profile.id, email: profile.email },
      { expiresIn: "1d", secret: process.env.JWT_SECRET }
    );
    const refreshToken = this.jwtService.sign(
      { sub: profile.id },
      { expiresIn: "30d", secret: process.env.JWT_REFRESH_SECRET }
    );
    return { profile: { email: result.email }, accessToken, refreshToken };
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
      const payload = this.jwtService.verify(refreshToken);
      const accessToken = this.jwtService.sign(
        { sub: payload.sub },
        { expiresIn: "30m" }
      );
      return { accessToken };
    } catch (error) {
      throw new UnauthorizedException();
    }
  }
}
