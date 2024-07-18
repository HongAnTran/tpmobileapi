import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma   , Location } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class LocationService {
  constructor(private prisma: PrismaService) { }

  async create(createLocationDto: Prisma.LocationCreateInput): Promise<Location> {
    return this.prisma.location.create({ data: createLocationDto });
  }

  async findAll(where?: Prisma.LocationWhereInput): Promise<Location[]> {
    return this.prisma.location.findMany({
      where : where
    });
  }
  async findOne(id: number): Promise<Location | null> {
    const Location = await this.prisma.location.findUnique({
      where: { id },
    });
    if (!Location) {
      throw new NotFoundException(`Location with id ${id} not found`);
    }
    return Location;
  }



  async update(id: number, updateLocationDto: Prisma.LocationUpdateInput): Promise<Location> {
    // Perform the update
    return await this.prisma.location.update({
      where: { id },
      data: updateLocationDto
    });

  }

  async remove(id: number): Promise<Location> {
    return this.prisma.location.delete({
      where: { id },
    });
  }
}
