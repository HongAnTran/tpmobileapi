import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, Rating } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class RatingService {
  constructor(private prisma: PrismaService) { }

  async create(createRatingDto: Prisma.RatingCreateInput): Promise<Rating> {
    return this.prisma.rating.create({ data: createRatingDto });
  }

  async findAll(): Promise<Rating[]> {
    return this.prisma.rating.findMany();
  }
  async findOne(id: number): Promise<Rating | null> {
    const Rating = await this.prisma.rating.findUnique({
      where: { id },
    });
    if (!Rating) {
      throw new NotFoundException(`Rating with id ${id} not found`);
    }
    return Rating;
  }



  async update(id: number, updateRatingDto: Prisma.RatingUpdateInput): Promise<Rating> {
    // Perform the update
    return await this.prisma.rating.update({
      where: { id },
      data: updateRatingDto
    });

  }

  async remove(id: number): Promise<Rating> {
    return this.prisma.rating.delete({
      where: { id },
    });
  }
}
