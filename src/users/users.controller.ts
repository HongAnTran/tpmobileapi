import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Prisma } from '@prisma/client';
import * as bcrypt from 'bcrypt';
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) { }

  @Post()
  async createUser(@Body() data: {  name : string , username :string,email: string; password: string; roles: number[] }) {
    const user = await this.usersService.create({
      email: data.email,
      password: data.password,
      name:data.name,
      username:data.username
    },data.roles);
   
    return user;
  }

  @Post("role")
  createRole(@Body() createRoleDto: Prisma.RoleCreateInput) {
    return this.usersService.createRole(createRoleDto);
  }
  @Post('permission')
  async createPermission(@Body() data: { name: string }) {
    return this.usersService.createPermission(data.name);
  }

  @Get('roles')
  async getRoles() {
    return this.usersService.getRoles();
  }
  @Get('permissions')
  async getPermissions() {
    return this.usersService.getPermissions();
  }
  @Get()
  findAll() {
    return this.usersService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(+id, updateUserDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersService.remove(+id);
  }
}
