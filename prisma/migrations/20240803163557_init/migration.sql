/*
  Warnings:

  - The primary key for the `groups` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `usergroups` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `userproducts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "usergroups" DROP CONSTRAINT "usergroups_fk_group_id_fkey";

-- DropForeignKey
ALTER TABLE "usergroups" DROP CONSTRAINT "usergroups_fk_user_id_fkey";

-- DropForeignKey
ALTER TABLE "userproducts" DROP CONSTRAINT "userproducts_fk_group_id_fkey";

-- DropForeignKey
ALTER TABLE "userproducts" DROP CONSTRAINT "userproducts_fk_user_id_fkey";

-- AlterTable
ALTER TABLE "groups" DROP CONSTRAINT "groups_pkey",
ALTER COLUMN "pk_id" SET DATA TYPE BIGSERIAL,
ADD CONSTRAINT "groups_pkey" PRIMARY KEY ("pk_id");

-- AlterTable
ALTER TABLE "usergroups" DROP CONSTRAINT "usergroups_pkey",
ALTER COLUMN "pk_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "fk_user_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "fk_group_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "role" SET DATA TYPE BIGINT,
ADD CONSTRAINT "usergroups_pkey" PRIMARY KEY ("pk_id");

-- AlterTable
ALTER TABLE "userproducts" DROP CONSTRAINT "userproducts_pkey",
ALTER COLUMN "pk_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "fk_user_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "fk_group_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "amount" SET DATA TYPE BIGINT,
ADD CONSTRAINT "userproducts_pkey" PRIMARY KEY ("pk_id");

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ALTER COLUMN "pk_id" SET DATA TYPE BIGSERIAL,
ALTER COLUMN "is_admin" SET DATA TYPE BIGINT,
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("pk_id");

-- AddForeignKey
ALTER TABLE "usergroups" ADD CONSTRAINT "usergroups_fk_group_id_fkey" FOREIGN KEY ("fk_group_id") REFERENCES "groups"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usergroups" ADD CONSTRAINT "usergroups_fk_user_id_fkey" FOREIGN KEY ("fk_user_id") REFERENCES "users"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userproducts" ADD CONSTRAINT "userproducts_fk_group_id_fkey" FOREIGN KEY ("fk_group_id") REFERENCES "groups"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userproducts" ADD CONSTRAINT "userproducts_fk_user_id_fkey" FOREIGN KEY ("fk_user_id") REFERENCES "users"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
