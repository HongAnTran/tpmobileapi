import { IsNotEmpty, IsOptional, IsString, IsInt } from 'class-validator';

export class CreateQuestionDto {
  @IsNotEmpty() // Đảm bảo thuộc tính này không được để trống
  @IsString() // Kiểm tra kiểu dữ liệu là chuỗi
  content: string;

  @IsInt() // Kiểm tra kiểu dữ liệu là số nguyên
  product_id?: number; // ID của sản phẩm liên quan


  @IsInt() // Kiểm tra kiểu dữ liệu là số nguyên
  customer_id: number; // ID của khách hàng nếu có

  @IsOptional() // Không bắt buộc
  @IsString() // Kiểm tra kiểu dữ liệu là chuỗi
  email?: string; // Email của khách hàng nếu có

  @IsOptional() // Không bắt buộc
  @IsString() // Kiểm tra kiểu dữ liệu là chuỗi
  phone?: string; // Số điện thoại của khách hàng nếu có

  @IsOptional() // Không bắt buộc
  @IsString() // Kiểm tra kiểu dữ liệu là chuỗi
  full_name?: string; // Tên đầy đủ của khách hàng nếu có
}
