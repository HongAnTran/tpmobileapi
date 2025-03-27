import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { PagesService } from "./pages.service";
import { CreatePageDto } from "./dto/create-page.dto";
import { UpdatePageDto } from "./dto/update-page.dto";
import { Public } from "src/common/decorator/public.decorator";

@Controller("pages")
export class PagesController {
  constructor(private readonly pagesService: PagesService) {}

  @Post()
  test(@Body() createPageDto: CreatePageDto) {
    return this.pagesService.create(createPageDto);
  }

  @Get()
  findAll() {
    return this.pagesService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.pagesService.findOne(+id);
  }

  @Public()
  @Get("slug/:slug")
  findOneBySlug(@Param("slug") slug: string) {
    return this.pagesService.findOneBySlug(slug);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updatePageDto: UpdatePageDto) {
    return this.pagesService.update(+id, updatePageDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.pagesService.remove(+id);
  }
}
