import { Injectable, NotFoundException } from "@nestjs/common";
import { Prisma, Store } from "@prisma/client";
import { Decimal } from "@prisma/client/runtime/library";
import { PrismaService } from "src/prisma.service";

interface Coord {
  latitude: number;
  longitude: number;
}
@Injectable()
export class StoreService {
  constructor(private prisma: PrismaService) {}

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

  async update(
    id: number,
    updateStoreDto: Prisma.StoreUpdateInput
  ): Promise<Store> {
    // Perform the update
    return await this.prisma.store.update({
      where: { id },
      data: updateStoreDto,
    });
  }

  async remove(id: number): Promise<Store> {
    return this.prisma.store.delete({
      where: { id },
    });
  }

  haversineDistance(coord1: Coord, coord2: Coord) {
    const toRad = (value: number) => (value * Math.PI) / 180;

    const R = 6371; // Bán kính trái đất (km)
    const dLat = toRad(coord2.latitude - coord1.latitude);
    const dLon = toRad(coord2.longitude - coord1.longitude);

    const lat1 = toRad(coord1.latitude);
    const lat2 = toRad(coord2.latitude);

    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(lat1) * Math.cos(lat2) * Math.sin(dLon / 2) * Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c;
  }

  sortStoresByDistance(userLocation: Coord, stores: Store[]) {
    return stores.sort((storeA, storeB) => {
      const distanceA = this.haversineDistance(userLocation, {
        latitude:
          storeA.latitude instanceof Decimal
            ? storeA.latitude.toNumber()
            : storeA.latitude,
        longitude:
          storeA.longitude instanceof Decimal
            ? storeA.longitude.toNumber()
            : storeA.longitude,
      });
      const distanceB = this.haversineDistance(userLocation, {
        latitude:
          storeB.latitude instanceof Decimal
            ? storeB.latitude.toNumber()
            : storeB.latitude,
        longitude:
          storeB.longitude instanceof Decimal
            ? storeB.longitude.toNumber()
            : storeB.longitude,
      });

      return distanceA - distanceB;
    });
  }
}
