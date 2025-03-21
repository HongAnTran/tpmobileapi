import { Body, Controller, Post, UnauthorizedException } from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { AuthService } from "./auth.service";
import { Public } from "./jwt.guard";

@Controller("auth")
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post("login")
  async login(@Body() loginDto: LoginDto) {
    return this.authService.signIn(loginDto);
  }

  @Post("logout")
  async logout() {
    return this.authService.logout();
  }

  @Post("refresh")
  async refresh(@Body() { refreshToken }: { refreshToken: string }) {
    if (!refreshToken) {
      throw new UnauthorizedException();
    }
    return this.authService.refreshToken(refreshToken);
  }
}
