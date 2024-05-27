-- CreateTable
CREATE TABLE "anchor" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "bssid" TEXT NOT NULL,
    "xcord" DOUBLE PRECISION NOT NULL,
    "ycord" DOUBLE PRECISION NOT NULL,
    "created_on" TIMESTAMP(0) NOT NULL,
    "modified_on" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "anchor_pkey" PRIMARY KEY ("id")
);
