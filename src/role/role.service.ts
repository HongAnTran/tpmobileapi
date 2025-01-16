import { Injectable } from "@nestjs/common";
import { CreateRoleDto } from "./dto/create-role.dto";
import { UpdateRoleDto } from "./dto/update-role.dto";
import { PrismaService } from "src/prisma.service";
import { Prisma } from "@prisma/client";

@Injectable()
export class RoleService {
  constructor(private prismaService: PrismaService) {}

  create(createRoleDto: CreateRoleDto) {
    return this.prismaService.role.create({ data: createRoleDto });
  }

  findAll(where: Prisma.RoleWhereInput) {
    return this.prismaService.role.findMany({
      where,
      include: { permission: true },
    });
  }

  findOne(id: number) {
    return this.prismaService.role.findUnique({ where: { id } });
  }

  update(id: number, updateRoleDto: UpdateRoleDto) {
    return this.prismaService.role.update({
      where: { id },
      data: updateRoleDto,
    });
  }

  remove(id: number) {
    return this.prismaService.role.delete({ where: { id } });
  }

  findAllPermission(where: Prisma.PermissionWhereInput) {
    return this.prismaService.permission.findMany({ where });
  }
}
