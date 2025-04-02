import { BadRequestException, Injectable } from "@nestjs/common";
import { CreateConsultationPublicDto } from "./dto/create-consultation-public.dto";
import { UpdateConsultationPublicDto } from "./dto/update-consultation-public.dto";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class ConsultationPublicService {
  constructor(private prisma: PrismaService) {}

  async create(createProductConsultationDto: CreateConsultationPublicDto) {
    const existingConsultation =
      await this.prisma.productConsultation.findFirst({
        where: {
          phone: createProductConsultationDto.phone,
          product_id: createProductConsultationDto.product_id,
        },
      });
    if (existingConsultation) {
      throw new BadRequestException("Bạn đã gửi yêu cầu trước đó.");
    }
    return this.prisma.productConsultation.create({
      data: {
        name: createProductConsultationDto.name,
        phone: createProductConsultationDto.phone,
        email: createProductConsultationDto.email,
        message: createProductConsultationDto.message,
        product_id: createProductConsultationDto.product_id,
        gender:createProductConsultationDto.gender,
        tags: createProductConsultationDto.tags,
      },
    });
  }

  findAll() {
    return `This action returns all consultationPublic`;
  }

  findOne(id: number) {
    return `This action returns a #${id} consultationPublic`;
  }

  update(id: number, updateConsultationPublicDto: UpdateConsultationPublicDto) {
    return `This action updates a #${id} consultationPublic`;
  }

  remove(id: number) {
    return `This action removes a #${id} consultationPublic`;
  }
}
