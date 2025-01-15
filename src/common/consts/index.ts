export const PERMISSION = {
  product: {
    create: "create-product",
    read: "read-product",
    update: "update-product",
    delete: "delete-product",
  },
  order: {
    create: "create-order",
    read: "read-order",
    update: "update-order",
    delete: "delete-order",
  },
  category: {
    create: "create-category",
    read: "read-category",
    update: "update-category",
    delete: "delete-category",
  },
  article: {
    create: "create-article",
    read: "read-article",
    update: "update-article",
    delete: "delete-article",
  },
  categoryArticle: {
    create: "create-category-article",
    read: "read-category-article",
    update: "update-category-article",
    delete: "delete-category-article",
  },
  account: {
    create: "create-account",
    read: "read-account",
    update: "update-account",
    delete: "delete-account",
  },
  brand: {
    create: "create-brand",
    read: "read-brand",
    update: "update-brand",
    delete: "delete-brand",
  },
  cart: {
    create: "create-cart",
    read: "read-cart",
    update: "update-cart",
    delete: "delete-cart",
  },
  customer: {
    create: "create-customer",
    read: "read-customer",
    update: "update-customer",
    delete: "delete-customer",
  },
  page: {
    create: "create-page",
    read: "read-page",
    update: "update-page",
    delete: "delete-page",
  },
  store: {
    create: "create-store",
    read: "read-store",
    update: "update-store",
    delete: "delete-store",
  },
};

export enum ROLE_CODE_DEFAULT {
  ADMIN = "ADMIN",
  PUBLIC = "PUBLIC",
}

export const DEFAULT_ROLES = [
  {
    name: "admin",
    code: ROLE_CODE_DEFAULT.ADMIN,
    description: "Administrator role",
  },
  {
    name: "public",
    code: ROLE_CODE_DEFAULT.PUBLIC,
    description: "Public role",
  },
];
