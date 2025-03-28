import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma.service";

@Injectable()
export class AccountService {
  constructor(private readonly PrismaService: PrismaService) {}

  findAll() {
    return `This action returns all account`;
  }

  findOneByEmail(email: string) {
    return this.PrismaService.account.findUnique({
      where: { email },
      include: { user: true , roles: true },
    });
  }
  findOne(id: number) {
    return this.PrismaService.account.findUnique({
      where: { id },
    });
  }

  remove(id: number) {
    return `This action removes a #${id} account`;
  }
}
