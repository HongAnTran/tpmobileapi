import { Injectable, UnauthorizedException } from "@nestjs/common";
import { LoginDto } from "./dto/login.dto";
import { PrismaService } from "src/prisma.service";
import { JwtService } from "@nestjs/jwt";
import * as bcrypt from "bcrypt";
import { RegisterDto } from "./dto/register.dto";
import { hashPassword } from "src/common/helper/hassPassword";
import { MailService } from "src/mail/mail.service";
import { ChangePassDto } from "./dto/changePass.dto";

@Injectable()
export class CustomerAuthService {
  constructor(
    private jwtService: JwtService,
    private prismaService: PrismaService,
    private mailService: MailService
  ) {}
  async signIn(payload: LoginDto) {
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
      include: {
        customer: true,
      },
    });
    if (!account) {
      throw new UnauthorizedException("Tài khoản không tồn tại");
    }
    if (!bcrypt.compareSync(payload.password, account.password)) {
      throw new UnauthorizedException("Mật khẩu không đúng");
    }
    if (!account.active) {
      throw new UnauthorizedException("Tài khoản chưa được kích hoạt");
    }
    const { customer } = account;
    const accessToken = this.jwtService.sign(
      { id: customer.id, email: customer.email },
      { expiresIn: "30d", secret: process.env.JWT_SECRET_VERIFY }
    );
    return { accessToken };
  }
  async register(payload: RegisterDto) {
    // Dùng transaction để đảm bảo rollback nếu có lỗi
    return await this.prismaService.$transaction(async (prisma) => {
      // 1. Kiểm tra email đã tồn tại
      const account = await prisma.customerAccount.findUnique({
        where: { email: payload.email },
      });
      if (account) {
        throw new UnauthorizedException("Địa chỉ email đã tồn tại");
      }

      // 2. Chuẩn bị dữ liệu
      const { password, email, provider, ...res } = payload;
      const hashPass = await hashPassword(password);
      const active_token = this.jwtService.sign(
        { email: email, password: hashPass },
        { expiresIn: "30d", secret: process.env.JWT_SECRET_VERIFY }
      );

      // 3. Tạo tài khoản trong transaction
      const newAccount = await prisma.customerAccount.create({
        data: {
          email: email,
          password: hashPass,
          provider: provider || "local",
        },
      });

      // 4. Tạo khách hàng trong transaction
      const fullName = `${res.last_name} ${res.first_name}`;
      const customer = await prisma.customer.create({
        data: {
          ...res,
          email: email,
          full_name: fullName,
          account: {
            connect: { id: newAccount.id },
          },
          provider: provider || "local",
        },
      });

      // 5. Gửi email (nếu lỗi thì rollback)
      try {
        await this.mailService.sendMailNoJob({
          to: email,
          subject: "TP Mobile Store - Kích hoạt tài khoản website",
          template: "comfirmNewCustomer",
          context: {
            token: active_token,
          },
        });
      } catch (error) {
        console.log(error);
        throw new Error(`Đã có lỗi xảy ra vui lòng thử lại`);
      }

      // 6. Trả về kết quả nếu mọi thứ thành công
      return customer;
    });
  }

  async activeAccount(token: string) {
    const payload = this.jwtService.verify(token, {
      secret: process.env.JWT_SECRET_VERIFY,
    });
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
    });
    if (!account) {
      throw new UnauthorizedException("Không tìm thấy tài khoản");
    }
    if (account.active) {
      throw new UnauthorizedException("Tài khoản đã được kích hoạt rồi");
    }
    await this.prismaService.customerAccount.update({
      where: { id: account.id },
      data: { active: true, active_expired_at: new Date() },
    });
    return { message: "Kích hoạt tài khoản thành công" };
  }

  async logout() {
    return { message: "Logout successfully" };
  }

  async profile(id: number) {
    return this.prismaService.customer.findUnique({
      where: { id },
      select: {
        email: true,
        first_name: true,
        last_name: true,
        phone: true,
        full_name: true,
        gender: true,
        birthday: true,
        avatar: true,
        meta_data: true,
      },
    });
  }

  async resetPassword(email: string) {
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email },
    });
    if (!account) {
      throw new UnauthorizedException("Tài khoản không tồn tại");
    }
    const reset_token = this.jwtService.sign(
      { email: email },
      { expiresIn: "30d", secret: process.env.JWT_SECRET_VERIFY }
    );
    await this.mailService.sendMailNoJob({
      to: email,
      subject: "TP Mobile Store - Đặt lại mật khẩu",
      template: "resetPassword",
      context: {
        token: reset_token,
      },
    });
  }

  async resetPasswordConfirm(token: string, password: string) {
    const payload = this.jwtService.verify(token, {
      secret: process.env.JWT_SECRET_VERIFY,
    });
    const account = await this.prismaService.customerAccount.findUnique({
      where: { email: payload.email },
    });
    if (!account) {
      throw new UnauthorizedException("Tài khoản không tồn tại");
    }
    if (!account.active) {
      throw new UnauthorizedException("Tài khoản chưa được kích hoạt");
    }
    const hashPass = await hashPassword(password);
    await this.prismaService.customerAccount.update({
      where: { id: account.id },
      data: { password: hashPass },
    });
    return { message: "Đặt lại mật khẩu thành công" };
  }

  async changePass(id: number, body: ChangePassDto) {
    const account = await this.prismaService.customerAccount.findUnique({
      where: { id },
    });
    if (!account) {
      throw new UnauthorizedException("Tài khoản không tồn tại");
    }
    if (!bcrypt.compareSync(body.password, account.password)) {
      throw new UnauthorizedException("Mật khẩu không đúng");
    }
    const hashPass = await hashPassword(body.new_password);
    return this.prismaService.customerAccount.update({
      where: { id },
      data: { password: hashPass },
    });
  }
}
