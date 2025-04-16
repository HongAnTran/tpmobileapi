import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseInterceptors,
  UploadedFiles,
  Query,
  BadRequestException,
  UseGuards,
} from "@nestjs/common";
import { StaticService } from "./static.service";
import { Prisma } from "@prisma/client";
import { FilesInterceptor } from "@nestjs/platform-express";
import { AuthGuard } from "src/auth/jwt.guard";
import { UpdateFileDto } from "./dto/update-static.dto";
import { UpdateFolderDto } from "./dto/update-folder.dto";
@Controller("static")
@UseGuards(AuthGuard)
export class StaticController {
  constructor(private readonly staticService: StaticService) {}

  @Post("upload/images")
  @UseInterceptors(
    FilesInterceptor("file", 5, {
      limits: { fileSize: 2 * 1024 * 1024 }, // Limit 2MB
    })
  )
  async uploadMultipleFilesImage(
    @UploadedFiles() files: Express.Multer.File[],
    @Query() query: { isOptimize?: boolean; width?: number; height?: number }
  ) {
    if (files.length > 5) {
      throw new BadRequestException("You can only upload up to 5 files.");
    }
    const { isOptimize, width, height } = query;
    const fileUploads = [];

    for await (const file of files) {
      let res;
      if (isOptimize && width && height) {
        res = await this.staticService.saveFileOptimize(file, +width, +height);
      } else {
        res = await this.staticService.saveFileNormal(file);
      }

      const createStaticDto: Prisma.FileCreateInput = {
        format: res.format,
        name: res.name,
        url: `${process.env.BASE_URL}/${process.env.STATIC_FOLDER}/${res.name}`,
        size: res.size,
      };

      const createdFile = await this.staticService.createFile(createStaticDto);
      fileUploads.push(createdFile);
    }

    return fileUploads;
  }

  @Post("upload/clound")
  @UseInterceptors(
    FilesInterceptor("file", 3, {
      limits: { fileSize: 2 * 1024 * 1024 }, // Limit 2MB
    })
  )
  async uploadMultipleFilesImageToClound(
    @UploadedFiles() files: Express.Multer.File[],
    @Query("folder_id") folderId?: string
  ) {
    if (files.length > 5) {
      throw new BadRequestException("You can only upload up to 5 files.");
    }
    const fileUploads = [];

    for await (const file of files) {
      let res = await this.staticService.uploadImageFormFileToCloudinary(
        file,
        +folderId
      );
      fileUploads.push(res);
    }
    return fileUploads;
  }

  @Post("upload/url")
  uploadImageFromUrl(@Body("imageUrl") imageUrl: string) {
    return this.staticService.uploadImageFormURLToCloudinary(imageUrl);
  }

  @Post("files")
  createFile(@Body() createStaticDto: Prisma.FileCreateInput) {
    return this.staticService.createFile(createStaticDto);
  }
  @Post("folders")
  createFolder(@Body() createStaticDto: Prisma.FolderCreateInput) {
    return this.staticService.createFolder(createStaticDto);
  }
  @Get("files")
  findAll(
    @Query() query: { page?: string; limit?: string; folder_id?: string }
  ) {
    const { folder_id, limit, page } = query;
    const take = limit ? (Number(limit) <= 50 ? Number(limit) : 50) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;
    const where: Prisma.FileWhereInput = folder_id
      ? { folder_id: +folder_id }
      : { folder_id: null };
    return this.staticService.findFiles({
      skip,
      take,
      where,
    });
  }

  @Get("folders")
  findAllFolder(
    @Query() query: { page?: string; limit?: string; parent_id?: string }
  ) {
    const { parent_id, limit, page } = query;

    const take = limit ? (Number(limit) <= 50 ? Number(limit) : 50) : 50;
    const skip = page ? (Number(page) - 1) * take : undefined;

    const where: Prisma.FolderWhereInput = parent_id
      ? { parent_id: +parent_id } // Nếu parent_id được cung cấp, lọc theo parent_id
      : { parent_id: null }; // Nếu không có parent_id, lọc những thư mục có parent_id là null

    return this.staticService.findFolders({
      skip,
      take,
      where,
    });
  }

  @Get("files/:id")
  findOneFile(@Param("id") id: string) {
    return this.staticService.findOne(+id);
  }
  @Get("folders/:id")
  findOneFolder(@Param("id") id: string) {
    return this.staticService.findOnefolder(+id);
  }

  @Patch("files/:id")
  editFile(@Param("id") id: string, @Body() File: UpdateFileDto) {
    return this.staticService.editFile(+id, File);
  }

  @Patch("folders/:id")
  editFolder(@Param("id") id: string, @Body() folder: UpdateFolderDto) {
    return this.staticService.editFolder(+id, folder);
  }

  @Delete("files/:id")
  removeFile(@Param("id") id: string) {
    return this.staticService.removeFile(+id);
  }
  @Delete("folder/:id")
  removeFolder(@Param("id") id: string) {
    return this.staticService.removeFolder(+id);
  }
}
