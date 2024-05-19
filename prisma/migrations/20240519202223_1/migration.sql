-- CreateTable
CREATE TABLE "role" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "created_on" TIMESTAMP(0) NOT NULL,
    "modified_on" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tag" (
    "id" SERIAL NOT NULL,
    "password" VARCHAR(100) NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL,
    "token" VARCHAR(255),
    "xcord" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "ycord" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "role_id" INTEGER DEFAULT 1,
    "created_on" TIMESTAMP(0) NOT NULL,
    "modified_on" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coords" (
    "id" SERIAL NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "rssi1" INTEGER NOT NULL,
    "rssi2" INTEGER NOT NULL,
    "rssi3" INTEGER NOT NULL,
    "rssi4" INTEGER NOT NULL,
    "created_on" TIMESTAMP(0) NOT NULL,
    "modified_on" TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "coords_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "tag_email_key" ON "tag"("email");

-- AddForeignKey
ALTER TABLE "tag" ADD CONSTRAINT "tag_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coords" ADD CONSTRAINT "coords_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
