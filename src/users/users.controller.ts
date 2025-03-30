import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from "@nestjs/common";
import { UsersService } from "./users.service";
import { CreateUserDto } from "./dto/create-user.dto";
import { Prisma } from "@prisma/client";
import { PaginationDto } from "src/common/dtos/pagination.dto";
import { AuthGuard } from "src/auth/jwt.guard";
@UseGuards(AuthGuard)
@Controller("users")
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  findAll(@Query() pagination: PaginationDto) {
    return this.usersService.findAll(pagination);
  }

  @Post()
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create({
      ...createUserDto,
    });
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateUserDto: Pick<Prisma.UserUpdateInput , "avatar" |  "name" | "meta_data">
  ) {
    return this.usersService.update(+id, updateUserDto);
  }

  @Patch("active/:id")
  active(
    @Param("id") id: string,
  ) {
    return this.usersService.active(+id);
  }
  @Patch("unactive/:id")
  unactive(
    @Param("id") id: string,
  ) {
    return this.usersService.unactive(+id);
  }

  // assign role to user
  @Patch("roles/:id")
  assignRole(
    @Param("id") id: string,
    @Body() body: { roleIds: number[] }
  ) {

    const { roleIds } = body;
    return this.usersService.assignRole(+id,roleIds);
  }


  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.usersService.remove(+id);
  }
}
