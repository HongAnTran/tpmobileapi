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
      // Extract the original filename without extension and sanitize
      const baseName = file.originalname
        .split('.')[0]
        .replace(/[^a-zA-Z0-9-_]/g, '');
  
      const folder = "tpmobile-images-public";
  
      // Function to check if public_id exists and generate new public_id
      const generateUniquePublicId = async (name: string, suffix: number = 0): Promise<string> => {
        const publicId = suffix === 0 ? name : `${name}_${suffix}`;
        const fullPublicId = `${folder}/${publicId}`;
  
        try {
          // Check if resource with public_id exists
          await cloudinary.api.resource(fullPublicId, { resource_type: 'image' });
          // If resource exists, try next suffix
          return generateUniquePublicId(name, suffix + 1);
        } catch (error) {
          // If resource does not exist (error), this public_id is available
          return publicId;
        }
      };
  
      // Generate unique public_id
      generateUniquePublicId(baseName).then((uniquePublicId) => {
        cloudinary.uploader
          .upload_stream(
            {
              folder,
              public_id: uniquePublicId, 
              use_filename: true,
              unique_filename: false,
              transformation: [
                {
                  quality: "auto",
                  fetch_format: "webp",
                },
              ],
            },
            (error, result) => {
              if (error) return reject(error);
              const cloudinaryUrl = this.configService.get<string>("CLOUDINARY_URL_CDN");
              const cdnUrl = result.secure_url.replace(
                cloudinaryUrl,
                this.configService.get("CDN_URL") || "https://cdn.tpmobile.com.vn"
              );
              resolve({
                ...result,
                secure_url: cdnUrl,
              });
            }
          )
          .end(file.buffer);
      }).catch(reject);
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
