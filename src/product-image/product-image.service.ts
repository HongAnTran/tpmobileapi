import { Injectable } from '@nestjs/common';
import { PrismaService } from './../prisma.service';
import { Prisma, ProductImage } from '@prisma/client';
import { StaticService } from '../static/static.service';


@Injectable()
export class ProductImageService {
  constructor(private prisma: PrismaService , private readonly staticService : StaticService) { }

  async create(data: Prisma.ProductImageCreateInput) {
    return this.prisma.productImage.create({
      data,
    });
  }

  async findAll({
    skip,
    take,
    where,
  }: {
    skip?: number;
    take?: number;
    where?: Prisma.ProductImageWhereInput;
  }) {
    return this.prisma.productImage.findMany({
      where,
      skip,
      take,
    });
  }

  async findOne(id: number) {
    return this.prisma.productImage.findUnique({
      where: { id },
    });
  }

  async update(id: number, data: Prisma.ProductImageUpdateInput) {
    return this.prisma.productImage.update({
      where: { id },
      data,
    });
  }

  async remove(id: number) {
    return this.prisma.productImage.delete({
      where: { id },
    });
  }


  async updateProductImages() {
    // Step 1: Fetch all product images from Prisma
    const productImages: ProductImage[] = await this.prisma.productImage.findMany();

    // Step 2: Remove duplicates based on URL
    const uniqueImages = Array.from(new Map(productImages.map(image => [image.url, image])).values());

    // Step 3: Upload each unique image URL and get new secure URLs
    const uploadResults = await Promise.all(
      uniqueImages.map(image => this.staticService.uploadImageFormURLToCloudinary(image.url))
    );

    // Step 4: Map new URLs back to the original product images
    const updatedImages = productImages.map(image => {
      const newUrl = uploadResults.find((result, index) => uniqueImages[index].url === image.url)?.url;
      return newUrl ? { ...image, url: newUrl } : image;
    });

    // Step 5: Update each product image in the database with the new URL
    const updatePromises = updatedImages.map(image =>
      this.prisma.productImage.update({
        where: { id: image.id },
        data: { url: image.url },
      })
    );

    await Promise.all(updatePromises);

    return updatedImages; 
  }
}
