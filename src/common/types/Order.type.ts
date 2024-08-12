export enum OrderStatus {
  DRAFT = 15,       // Đơn hàng chưa được hoàn tất bởi khách hàng
  PENDING = 3, // Chờ xử lí
  PROCESSING = 5, // Đơn hàng đang được xử lý
  SHIPPED = 9, // Đơn hàng đã được gửi đi
  SUCCESS = 1, // Đơn hàng đã được giao thành công
  CANCELLED = 10, // Đơn hàng đã bị hủy
  RETURNED  = 12, // Đơn hàng bị trả
}

