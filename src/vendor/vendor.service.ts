import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma   , Vendor } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class VendorService {
  constructor(private prisma: PrismaService) { }

  async create(createVendorDto: Prisma.VendorCreateInput): Promise<Vendor> {
    return this.prisma.vendor.create({ data: createVendorDto });
  }

  async findAll(): Promise<Vendor[]> {
    return this.prisma.vendor.findMany();
  }
  async findOne(id: number): Promise<Vendor | null> {
    const Vendor = await this.prisma.vendor.findUnique({
      where: { id },
    });
    if (!Vendor) {
      throw new NotFoundException(`Vendor with id ${id} not found`);
    }
    return Vendor;
  }



  async update(id: number, updateVendorDto: Prisma.VendorUpdateInput): Promise<Vendor> {
    // Perform the update
    return await this.prisma.vendor.update({
      where: { id },
      data: updateVendorDto
    });

  }

  async remove(id: number): Promise<Vendor> {
    return this.prisma.vendor.delete({
      where: { id },
    });
  }
}
