import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from "@nestjs/common";
import { PagesService } from "./pages.service";
import { CreatePageDto } from "./dto/create-page.dto";
import { UpdatePageDto } from "./dto/update-page.dto";
import { Public } from "src/common/decorator/public.decorator";
import { AuthGuard } from "src/auth/jwt.guard";

@Controller("pages")
@UseGuards(AuthGuard)
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

  @Patch(":id")
  update(@Param("id") id: string, @Body() updatePageDto: UpdatePageDto) {
    return this.pagesService.update(+id, updatePageDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.pagesService.remove(+id);
  }
}
