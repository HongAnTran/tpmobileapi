import { IsInt, IsNotEmpty, IsString } from 'class-validator';

export class CreateAnswerDto {
  @IsNotEmpty() // Đảm bảo thuộc tính này không được để trống
  @IsString() // Kiểm tra kiểu dữ liệu là chuỗi
  content: string;


  @IsNotEmpty() // Đảm bảo thuộc tính này không được để trống
  @IsInt() // Kiểm tra kiểu dữ liệu là số nguyên
  questionId: number; // ID của câu hỏi mà câu trả lời này thuộc về
}
