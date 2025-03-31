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
import { RoleService } from "./role.service";
import { CreateRoleDto } from "./dto/create-role.dto";
import { UpdateRoleDto } from "./dto/update-role.dto";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("roles")
@UseGuards(AuthGuard)
export class RoleController {
  constructor(private readonly roleService: RoleService) {}

  @Post()
  create(@Body() createRoleDto: CreateRoleDto) {
    return this.roleService.create(createRoleDto);
  }

  @Get()
  findAll(@Query() where: { code?: string; name?: string }) {
    return this.roleService.findAll(where);
  }

  @Get("permission")
  findAllPermission(@Query() where: { roleId?: number }) {
    return this.roleService.findAllPermission({
      roles: { some: { id: where.roleId } },
    });
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.roleService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateRoleDto: UpdateRoleDto) {
    return this.roleService.update(+id, updateRoleDto);
  }

  @Patch("assign/:id")
  assign(@Param("id") id: string, @Body() body: { permissionIds: number[] }) {
    const { permissionIds } = body;
    return this.roleService.assign(+id, permissionIds);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.roleService.remove(+id);
  }
}
