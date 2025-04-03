import { BadRequestException, Injectable } from "@nestjs/common";
import { CreateConsultationPublicDto } from "./dto/create-consultation-public.dto";
import { UpdateConsultationPublicDto } from "./dto/update-consultation-public.dto";
import { PrismaService } from "src/prisma.service";
import { TelebotService } from "src/telebot/telebot.service";

@Injectable()
export class ConsultationPublicService {
  constructor(private prisma: PrismaService,
    private readonly telebotService: TelebotService,
  ) {}

  async create(createProductConsultationDto: CreateConsultationPublicDto) {
    // Kiểm tra xem yêu cầu đã tồn tại chưa
    const existingConsultation = await this.prisma.productConsultation.findFirst({
      where: {
        phone: createProductConsultationDto.phone,
        product_id: createProductConsultationDto.product_id,
      },
    });

    if (existingConsultation) {
      throw new BadRequestException('Bạn đã gửi yêu cầu trước đó.');
    }

    // Tạo yêu cầu tư vấn mới
    const newConsultation = await this.prisma.productConsultation.create({
      data: {
        name: createProductConsultationDto.name,
        phone: createProductConsultationDto.phone,
        email: createProductConsultationDto.email,
        message: createProductConsultationDto.message,
        product_id: createProductConsultationDto.product_id,
        gender: createProductConsultationDto.gender,
        tags: createProductConsultationDto.tags,
      },
      include:{
        product :{
          select :{
            id : true,
            title : true,
            slug : true,
            price : true,
          }
        }
      }
    });

    // Gửi tin nhắn đến nhóm Telegram qua Bull Queue
    const telegramMessage = `
      Yêu cầu tư vấn mới:
      - Tên: ${newConsultation.name}
      - SĐT: ${newConsultation.phone}
      - Email: ${newConsultation.email || 'Không có'}
      - Sản phẩm: ${newConsultation.product.title}
      - Tin nhắn: ${newConsultation.message || 'Không có'}
      - Giới tính: ${newConsultation.gender || 'Không xác định'}
      - ngày tạo: ${newConsultation.created_at.toLocaleDateString('vi-VN')}
    `;

    const groupChatId = process.env.TELE_CHATID; 
    await this.telebotService.queueMessage(groupChatId, telegramMessage);

    return newConsultation; 
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
