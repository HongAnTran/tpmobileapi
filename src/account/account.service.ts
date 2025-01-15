import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from "@nestjs/common";
import { CreateAccountDto } from "./dto/create-account.dto";
import { UpdateAccountDto } from "./dto/update-account.dto";
import { PrismaService } from "../prisma.service";
import * as bcrypt from "bcrypt";
import { JwtService } from "@nestjs/jwt";

@Injectable()
export class AccountService {
  constructor(private readonly PrismaService: PrismaService) {}

  async create(createAccountDto: CreateAccountDto) {
    const { email, password, provider } = createAccountDto;
    const isExists = await this.findOneByEmail(email);
    if (isExists) {
      throw new BadRequestException("Email already exists");
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    try {
      return this.PrismaService.account.create({
        data: {
          email,
          password: hashedPassword,
          provider: provider || "local",
        },
      });
    } catch (error) {
      throw new InternalServerErrorException("Failed to create account");
    }
  }

  findAll() {
    return `This action returns all account`;
  }

  findOneByEmail(email: string) {
    return this.PrismaService.account.findUnique({ where: { email } });
  }
  findOne(id: number) {
    return this.PrismaService.account.findUnique({ where: { id } });
  }

  update(id: number, updateAccountDto: UpdateAccountDto) {
    return `This action updates a #${id} account`;
  }

  remove(id: number) {
    return `This action removes a #${id} account`;
  }
}
