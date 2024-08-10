import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';
import * as path from 'path';
import * as sharp from 'sharp';
import { v4 as uuid } from "uuid"
import * as fs from 'fs';
@Injectable()
export class StaticService {

  constructor(private prisma: PrismaService) {

  }

  createFile(createStaticDto: Prisma.FileCreateInput) {
    return this.prisma.file.create({
      data: createStaticDto
    })
  }
  createFiles(createStaticDto: Prisma.FileCreateManyInput[]) {
    return this.prisma.file.createMany({
      data: createStaticDto
    })
  }
  createFolder(createStaticDto: Prisma.FolderCreateInput) {
    return this.prisma.folder.create({
      data: createStaticDto
    })
  }

  findFiles(where?: Prisma.FileWhereInput) {
    return this.prisma.file.findMany({
      where: where
    })
  }
  findFolders(where : Prisma.FolderWhereInput) {
    return this.prisma.folder.findMany({
      where : where
    })
  }

  findOne(id: number) {
    return this.prisma.file.findUnique({
      where: { id }
    })
  }


  removeFile(id: number) {
    return this.prisma.file.delete({
      where: { id }
    })
  }
  removeFolder(id: number) {
    return this.prisma.folder.delete({
      where: { id }
    })
  }
  async saveFileNormal(file: Express.Multer.File) {
    const filename = uuid() + '.webp';

    const uploadPath = path.join(process.env.STATIC_FOLDER, filename);

    fs.writeFileSync(uploadPath, file.buffer);
    const image = sharp(file.buffer);
    const metadata = await image.metadata();
    return {
      name: filename,
      nameOrigin: file.originalname,
      format: metadata.format,
      size: file.size,
      height: metadata.height,
      width: metadata.width
    }
  }

  async saveFileOptimize(file: Express.Multer.File, width?: number, height?: number) {
    const filename = uuid() + '.webp';
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
      width: res.width
    }
  }
}
