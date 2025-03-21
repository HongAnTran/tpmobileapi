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

@Controller("pages")
export class PagesController {
  constructor(private readonly pagesService: PagesService) {}

  @Post("kov")
  create(@Body() createPageDto: any) {
    console.log(createPageDto);
    return true;
  }
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
