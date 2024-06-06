/*
  Warnings:

  - Added the required column `price` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price_max` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price_min` to the `Product` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "featured_image" TEXT,
ADD COLUMN     "price" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "price_max" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "price_min" DOUBLE PRECISION NOT NULL;
