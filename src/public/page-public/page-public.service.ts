import { Injectable } from '@nestjs/common';
import { CreatePagePublicDto } from './dto/create-page-public.dto';
import { UpdatePagePublicDto } from './dto/update-page-public.dto';

@Injectable()
export class PagePublicService {
  create(createPagePublicDto: CreatePagePublicDto) {
    return 'This action adds a new pagePublic';
  }

  findAll() {
    return `This action returns all pagePublic`;
  }

  findOne(id: number) {
    return `This action returns a #${id} pagePublic`;
  }

  update(id: number, updatePagePublicDto: UpdatePagePublicDto) {
    return `This action updates a #${id} pagePublic`;
  }

  remove(id: number) {
    return `This action removes a #${id} pagePublic`;
  }
}
