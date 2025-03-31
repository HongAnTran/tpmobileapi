import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { ConsultationPublicService } from "./consultation-public.service";
import { CreateConsultationPublicDto } from "./dto/create-consultation-public.dto";
import { UpdateConsultationPublicDto } from "./dto/update-consultation-public.dto";

@Controller("public/consultations")
export class ConsultationPublicController {
  constructor(
    private readonly consultationPublicService: ConsultationPublicService
  ) {}

  @Post()
  create(@Body() createConsultationPublicDto: CreateConsultationPublicDto) {
    return this.consultationPublicService.create(createConsultationPublicDto);
  }

  // @Get()
  // findAll() {
  //   return this.consultationPublicService.findAll();
  // }

  // @Get(":id")
  // findOne(@Param("id") id: string) {
  //   return this.consultationPublicService.findOne(+id);
  // }

  // @Patch(":id")
  // update(
  //   @Param("id") id: string,
  //   @Body() updateConsultationPublicDto: UpdateConsultationPublicDto
  // ) {
  //   return this.consultationPublicService.update(
  //     +id,
  //     updateConsultationPublicDto
  //   );
  // }

  // @Delete(":id")
  // remove(@Param("id") id: string) {
  //   return this.consultationPublicService.remove(+id);
  // }
}
