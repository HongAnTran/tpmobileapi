import { PrismaClient } from "@prisma/client";
import {
  PERMISSION,
  DEFAULT_ROLES,
  ROLE_CODE_DEFAULT,
} from "../src/common/consts";
import { hashPassword } from "../src/common/helper/hassPassword";

const prisma = new PrismaClient();

/**
 *  create all permissions if not exist
 */
async function createPermissions() {
  const permissions = [];

  for (const permission in PERMISSION) {
    permissions.push(...Object.values(PERMISSION[permission]));
  }

  for (const name of permissions) {
    const existingPermission = await prisma.permission.findUnique({
      where: { name },
    });

    if (!existingPermission) {
      await prisma.permission.create({ data: { name } });
    }
  }
}

/**
 * create all roles if not exist
 */
async function createRoles() {
  for (const role of DEFAULT_ROLES) {
    const existingRole = await prisma.role.findUnique({
      where: { code: role.code },
    });

    if (!existingRole) {
      await prisma.role.create({ data: role });
    }
  }
}

/**
 * assign all permissions to admin role
 */
async function assignPermissionsToAdmin() {
  const adminRole = await prisma.role.findUnique({
    where: { code: ROLE_CODE_DEFAULT.ADMIN },
  });

  if (adminRole) {
    const allPermissions = await prisma.permission.findMany();
    const rolePermissions = await prisma.rolePermission.findMany({
      where: { roleId: adminRole.id },
    });

    const existingPermissionIds = new Set(
      rolePermissions.map((rp) => rp.permissionId)
    );

    const newPermissions = allPermissions.filter(
      (permission) => !existingPermissionIds.has(permission.id)
    );

    for (const permission of newPermissions) {
      await prisma.rolePermission.create({
        data: {
          roleId: adminRole.id,
          permissionId: permission.id,
        },
      });
    }
  }
}

async function initAccountAdmin() {
  const passwordHash = await hashPassword(process.env.PASS_USERNAME);
  const payload = {
    email: process.env.EMAIL_USERNAME,
    password: passwordHash,
  };
  const existingAccount = await prisma.account.findUnique({
    where: { email: payload.email },
  });

  if (!existingAccount) {
    await prisma.account.create({
      data: {
        email: payload.email,
        password: payload.password,
        provider: "local",
        account_roles: {
          create: {
            role: {
              connect: { code: ROLE_CODE_DEFAULT.ADMIN },
            },
          },
        },
      },
    });
  }
}
/**
 */
async function main() {
  await createPermissions();
  await createRoles();
  await assignPermissionsToAdmin();
  await initAccountAdmin();
}

main()
  .catch((e) => console.error(e))
  .finally(async () => await prisma.$disconnect());
