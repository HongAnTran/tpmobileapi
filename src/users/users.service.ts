import { Injectable, NotFoundException } from '@nestjs/common';
import { PermissionType, Prisma, Role, User } from '@prisma/client';
import { hashPassword } from 'src/common/hepler/hassPassword';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) { }

  async create(createUserDto: Prisma.UserCreateInput, roles: number[]): Promise<User> {
    const hashPass = await hashPassword(createUserDto.password)
    const user = await this.prisma.user.create({ data: { ...createUserDto, password: hashPass }, include: { roles: true } });
    for (const roleId of roles) {
      await this.assignRole(user.id, roleId);
    }
    return user
  }
  async createRole(createRoleDto: Prisma.RoleCreateInput): Promise<Role> {
    return this.prisma.role.create({ data: createRoleDto });
  }
  // Gán vai trò cho người dùng
  async assignRole(userId: number, roleId: number) {
    return this.prisma.userRole.create({
      data: {
        userId,
        roleId,
      },
    });
  }

  async getUserRoles(userId: number) {
    return this.prisma.userRole.findMany({
      where: {
        userId: userId
      },
      include: { role: { include: { permission: true } } }
    })
  }

  // Gán quyền cho vai trò
  async assignPermission(roleId: number, permissionId: number, type: PermissionType) {
    return this.prisma.rolePermission.create({
      data: {
        roleId,
        permissionId,
        type: type
      },
    });
  }
  // Lấy danh sách vai trò cùng với quyền hạn của chúng
  async getRoles() {
    return this.prisma.role.findMany({
      include: {
        permission: {
          include: {
            permission: true
          }
        }
      },
    });
  }
  // Tạo quyền mới
  async createPermission(name: string) {
    return this.prisma.permission.create({
      data: {
        name,
      },
    });
  }

  // Lấy danh sách các quyền
  async getPermissions() {
    return this.prisma.permission.findMany();
  }
  async findAll() {
    const datas = await this.prisma.user.findMany({ include: { roles: true } });
    const count = await this.prisma.user.count()
    return {
      datas,
      total: count

    }
  }
  async findOne(id: number): Promise<User | null> {
    const User = await this.prisma.user.findUnique({
      where: { id },
      include: { roles: true }
    });
    if (!User) {
      throw new NotFoundException(`User with id ${id} not found`);
    }
    return User;
  }



  async update(id: number, updateUserDto: Prisma.UserUpdateInput): Promise<User> {
    // Perform the update
    return await this.prisma.user.update({
      where: { id },
      data: updateUserDto
    });

  }

  async remove(id: number): Promise<User> {
    return this.prisma.user.delete({
      where: { id },
    });
  }
}
