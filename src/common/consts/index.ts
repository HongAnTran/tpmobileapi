export const PERMISSION = {
  product: {
    read: "read-product",
    write: "write-product",
  },
  order: {
    read: "read-order",
    write: "write-order",
  },
  category: {
    read: "read-category",
    write: "write-category",
  },
  article: {
    read: "read-article",
    write: "write-article",
  },
  categoryArticle: {
    read: "read-category-article",
    write: "write-category-article",
  },
  account: {
    read: "read-account",
    write: "write-account",
  },
  brand: {
    read: "read-brand",
    write: "write-brand",
  },
  customer: {
    read: "read-customer",
    write: "write-customer",
  },
  page: {
    read: "read-page",
    write: "write-page",
  },
  store: {
    read: "read-store",
    write: "write-store",
  },
  report: {
    read: "read-report",
    write: "write-report",
  },
};

export enum ROLE_CODE_DEFAULT {
  ADMIN = "ADMIN",
  USER = "USER",
}

export const DEFAULT_ROLES = [
  {
    name: "admin",
    code: ROLE_CODE_DEFAULT.ADMIN,
    description: "Administrator role",
  },
  {
    name: "user",
    code: ROLE_CODE_DEFAULT.USER,
    description: "user role",
  },
];
