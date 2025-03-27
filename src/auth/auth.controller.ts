import {
  Body,
  Controller,
  Get,
  Post,
  Req,
  UnauthorizedException,
  UseGuards,
} from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { AuthService } from "./auth.service";
import { Public } from "src/common/decorator/public.decorator";
import { AuthenticatedRequest } from "src/common/types/Auth.type";
import { AuthGuard } from "./jwt.guard";

@Controller("auth")
@UseGuards(AuthGuard)
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get("profile")
  profile(@Req() req: AuthenticatedRequest) {
    const userId = req.user.id;
    return this.authService.getProfile(userId);
  }
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
