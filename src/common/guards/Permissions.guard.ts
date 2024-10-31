import { CanActivate, ExecutionContext, Injectable, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private reflector: Reflector, private userService: UsersService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const permissions = this.reflector.get<string[]>('permissions', context.getHandler());
    if (!permissions) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    // const userRoles = await this.userService.getUserRoles(user.id);
    // Lấy tất cả các quyền của người dùng từ các vai trò của họ

    // Kiểm tra xem người dùng có quyền cần thiết không
    // const hasPermission = permissions.every(permission => userPermissions.includes(permission));

    // if (!hasPermission) {
    //   throw new ForbiddenException('You do not have permission to access this resource');
    // }

    // return hasPermission;
  }
}
