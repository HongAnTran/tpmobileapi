/*
  Warnings:

  - You are about to drop the column `product_id` on the `ProductSpecifications` table. All the data in the column will be lost.
  - You are about to drop the column `image_id` on the `ProductVariant` table. All the data in the column will be lost.
  - You are about to drop the `ProductImage` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `featured_image` on table `Product` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Option" DROP CONSTRAINT "Option_product_id_fkey";

-- DropForeignKey
ALTER TABLE "ProductImage" DROP CONSTRAINT "ProductImage_product_id_fkey";

-- DropForeignKey
ALTER TABLE "ProductOrder" DROP CONSTRAINT "ProductOrder_cartId_fkey";

-- DropForeignKey
ALTER TABLE "ProductOrder" DROP CONSTRAINT "ProductOrder_orderId_fkey";

-- DropForeignKey
ALTER TABLE "ProductSpecifications" DROP CONSTRAINT "ProductSpecifications_product_id_fkey";

-- DropForeignKey
ALTER TABLE "ProductVariant" DROP CONSTRAINT "ProductVariant_image_id_fkey";

-- DropForeignKey
ALTER TABLE "ProductVariant" DROP CONSTRAINT "ProductVariant_product_id_fkey";

-- AlterTable
ALTER TABLE "Product" ADD COLUMN     "images" TEXT[] DEFAULT ARRAY[]::TEXT[],
ALTER COLUMN "featured_image" SET NOT NULL,
ALTER COLUMN "featured_image" SET DEFAULT '';

-- AlterTable
ALTER TABLE "ProductSpecifications" DROP COLUMN "product_id";

-- AlterTable
ALTER TABLE "ProductVariant" DROP COLUMN "image_id";

-- DropTable
DROP TABLE "ProductImage";

-- CreateTable
CREATE TABLE "_ProductToProductSpecifications" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ProductToProductSpecifications_AB_unique" ON "_ProductToProductSpecifications"("A", "B");

-- CreateIndex
CREATE INDEX "_ProductToProductSpecifications_B_index" ON "_ProductToProductSpecifications"("B");

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Option" ADD CONSTRAINT "Option_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOrder" ADD CONSTRAINT "ProductOrder_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "Cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOrder" ADD CONSTRAINT "ProductOrder_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToProductSpecifications" ADD CONSTRAINT "_ProductToProductSpecifications_A_fkey" FOREIGN KEY ("A") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ProductToProductSpecifications" ADD CONSTRAINT "_ProductToProductSpecifications_B_fkey" FOREIGN KEY ("B") REFERENCES "ProductSpecifications"("id") ON DELETE CASCADE ON UPDATE CASCADE;
