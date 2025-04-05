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

    const datas = await this.prisma.rating.findMany({ where , skip  , take , orderBy: { created_at: "desc" } });
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

  async updateManyProductRating( products: number[]) {
    for (const id of products) {
      await this.updateProductRating(id);
    }
  }
  async updateProductRating(productId: number) {
    const allRatings = await this.prisma.rating.findMany({
      where: { product_id: productId },
      select: { rate: true, is_seeding: true },
    });
  
    if (allRatings.length === 0) {
      await this.prisma.product.update({
        where: { id: productId },
        data: { rating: null },
      });
      return;
    }
    // Tính toán rating tổng
    const count = allRatings.length;
    const sum = allRatings.reduce((acc, r) => acc + r.rate, 0);
    const average = count > 0 ? parseFloat((sum / count).toFixed(1)) : 0
    // Lọc bỏ rating seeding
    const realRatings = allRatings.filter(r => !r.is_seeding);
    const countReal = realRatings.length;
    const sumReal = realRatings.reduce((acc, r) => acc + r.rate, 0);
    const averageReal = countReal > 0 ? parseFloat((sumReal / countReal).toFixed(1)) : 0;
    await this.prisma.product.update({
      where: { id: productId },
      data: { 
        rating_count: count,
        average_rating: average,
        rating: { 
          average : averageReal, count : countReal ,
         },
      
      },
    });
  }
}
