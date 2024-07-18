import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, Role, User } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) { }

  async create(createUserDto: Prisma.UserCreateInput): Promise<User> {
    return this.prisma.user.create({ data: createUserDto });
  }
  async createRole(createRoleDto: Prisma.RoleCreateInput): Promise<Role> {
    return this.prisma.role.create({data : createRoleDto});
  }

  async findAll(): Promise<User[]> {
    return this.prisma.user.findMany();
  }
  async findOne(id: number): Promise<User | null> {
    const User = await this.prisma.user.findUnique({
      where: { id },
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
