-- CreateTable
CREATE TABLE "Store" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT,
    "url_map" TEXT,

    CONSTRAINT "Store_pkey" PRIMARY KEY ("id")
);
