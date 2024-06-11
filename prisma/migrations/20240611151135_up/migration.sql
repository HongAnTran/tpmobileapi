-- DropForeignKey
ALTER TABLE "ProductVariant" DROP CONSTRAINT "ProductVariant_image_id_fkey";

-- AlterTable
ALTER TABLE "ProductVariant" ALTER COLUMN "image_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "ProductVariant" ADD CONSTRAINT "ProductVariant_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "ProductImage"("id") ON DELETE SET NULL ON UPDATE CASCADE;
