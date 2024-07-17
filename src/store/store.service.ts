import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, Store } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class StoreService {
  constructor(private prisma: PrismaService) { }

  async create(createStoreDto: Prisma.StoreCreateInput): Promise<Store> {
    return this.prisma.store.create({ data: createStoreDto });
  }

  async findAll(): Promise<Store[]> {
    return this.prisma.store.findMany();
  }
  async findOne(id: number): Promise<Store | null> {
    const Store = await this.prisma.store.findUnique({
      where: { id },
    });
    if (!Store) {
      throw new NotFoundException(`Store with id ${id} not found`);
    }
    return Store;
  }



  async update(id: number, updateStoreDto: Prisma.StoreUpdateInput): Promise<Store> {
    // Perform the update
    return await this.prisma.store.update({
      where: { id },
      data: updateStoreDto
    });

  }

  async remove(id: number): Promise<Store> {
    return this.prisma.store.delete({
      where: { id },
    });
  }
}
