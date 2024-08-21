export enum OrderStatus {
  DRAFT = 1,        // Đơn hàng chưa được hoàn tất bởi khách hàng
  PENDING = 2,      // Chờ xử lí
  PROCESSING = 3,   // Đơn hàng đang được xử lý
  FAILED = 4,       // Đơn hàng thất bại do lỗi
  CANCELLED = 5,    // Đơn hàng đã bị hủy
  SHIPPED = 6,      // Đơn hàng đã được gửi đi
  RETURNED = 7,     // Đơn hàng bị trả
  SUCCESS = 8,      // Đơn hàng đã được giao thành công
}


