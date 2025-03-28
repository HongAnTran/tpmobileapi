export const PERMISSION = {
  product: {
    "read-product": "xem sản phẩm",
    "write-product": "quản lý sản phẩm",
  },
  order: {
    "read-order": "xem đơn hàng",
    "write-order": "quản lý đơn hàng",
  },
  category: {
    "read-category": "xem danh mục",
    "write-category": "quản lý danh mục",
  },
  article: {
    "read-article": "xem bài viết",
    "write-article": "quản lý bài viết",
  },
  categoryArticle: {
    "read-category-article": "xem danh mục bài viết",
    "write-category-article": "quản lý danh mục bài viết",
  },
  brand : {
    "read-brand": "xem thương hiệu",
    "write-brand": "quản lý thương hiệu",
  },
  customer : {
    "read-customer": "xem khách hàng",
    "write-customer": "quản lý khách hàng",
  },
  page : {
    "read-page": "xem trang",
    "write-page": "quản lý trang",
  },
  store : {
    "read-store": "xem cửa hàng",
    "write-store": "quản lý cửa hàng",
  },
  report : {
    "read-report": "xem báo cáo",
    "write-report": "quản lý báo cáo",
  }
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
