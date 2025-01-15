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
    const user = await this.accountService.findOneByEmail(payload.email);
    if (!user) {
      throw new UnauthorizedException();
    }
    if (!bcrypt.compareSync(payload.password, user.password)) {
      throw new UnauthorizedException();
    }
    const { password, ...result } = user;
    const accessToken = this.jwtService.sign(
      { sub: user.id, email: user.email },
      { expiresIn: "30m", secret: process.env.JWT_SECRET }
    );
    const refreshToken = this.jwtService.sign(
      { sub: user.id },
      { expiresIn: "30d", secret: process.env.JWT_REFRESH_SECRET }
    );
    return { user: result, accessToken, refreshToken };
  }
}
