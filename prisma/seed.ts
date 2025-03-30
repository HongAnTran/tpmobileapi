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
  const permissionArray = Object.entries(PERMISSION).flatMap(([_, category]) =>
    Object.entries(category).map(([code, name]) => ({ code, name }))
  );

  for (const { code, name } of permissionArray) {
    const existingPermission = await prisma.permission.findUnique({
      where: { code },
    });
    if (!existingPermission) {
      await prisma.permission.create({ data: { code, name } });
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
    const permissionIds = allPermissions.map((permission) => permission.id);
    await prisma.role.update({
      where: { id: adminRole.id },
      data: {
        permissions: {
          connect: permissionIds.map((id) => ({ id })),
        },
      },
    });
  }
}

async function initAccountAdmin() {
  const passwordHash = await hashPassword(process.env.ADMIN_EMAIL_PASSWORD);
  const payload = {
    email: process.env.ADMIN_EMAIL_ADDRESS,
    password: passwordHash,
  };
  const existingAccount = await prisma.account.findUnique({
    where: { email: payload.email },
  });

  if (!existingAccount) {
    const user = await prisma.user.create({
      data: {
        name: "Admin",
      },
    });
    await prisma.account.create({
      data: {
        email: payload.email,
        password: payload.password,
        user: {
          connect: {
            id: user.id,
          },
        },
        roles: {
          connect: {
            code: ROLE_CODE_DEFAULT.ADMIN,
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
