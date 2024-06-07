/*
  Warnings:

  - You are about to drop the `coords` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "coords" DROP CONSTRAINT "coords_tag_id_fkey";

-- AlterTable
ALTER TABLE "tag" ADD COLUMN     "rssi1" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "rssi2" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "rssi3" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "rssi4" INTEGER NOT NULL DEFAULT 0;

-- DropTable
DROP TABLE "coords";
