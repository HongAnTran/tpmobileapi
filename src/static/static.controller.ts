import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, Query } from '@nestjs/common';
import { StaticService } from './static.service';
import { Prisma } from '@prisma/client';
import { FilesInterceptor } from '@nestjs/platform-express';
@Controller('static')
export class StaticController {
  constructor(private readonly staticService: StaticService) { }

  @Post('upload/images')
  @UseInterceptors(FilesInterceptor('file', 5, {
    limits: { fileSize: 5 * 1024 * 1024 }, //limit 5mb
  }))

  async uploadMultipleFiles(@UploadedFiles() files: Express.Multer.File[], @Query() query: { isOptimize?: boolean, width?: number, height?: number }) {
    const { isOptimize, width, height } = query
    const fileUploads = []

    for await (const file of files) {
      if (isOptimize) {
        const res = await this.staticService.saveFileOptimize(file, width, height)
        fileUploads.push(res)
      } else {
        const res = await this.staticService.saveFileNormal(file)
        fileUploads.push(res)
      }
    }

    const body: Prisma.FileCreateManyInput[] = fileUploads.map(file => ({
      format: file.format, 
      name: file.name,
      url: `${process.env.BASE_URL}/${process.env.STATIC_FOLDER}/${file.name}`,
      size:file.size

      
    }))

    return this.staticService.createFiles(body)

  }

  @Post()
  create(@Body() createStaticDto: Prisma.FileCreateInput) {
    return this.staticService.createFile(createStaticDto);
  }

  @Get()
  findAll() {
    return this.staticService.findFiles();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.staticService.findOne(+id);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updateStaticDto: UpdateStaticDto) {
  //   return this.staticService.update(+id, updateStaticDto);
  // }

  @Delete('files/:id')
  removeFile(@Param('id') id: string) {
    return this.staticService.removeFile(+id);
  }
  @Delete('folder/:id')
  removeFolder(@Param('id') id: string) {
    return this.staticService.removeFolder(+id);
  }
}
