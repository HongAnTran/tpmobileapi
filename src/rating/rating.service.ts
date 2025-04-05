import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma, Rating } from "@prisma/client";
import { ResponseList } from "src/common/types/Common.type";
import { PrismaService } from "src/prisma.service";

@Injectable()
export class RatingService {
  constructor(private prisma: PrismaService) {}

  async create(createRatingDto: Prisma.RatingCreateInput): Promise<Rating> {
    return this.prisma.rating.create({ data: createRatingDto });
  }

  async createMany(
    createRatingDto: Prisma.RatingCreateManyInput []
  ) {
    return this.prisma.rating.createMany({ data:createRatingDto  });
  }

  async findAll({
    where,
    skip,
    take
  }: {
    where: Prisma.RatingWhereInput;
    skip?: number ,
    take?: number
  }): Promise<ResponseList<Rating>> {

    const datas = await this.prisma.rating.findMany({ where , skip  , take });
    const total = await this.prisma.rating.count({ where , skip  , take });
    return {
      datas,
      total
    }
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
  async update(
    id: number,
    updateRatingDto: Prisma.RatingUpdateInput
  ): Promise<Rating> {
    // Perform the update
    return await this.prisma.rating.update({
      where: { id },
      data: updateRatingDto,
    });
  }

  async remove(id: number): Promise<Rating> {
    return this.prisma.rating.delete({
      where: { id },
    });
  }
}
