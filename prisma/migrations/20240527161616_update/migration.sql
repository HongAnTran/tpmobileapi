/*
  Warnings:

  - The values [HIDDEN] on the enum `ProductStatus` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `create_id` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `imageId` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `rating` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `store_id` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `variant_ids` on the `ProductImage` table. All the data in the column will be lost.
  - You are about to drop the column `inventory_management` on the `ProductVariant` table. All the data in the column will be lost.
  - You are about to drop the `ProductOption` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[slug,title]` on the table `Category` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[slug,title,barcode]` on the table `Product` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[sku,title,barcode]` on the table `ProductVariant` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ProductStatus_new" AS ENUM ('DRAFT', 'SHOW');
ALTER TABLE "Product" ALTER COLUMN "status" TYPE "ProductStatus_new" USING ("status"::text::"ProductStatus_new");
ALTER TYPE "ProductStatus" RENAME TO "ProductStatus_old";
ALTER TYPE "ProductStatus_new" RENAME TO "ProductStatus";
DROP TYPE "ProductStatus_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "ProductOption" DROP CONSTRAINT "ProductOption_product_id_fkey";

-- AlterTable
ALTER TABLE "Category" ALTER COLUMN "image" DROP NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'DRAFT';

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "create_id",
DROP COLUMN "imageId",
DROP COLUMN "rating",
DROP COLUMN "store_id",
ALTER COLUMN "description_html" DROP NOT NULL,
ALTER COLUMN "vendor" DROP NOT NULL,
ALTER COLUMN "status" SET DEFAULT 'DRAFT',
ALTER COLUMN "created_at" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "updated_at" DROP NOT NULL,
ALTER COLUMN "published_at" DROP NOT NULL,
ALTER COLUMN "short_description" DROP NOT NULL,
ALTER COLUMN "meta_title" DROP NOT NULL,
ALTER COLUMN "meta_description" DROP NOT NULL,
ALTER COLUMN "meta_keywords" DROP NOT NULL;

-- AlterTable
ALTER TABLE "ProductImage" DROP COLUMN "variant_ids";

-- AlterTable
ALTER TABLE "ProductVariant" DROP COLUMN "inventory_management";

-- DropTable
DROP TABLE "ProductOption";

-- CreateTable
CREATE TABLE "Option" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "values" TEXT[],

    CONSTRAINT "Option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpecificationsType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "SpecificationsType_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Category_slug_title_key" ON "Category"("slug", "title");

-- CreateIndex
CREATE UNIQUE INDEX "Product_slug_title_barcode_key" ON "Product"("slug", "title", "barcode");

-- CreateIndex
CREATE UNIQUE INDEX "ProductVariant_sku_title_barcode_key" ON "ProductVariant"("sku", "title", "barcode");

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "ProductImage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Option" ADD CONSTRAINT "Option_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSpecifications" ADD CONSTRAINT "ProductSpecifications_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "SpecificationsType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
