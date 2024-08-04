-- CreateTable
CREATE TABLE "groups" (
    "pk_id" SERIAL NOT NULL,
    "group_name" VARCHAR(255) NOT NULL,
    "date_created" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "groups_pkey" PRIMARY KEY ("pk_id")
);

-- CreateTable
CREATE TABLE "usergroups" (
    "pk_id" SERIAL NOT NULL,
    "fk_user_id" SERIAL NOT NULL,
    "fk_group_id" SERIAL NOT NULL,
    "date_created" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "role" INTEGER NOT NULL,

    CONSTRAINT "usergroups_pkey" PRIMARY KEY ("pk_id")
);

-- CreateTable
CREATE TABLE "userproducts" (
    "pk_id" SERIAL NOT NULL,
    "fk_user_id" SERIAL NOT NULL,
    "fk_group_id" SERIAL NOT NULL,
    "category_name" VARCHAR(255) NOT NULL,
    "amount" INTEGER NOT NULL,
    "date_created" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "userproducts_pkey" PRIMARY KEY ("pk_id")
);

-- CreateTable
CREATE TABLE "users" (
    "pk_id" SERIAL NOT NULL,
    "user_name" VARCHAR(255) NOT NULL,
    "login_name" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "date_created" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "is_admin" INTEGER NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("pk_id")
);

-- AddForeignKey
ALTER TABLE "usergroups" ADD CONSTRAINT "usergroups_fk_group_id_fkey" FOREIGN KEY ("fk_group_id") REFERENCES "groups"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usergroups" ADD CONSTRAINT "usergroups_fk_user_id_fkey" FOREIGN KEY ("fk_user_id") REFERENCES "users"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userproducts" ADD CONSTRAINT "userproducts_fk_group_id_fkey" FOREIGN KEY ("fk_group_id") REFERENCES "groups"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "userproducts" ADD CONSTRAINT "userproducts_fk_user_id_fkey" FOREIGN KEY ("fk_user_id") REFERENCES "users"("pk_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
