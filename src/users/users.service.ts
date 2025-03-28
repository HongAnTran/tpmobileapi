import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma, Role, User } from "@prisma/client";
import { ResponseList } from "src/common/types/Common.type";
import { PrismaService } from "src/prisma.service";
import { PaginationDto } from "../common/dtos/pagination.dto";
import { CONFIG_APP } from "src/common/config";
import { CreateUserDto } from "./dto/create-user.dto";
import { hashPassword } from "src/common/helper/hassPassword";
import { ROLE_CODE_DEFAULT } from "src/common/consts";

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


  async create(body : CreateUserDto) {
    const { email, password,roleId, ...rest } = body;
    const hashedPassword = await hashPassword(password);
     const account = await this.prisma.account.create({
      data: {
        email,
        password:hashedPassword,
        roles: roleId ?{
          connect: { id: roleId },
        } : {
          connect : {
            code : ROLE_CODE_DEFAULT.USER
          }
        },
        user: {
          create: {
            ...rest,
          },
        },
      },
      include: {
        user: true,
      }
  });
    const { user } = account;
    return user;
  }

  async active(id : number){
    const user = await this.prisma.user.findUnique({
      where: { id },
    });
    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return this.prisma.user.update({
      where: { id },
      data: {
       account :{
        update: {
          status  : true
        }
       }
      },
    });
  }
  async unactive(id : number){
    const user = await this.prisma.user.findUnique({
      where: { id },
    });
    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return this.prisma.user.update({
      where: { id },
      data: {
       account :{
        update: {
          status  : false
        }
       }
      },
    });
  }

  async assignRole(id:number,roleIds: number[]) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      include: { account: true },
    });
    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return this.prisma.account.update({
      where: { id: user.account.id },
      data: {
        roles: {
          set: roleIds.map((roleId) => ({ id: roleId })),
        },
      },
    });
  }
}
