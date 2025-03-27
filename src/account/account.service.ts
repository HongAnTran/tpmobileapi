import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
} from "@nestjs/common";
import { CreateAccountDto } from "../auth/dto/create-account.dto";
import { UpdateAccountDto } from "./dto/update-account.dto";
import { PrismaService } from "../prisma.service";
import { ROLE_CODE_DEFAULT } from "src/common/consts";
import { hashPassword } from "src/common/helper/hassPassword";

@Injectable()
export class AccountService {
  constructor(private readonly PrismaService: PrismaService) {}

  async createUser(createAccountDto: CreateAccountDto) {
    const { email, password, provider, name, birthday, gender, phone } =
      createAccountDto;
    const isExists = await this.findOneByEmail(email);
    if (isExists) {
      throw new BadRequestException("Email already exists");
    }
    const hashedPassword = await hashPassword(password);
    try {
      const account = await this.PrismaService.account.create({
        data: {
          email,
          password: hashedPassword,
          provider: provider || "local",
        },
      });

      const customer = await this.PrismaService.user.create({
        data: {
          name,
          account_id: account.id,
        },
      });
      return customer;
    } catch (error) {
      throw new InternalServerErrorException("Failed to create account");
    }
  }

  findAll() {
    return `This action returns all account`;
  }

  findOneByEmail(email: string) {
    return this.PrismaService.account.findUnique({
      where: { email },
      include: { customer: true, user: true },
    });
  }
  findOne(id: number) {
    return this.PrismaService.account.findUnique({
      where: { id },
      select: {
        customer: true,
        email: true,
        provider: true,
        updated_at: true,
        created_at: true,
      },
    });
  }

  update(id: number, updateAccountDto: UpdateAccountDto) {
    return `This action updates a #${id} account`;
  }

  remove(id: number) {
    return `This action removes a #${id} account`;
  }
}
