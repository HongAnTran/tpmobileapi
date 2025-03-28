import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CartPublicService } from './cart-public.service';
import { CreateCartPublicDto } from './dto/create-cart-public.dto';
import { UpdateCartPublicDto } from './dto/update-cart-public.dto';

@Controller('public/carts')
export class CartPublicController {
  constructor(private readonly cartPublicService: CartPublicService) {}

  @Post()
  create(@Body() createCartPublicDto: CreateCartPublicDto) {
    return this.cartPublicService.create(createCartPublicDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.cartPublicService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCartPublicDto: UpdateCartPublicDto) {
    return this.cartPublicService.update(+id, updateCartPublicDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.cartPublicService.remove(+id);
  }
}
