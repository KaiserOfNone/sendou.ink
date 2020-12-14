-- CreateEnum
CREATE TYPE "public"."SalmonRunRecordCategory" AS ENUM ('TOTAL', 'TOTAL_NO_NIGHT', 'PRINCESS', 'NT_NORMAL', 'HT_NORMAL', 'LT_NORMAL', 'NT_RUSH', 'HT_RUSH', 'NT_FOG', 'HT_FOG', 'LT_FOG', 'NT_GOLDIE', 'HT_GOLDIE', 'NT_GRILLERS', 'HT_GRILLERS', 'NT_MOTHERSHIP', 'HT_MOTHERSHIP', 'LT_MOTHERSHIP', 'LT_COHOCK');

-- CreateTable
CREATE TABLE "SalmonRunRotation" (
    "id" INTEGER NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "weapons" TEXT[],
    "grizzcoWeapon" TEXT,
    "stage" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "SalmonRunRecord" (
"id" SERIAL,
    "rotationId" INTEGER NOT NULL,
    "submitterId" INTEGER NOT NULL,
    "goldenEggCount" INTEGER NOT NULL,
    "approved" BOOLEAN NOT NULL,
    "category" "SalmonRunRecordCategory" NOT NULL,
    "links" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SalmonRunPlayer" (
    "recordId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "SalmonRunRotation.id_unique" ON "SalmonRunRotation"("id");

-- CreateIndex
CREATE UNIQUE INDEX "SalmonRunPlayer.recordId_userId_unique" ON "SalmonRunPlayer"("recordId", "userId");

-- AddForeignKey
ALTER TABLE "SalmonRunRecord" ADD FOREIGN KEY("rotationId")REFERENCES "SalmonRunRotation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalmonRunRecord" ADD FOREIGN KEY("submitterId")REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalmonRunPlayer" ADD FOREIGN KEY("recordId")REFERENCES "SalmonRunRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SalmonRunPlayer" ADD FOREIGN KEY("userId")REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
