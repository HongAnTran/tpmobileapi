import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma, Role, User } from "@prisma/client";
import { ResponseList } from "src/common/types/Common.type";
import { PrismaService } from "src/prisma.service";
import { PaginationDto } from "../common/dtos/pagination.dto";
import { CONFIG_APP } from "src/common/config";

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findAll(paginationDto: PaginationDto): Promise<ResponseList<User>> {
    const paga = this.getPaginationOptions(paginationDto);
    const users = await this.prisma.user.findMany({ ...paga });
    const total = await this.prisma.user.count();
    return { datas: users, total };
  }

  getPaginationOptions(paginationDto: PaginationDto) {
    const {
      page = 1,
      limit = CONFIG_APP.MAX_SIZE_LIMIT,
      sortBy,
      sortType = "asc",
      include,
    } = paginationDto;
    const take =
      limit <= CONFIG_APP.MAX_SIZE_LIMIT ? limit : CONFIG_APP.MAX_SIZE_LIMIT;
    const skip = (page - 1) * limit;

    const orderBy = sortBy ? { [sortBy]: sortType } : undefined;

    const includeParams = include ? include.split(",") : [];
    let includeQuery = includeParams.reduce((pre, item) => {
      pre[item] = true;
      return pre;
    }, {});
    return { skip, take, orderBy, include: includeQuery };
  }

  async update(
    id: number,
    updateUserDto: Prisma.UserUpdateInput
  ): Promise<User> {
    return await this.prisma.user.update({
      where: { id },
      data: updateUserDto,
    });
  }
  async remove(id: number): Promise<User> {
    return this.prisma.user.delete({
      where: { id },
    });
  }
}
