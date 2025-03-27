import { Injectable } from '@nestjs/common';
import { CreateCartPublicDto } from './dto/create-cart-public.dto';
import { UpdateCartPublicDto } from './dto/update-cart-public.dto';

@Injectable()
export class CartPublicService {
  create(createCartPublicDto: CreateCartPublicDto) {
    return 'This action adds a new cartPublic';
  }

  findAll() {
    return `This action returns all cartPublic`;
  }

  findOne(id: number) {
    return `This action returns a #${id} cartPublic`;
  }

  update(id: number, updateCartPublicDto: UpdateCartPublicDto) {
    return `This action updates a #${id} cartPublic`;
  }

  remove(id: number) {
    return `This action removes a #${id} cartPublic`;
  }
}
