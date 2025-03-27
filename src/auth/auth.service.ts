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
    const accessToken = this.jwtService.sign(
      { id: account.id, email: account.email },
      { expiresIn: "7d", secret: process.env.JWT_SECRET }
    );
    const refreshToken = this.jwtService.sign(
      { id: account.id },
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

  // async createPublic(createAccountDto: CreateAccountDto) {
  //   const { email, password, provider, name, birthday, gender, phone, avatar } =
  //     createAccountDto;
  //   const isExists = await this.accountService.findOneByEmail(email);
  //   if (isExists) {
  //     throw new BadRequestException("Email already exists");
  //   }
  //   const hashedPassword = await hashPassword(password);
  //   try {
  //     const account = await this.PrismaService.account.create({
  //       data: {
  //         email,
  //         password: hashedPassword,
  //         provider: provider || "local",
  //         account_roles: {
  //           create: {
  //             role: {
  //               connect: { code: ROLE_CODE_DEFAULT.PUBLIC },
  //             },
  //           },
  //         },
  //       },
  //     });

  //     const customer = await this.PrismaService.customer.create({
  //       data: {
  //         name,
  //         birthday,
  //         phone,
  //         email,
  //         gender,
  //         account_id: account.id,
  //       },
  //     });
  //     return customer;
  //   } catch (error) {
  //     throw new InternalServerErrorException("Failed to create account");
  //   }
  // }

  async getProfile(id: number) {
    const { password, ...res } = await this.PrismaService.account.findUnique({
      where: {
        id,
      },
      include: {
        user: true,
        roles: {
          include: {
            role: {
              include: {
                permission: {
                  select: {
                    permission: {
                      select: {
                        name: true,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    });
    return res;
  }
}
