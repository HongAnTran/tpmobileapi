-- AlterTable
ALTER TABLE "Article" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Store" ALTER COLUMN "phone" DROP NOT NULL;

-- DropEnum
DROP TYPE "ProductStatus";