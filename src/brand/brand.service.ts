import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, Brand } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class BrandService {
  constructor(private prisma: PrismaService) { }

  async create(createBrandDto: Prisma.BrandCreateInput): Promise<Brand> {
    return this.prisma.brand.create({ data: createBrandDto });
  }

  async findAll(): Promise<Brand[]> {
    return this.prisma.brand.findMany();
  }
  async findOne(id: number): Promise<Brand | null> {
    const Brand = await this.prisma.brand.findUnique({
      where: { id },
    });
    if (!Brand) {
      throw new NotFoundException(`Brand with id ${id} not found`);
    }
    return Brand;
  }



  async update(id: number, updateBrandDto: Prisma.BrandUpdateInput): Promise<Brand> {
    // Perform the update
    return await this.prisma.brand.update({
      where: { id },
      data: updateBrandDto
    });

  }

  async remove(id: number): Promise<Brand> {
    return this.prisma.brand.delete({
      where: { id },
    });
  }
}
