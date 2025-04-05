import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { v2 as cloudinary } from "cloudinary";
import { UploadApiResponse, UploadApiErrorResponse } from "cloudinary";

@Injectable()
export class CloudinaryService {
  constructor(private readonly configService: ConfigService) {}

  async uploadImageFromFile(
    file: Express.Multer.File
  ): Promise<UploadApiResponse | UploadApiErrorResponse> {
    return new Promise((resolve, reject) => {
      cloudinary.uploader
        .upload_stream(
          {
            folder: "tpmobile-images-public",
            transformation: [
              {
                quality: "auto",
                fetch_format: "webp"
              },
            ],
          },
          (error, result) => {
            if (error) return reject(error);

            // Lấy giá trị CLOUDINARY_URL từ biến môi trường
            const cloudinaryUrl =
              this.configService.get<string>("CLOUDINARY_URL_CDN");
            const cdnUrl = result.secure_url.replace(
              cloudinaryUrl,
              this.configService.get("CDN_URL") || "https://cdn.tpmobile.com.vn"
            );

            resolve({
              ...result,
              secure_url: cdnUrl,
            });
            resolve(result);
          }
        )
        .end(file.buffer);
    });
  }

  async uploadImageFromUrl(
    imageUrl: string
  ): Promise<UploadApiResponse | UploadApiErrorResponse> {
    return new Promise((resolve, reject) => {
      cloudinary.uploader.upload(
        imageUrl,
        {
          folder: "tpmobile-images-public",
          transformation: [
            {
              quality: "auto",
              fetch_format: "auto",
            },
          ],
        },
        (error, result) => {
          if (error) return reject(error);

          // Lấy giá trị CLOUDINARY_URL từ biến môi trường
          const cloudinaryUrl =
            this.configService.get<string>("CLOUDINARY_URL_CDN");
          const cdnUrl = result.secure_url.replace(
            cloudinaryUrl,
            this.configService.get("CDN_URL") || "https://cdn.tpmobile.com.vn"
          );

          // Trả về kết quả đã cập nhật URL
          resolve({
            ...result,
            secure_url: cdnUrl, // Cập nhật secure_url với URL mới
          });
        }
      );
    });
  }

  async deleteImage(publicId: string): Promise<any> {
    return new Promise((resolve, reject) => {
      cloudinary.uploader.destroy(publicId, (error, result) => {
        if (error) return reject(error);
        resolve(result);
      });
    });
  }
}
