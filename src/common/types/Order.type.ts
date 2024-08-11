export enum OrderStatus {
  PENDING = 3, // Đơn hàng đang chờ xử lý
  PROCESSING = 5, // Đơn hàng đang được xử lý
  SHIPPED = 7, // Đơn hàng đã được gửi đi
  DELIVERED = 9, // Đơn hàng đã được giao thành công
  CANCELLED = 10, // Đơn hàng đã bị hủy
  FAILED = 12, // Đơn hàng không thành công
}