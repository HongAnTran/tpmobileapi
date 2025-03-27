import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { PagePublicService } from './page-public.service';
import { CreatePagePublicDto } from './dto/create-page-public.dto';
import { UpdatePagePublicDto } from './dto/update-page-public.dto';

@Controller('page-public')
export class PagePublicController {
  constructor(private readonly pagePublicService: PagePublicService) {}

  @Post()
  create(@Body() createPagePublicDto: CreatePagePublicDto) {
    return this.pagePublicService.create(createPagePublicDto);
  }

  @Get()
  findAll() {
    return this.pagePublicService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.pagePublicService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePagePublicDto: UpdatePagePublicDto) {
    return this.pagePublicService.update(+id, updatePagePublicDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.pagePublicService.remove(+id);
  }
}
