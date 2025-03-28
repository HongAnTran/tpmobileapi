import { Injectable, UnauthorizedException } from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { PrismaService } from "src/prisma.service";
import { JwtService } from "@nestjs/jwt";
import * as bcrypt from "bcrypt";
import { RegisterDto } from "./dto/register.dto";
import { hashPassword } from "src/common/helper/hassPassword";
import { MailService } from "src/mail/mail.service";

@Injectable()
export class CustomerAuthService {
  constructor(
    private jwtService: JwtService,
    private prismaService: PrismaService,
    private mailService : MailService

  ) {}
  async signIn(payload: LoginDto) {
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
      include:{
        customer: true,
      }
    });
    if (!account ) {
      throw new UnauthorizedException("Not found account");
    }
    if (!bcrypt.compareSync(payload.password, account.password)) {
      throw new UnauthorizedException("Password is incorrect");
    }
    if(!account.active){
      // how to chage status of account to active
      throw new UnauthorizedException("NOT_ACTIVE_ACCOUNT");
    }
    const { customer  } = account;
    const accessToken = this.jwtService.sign(
      { id: customer.id, email: customer.email },
      { expiresIn: "30d", secret: process.env.JWT_SECRET_VERIFY }
    );
    return { accessToken };
  }
  async register(payload  :RegisterDto){
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
    });
    if (account) {
      throw new UnauthorizedException("Email already exists");
    }
    const { password , email , provider , ...res } = payload;
    const hashPass = await hashPassword(password);


    const active_token =   this.jwtService.sign(
      { email: email, password: hashPass },
      { expiresIn: "30d", secret: process.env.JWT_SECRET_VERIFY }
    )

    const newAccount = await this.prismaService.customerAccount.create({
      data: {
        email: email,
        password: hashPass,
        provider: provider || "local",
        active_token 
      },
    });
    const fullName = `${res.last_name} ${res.first_name}`;
    const customer = await this.prismaService.customer.create({
      data :{
        ...res,
        email : email,
        full_name : fullName,
        account :{
          connect: { id: newAccount.id },
        },
        provider: provider || "local",
      }
    })


    await this.mailService.sendMail({
     from: process.env.ADMIN_EMAIL_ADDRESS,
      to: email,
      subject: "Kích hoạt tài khoản",
      template: "comfirmNewCustomer",
      context: {
        token : active_token
      }
    })
    return customer;
  }

  async activeAccount(token: string) {
    const { email, password } = this.jwtService.verify(token, {
      secret: process.env.JWT_SECRET_VERIFY,
    });
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email },
    });
    if (!account) {
      throw new UnauthorizedException("Not found account");
    }
    if (account.active) {
      throw new UnauthorizedException("Account already active");
    }
    await this.prismaService.customerAccount.update({
      where: { email },
      data: { active: true, active_token: null ,  active_expired_at : new Date() },
    });
    return { message: "Active account successfully" };
  }

  async logout() {
    return { message: "Logout successfully" };
  }

  async profile(id: number) {
    return this.prismaService.customer.findUnique({
      where: { id },
      select :{
        email : true,
        first_name : true,
        last_name : true,
        phone : true,
        full_name : true,
        gender : true,
        birthday : true,
        avatar : true,
        meta_data : true,
      }
    });
  }
}
