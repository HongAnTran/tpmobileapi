import { Injectable } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { PrismaService } from "src/prisma.service";
import * as path from "path";
import * as sharp from "sharp";
import { v4 as uuid } from "uuid";
import * as fs from "fs";
import { sanitizeName } from "src/common/helper/hassPassword";
import { CloudinaryService } from "../cloudinary/cloudinary.service";
import { UpdateFileDto } from "./dto/update-static.dto";
import { UpdateFolderDto } from "./dto/update-folder.dto";
@Injectable()
export class StaticService {
  constructor(
    private prisma: PrismaService,
    private readonly cloudinaryService: CloudinaryService
  ) {}

  async uploadImageFormFileToCloudinary(
    file: Express.Multer.File,
    folderId?: number
  ) {
    const res = await this.cloudinaryService.uploadImageFromFile(file);
    const baseName = file.originalname
        .split('.')[0]
        .replace(/[^a-zA-Z0-9-_]/g, '');
    const createStaticDto: Prisma.FileCreateInput = {
      format: res.format,
      name: baseName || res.original_filename,
      url: res.secure_url,
      size: res.bytes || file.size,
      id_root: res.public_id,
      folder: folderId
        ? {
            connect: { id: folderId },
          }
        : undefined,
    };
    const createdFile = await this.createFile(createStaticDto);
    return createdFile;
  }

  async uploadImageFormURLToCloudinary(url: string) {
    const res = await this.cloudinaryService.uploadImageFromUrl(url);
    const createStaticDto: Prisma.FileCreateInput = {
      format: res.format,
      name: res.name || res.public_id,
      url: res.secure_url,
      size: res.size || 0,
      id_root: res.public_id,
    };
    const createdFile = await this.createFile(createStaticDto);
    return createdFile;
  }

  createFile(createStaticDto: Prisma.FileCreateInput) {
    return this.prisma.file.create({
      data: createStaticDto,
    });
  }
  editFile(id: number, file: UpdateFileDto) {
    return this.prisma.file.update({
      where: { id },
      data: {
        name: file.name,
        folder: file.folder_id
          ? {
              connect: { id: file.folder_id },
            }
          : undefined,
      },
    });
  }

  createFiles(createStaticDto: Prisma.FileCreateManyInput[]) {
    return this.prisma.file.createMany({
      data: createStaticDto,
    });
  }
  createFolder(createStaticDto: Prisma.FolderCreateInput) {
    return this.prisma.folder.create({
      data: createStaticDto,
    });
  }
  editFolder(id: number, createStaticDto: UpdateFolderDto) {
    return this.prisma.folder.update({
      where: { id },
      data: {
        name: createStaticDto.name,
        parent: createStaticDto.parent_id
          ? {
              connect: { id: createStaticDto.parent_id },
            }
          : undefined,
      },
    });
  }

  findFiles({
    skip,
    take,
    where,
  }: {
    take: number;
    skip: number;
    where?: Prisma.FileWhereInput;
  }) {
    return this.prisma.file.findMany({
      where,
      take,
      skip,
      orderBy: { id: "desc" },
    });
  }
  findFolders({
    skip,
    take,
    where,
  }: {
    take: number;
    skip: number;
    where?: Prisma.FolderWhereInput;
  }) {
    return this.prisma.folder.findMany({
      where,
      take,
      skip,
    });
  }

  findOne(id: number) {
    return this.prisma.file.findUnique({
      where: { id },
    });
  }
  findOnefolder(id: number) {
    return this.prisma.folder.findUnique({
      where: { id },
    });
  }

  async removeFile(id: number) {
    // Retrieve the file record from the database
    const fileRecord = await this.prisma.file.findUnique({
      where: { id },
    });

    if (!fileRecord) {
      throw new Error("File not found");
    }

    if (fileRecord.id_root) {
      await this.cloudinaryService.deleteImage(fileRecord.id_root);
    } else {
      // Construct the file path
      const filePath = path.join(process.env.STATIC_FOLDER, fileRecord.name);

      // Delete the file from the filesystem
      try {
        fs.unlinkSync(filePath);
      } catch (error) {
        throw new Error("Failed to delete file from filesystem");
      }
    }

    // Delete the file record from the database
    return this.prisma.file.delete({
      where: { id },
    });
  }

  removeFolder(id: number) {
    return this.prisma.folder.delete({
      where: { id },
    });
  }
  async saveFileNormal(file: Express.Multer.File) {
    const image = sharp(file.buffer);
    const metadata = await image.metadata();

    const format = metadata.format || "webp"; // Sử dụng định dạng từ metadata, nếu không có thì dùng mặc định là 'webp'
    const filename = this.createNameFileImage(
      file.originalname,
      format,
      metadata.width,
      metadata.height
    );

    const uploadPath = path.join(process.env.STATIC_FOLDER, filename);

    fs.writeFileSync(uploadPath, file.buffer);

    return {
      name: filename,
      nameOrigin: file.originalname,
      format: format,
      size: file.size,
      height: metadata.height,
      width: metadata.width,
    };
  }

  async saveFileOptimize(
    file: Express.Multer.File,
    width?: number,
    height?: number
  ) {
    const filename = this.createNameFileImage(
      file.originalname,
      "webp",
      width,
      height
    );

    const res = await sharp(file.buffer)
      .resize(width, height)
      .webp({ effort: 3 })
      .toFile(path.join(process.env.STATIC_FOLDER, filename));

    return {
      name: filename,
      nameOrigin: file.originalname,
      format: res.format,
      size: res.size,
      height: res.height,
      width: res.width,
    };
  }

  createNameFileImage(
    originName: string,
    format: string,
    w?: number,
    h?: number
  ) {
    const name = sanitizeName(originName);
    if (w && h) {
      return name + uuid(4) + `-${w}x${h}` + `.${format}`;
    }

    return name + uuid(4) + `.${format}`;
  }
}
