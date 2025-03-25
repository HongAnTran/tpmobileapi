import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from "@nestjs/common";
import { CreateProductConsultationDto } from "./dto/create-product-consultation.dto";
import { UpdateProductConsultationDto } from "./dto/update-product-consultation.dto";
import { PrismaService } from "src/prisma.service";
import { ConsultationStatus } from "src/common/types/Product.Type";
import { Prisma } from "@prisma/client";

@Injectable()
export class ProductConsultationService {
  constructor(private prisma: PrismaService) {}

  async create(createProductConsultationDto: CreateProductConsultationDto) {
    const existingConsultation =
      await this.prisma.productConsultation.findFirst({
        where: {
          phone: createProductConsultationDto.phone,
          product_id: createProductConsultationDto.product_id,
        },
      });
    if (existingConsultation) {
      throw new BadRequestException(
        "Bạn đã gửi yêu cầu trước đó, vui lòng chờ."
      );
    }
    return this.prisma.productConsultation.create({
      data: {
        name: createProductConsultationDto.name,
        phone: createProductConsultationDto.phone,
        email: createProductConsultationDto.email,
        message: createProductConsultationDto.message,
        product_id: createProductConsultationDto.product_id,
        tags: createProductConsultationDto.tags,
      },
    });
  }

  async findAll({
    skip,
    take,
    where,
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.ProductConsultationWhereInput;
  }) {
    return this.prisma.productConsultation.findMany({
      skip,
      take,
      where,
      orderBy: { created_at: "desc" },
      include: { product: true },
    });
  }

  async findOne(id: number) {
    const consultation = await this.prisma.productConsultation.findUnique({
      where: { id },
      include: { product: true },
    });

    if (!consultation) {
      throw new NotFoundException(`Yêu cầu tư vấn #${id} không tồn tại`);
    }

    return consultation;
  }

  async update(
    id: number,
    updateProductConsultationDto: UpdateProductConsultationDto
  ) {
    await this.findOne(id);

    return this.prisma.productConsultation.update({
      where: { id },
      data: {
        name: updateProductConsultationDto.name,
        phone: updateProductConsultationDto.phone,
        email: updateProductConsultationDto.email,
        message: updateProductConsultationDto.message,
        tags: updateProductConsultationDto.tags,
      },
    });
  }

  async updateStatus(id: number, status: ConsultationStatus) {
    const consultation = await this.prisma.productConsultation.findUnique({
      where: { id },
    });

    if (!consultation) {
      throw new NotFoundException(`Consultation with ID ${id} not found`);
    }

    return this.prisma.productConsultation.update({
      where: { id },
      data: { status },
    });
  }

  async markAsContacted(id: number) {
    return this.updateStatus(id, ConsultationStatus.CONTACTING);
  }

  async markAsCompleted(id: number) {
    return this.updateStatus(id, ConsultationStatus.COMPLETED);
  }

  async cancelConsultation(id: number) {
    return this.updateStatus(id, ConsultationStatus.CANCELLED);
  }

  async remove(id: number) {
    await this.findOne(id);
    return this.prisma.productConsultation.delete({
      where: { id },
    });
  }
}
