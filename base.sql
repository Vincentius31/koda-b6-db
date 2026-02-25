CREATE TABLE roles (
   "id_roles" SERIAL PRIMARY KEY,
   "name_roles" VARCHAR(50) NOT NULL
);

CREATE TABLE users (
   "id_user" SERIAL PRIMARY KEY,
   "roles_id" INT,
   "fullname" VARCHAR(100) NOT NULL,
   "email" VARCHAR(100) UNIQUE NOT NULL,
   "password" VARCHAR(255) NOT NULL,
   "address" TEXT,
   "phone" VARCHAR(20),
   "profile_picture" VARCHAR(255),
   CONSTRAINT "fk_user_roles" FOREIGN KEY ("roles_id") REFERENCES "roles"("id_roles") ON DELETE SET NULL
);

CREATE TABLE category (
   "id_category" SERIAL PRIMARY KEY,
   "name_category" VARCHAR(100) NOT NULL
);

CREATE TABLE products (
   "id_product" SERIAL PRIMARY KEY,
   "name" VARCHAR(150) NOT NULL,
   "desc" TEXT,
   "price" INT NOT NULL,
   "quantity" INT DEFAULT 0,
   "is_active" BOOLEAN DEFAULT TRUE
);

CREATE TABLE products_category (
   "product_id" INT,
   "category_id" INT,
   PRIMARY KEY ("product_id", "category_id"), 
   CONSTRAINT "fk_pc_product" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE,
   CONSTRAINT "fk_pc_category" FOREIGN KEY ("category_id") REFERENCES "category"("id_category") ON DELETE CASCADE
);

CREATE TABLE product_images (
   "id_image" SERIAL PRIMARY KEY,
   "product_id" INT,
   "path" VARCHAR(255) NOT NULL,
   CONSTRAINT "fk_img_product" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE
);

CREATE TABLE product_variant (
   "id_variant" SERIAL PRIMARY KEY,
   "product_id" INT,
   "variant_name" VARCHAR(100),
   "additional_price" INT DEFAULT 0,
   CONSTRAINT "fk_var_product" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE
);

CREATE TABLE product_size (
   "id_size" SERIAL PRIMARY KEY,
   "product_id" INT,
   "size_name" VARCHAR(50),
   "additional_price" INT DEFAULT 0,
   CONSTRAINT "fk_size_product" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE
);

CREATE TABLE discount (
   "id_discount" SERIAL PRIMARY KEY,
   "product_id" INT,
   "discount_rate" FLOAT NOT NULL,
   "description" VARCHAR(255),
   "is_flash_sale" BOOLEAN DEFAULT FALSE,
   CONSTRAINT "fk_disc_product" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE
);

CREATE TABLE cart (
   "id_cart" SERIAL PRIMARY KEY,
   "user_id" INT,
   "product_id" INT,
   "variant_id" INT,
   "size_id" INT,
   "quantity" INT NOT NULL DEFAULT 1,
   CONSTRAINT "fk_cart_user" FOREIGN KEY ("user_id") REFERENCES "users"("id_user") ON DELETE CASCADE,
   CONSTRAINT "fk_cart_prod" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE,
   CONSTRAINT "fk_cart_var" FOREIGN KEY ("variant_id") REFERENCES "product_variant"("id_variant"),
   CONSTRAINT "fk_cart_size" FOREIGN KEY ("size_id") REFERENCES "product_size"("id_size")
);

CREATE TABLE "transaction" ( 
   "id_transaction" SERIAL PRIMARY KEY,
   "user_id" INT,
   "transaction_number" VARCHAR(50),
   "delivery_method" VARCHAR(50),
   "subtotal" INT NOT NULL,
   "total" INT NOT NULL,
   "status" VARCHAR(50) DEFAULT 'Pending',
   "payment_method" VARCHAR(50),
   "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT "fk_trans_user" FOREIGN KEY ("user_id") REFERENCES "users"("id_user") ON DELETE SET NULL
);

CREATE TABLE transaction_product (
   "id_trans_prod" SERIAL PRIMARY KEY,
   "transaction_id" INT,
   "product_id" INT,
   "quantity" INT NOT NULL,
   "size" VARCHAR(50),
   "variant" VARCHAR(100),  
   "price" INT NOT NULL,
   CONSTRAINT "fk_tp_trans" FOREIGN KEY ("transaction_id") REFERENCES "transaction"("id_transaction") ON DELETE CASCADE,
   CONSTRAINT "fk_tp_prod" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE SET NULL
);

CREATE TABLE review (
   "id_review" SERIAL PRIMARY KEY,
   "user_id" INT,
   "product_id" INT,
   "messages" TEXT,
   "rating" FLOAT CHECK ("rating" >= 1 AND rating <= 5),
   CONSTRAINT "fk_rev_user" FOREIGN KEY ("user_id") REFERENCES "users"("id_user") ON DELETE CASCADE,
   CONSTRAINT "fk_rev_prod" FOREIGN KEY ("product_id") REFERENCES "products"("id_product") ON DELETE CASCADE
);

INSERT INTO "roles" ("name_roles") VALUES ('admin'), ('user');

INSERT INTO "category" ("name_category") VALUES ('Coffee'), ('Non Coffee'), ('Foods'), ('Add-On');

INSERT INTO "users" ("roles_id", "fullname", "email", "password", "address", "phone") VALUES 
(1, 'Admin Ganteng', 'admin@mail.com', '1234', 'Jakarta Selatan', '08123456789'),
(2, 'Budi Santoso', 'budi@mail.com', '1234', 'Bandung City', '08223456789'),
(2, 'Siti Aminah', 'siti@mail.com', '1234', 'Surabaya Central', '08323456789'),
(2, 'Andi Wijaya', 'andi@mail.com', '1234', 'Medan Baru', '08423456789'),
(2, 'Dewi Lestari', 'dewi@mail.com', '1234', 'Yogyakarta', '08523456789'),
(2, 'Eko Prasetyo', 'eko@mail.com', '1234', 'Semarang Kota', '08623456789'),
(2, 'Fitri Yani', 'fitri@mail.com', '1234', 'Makassar', '08723456789'),
(2, 'Gilang Ramadhan', 'gilang@mail.com', '1234', 'Denpasar', '08823456789'),
(2, 'Hany Safitri', 'hany@mail.com', '1234', 'Palembang', '08923456789'),
(2, 'Iwan Fals', 'iwan@mail.com', '1234', 'Bogor', '08023456789');

UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg' WHERE "id_user" = 1;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg' WHERE "id_user" = 2;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg' WHERE "id_user" = 3;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg' WHERE "id_user" = 4;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg' WHERE "id_user" = 5;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg' WHERE "id_user" = 6;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg' WHERE "id_user" = 7;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg' WHERE "id_user" = 8;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/1181519/pexels-photo-1181519.jpeg' WHERE "id_user" = 9;
UPDATE "users" SET "profile_picture" = 'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg' WHERE "id_user" = 10;

INSERT INTO "products" ("name", "desc", "price", "quantity", "is_active") VALUES 
('Espresso', 'Kopi hitam pekat', 20000, 100, TRUE),
('Cafe Latte', 'Kopi susu lembut', 30000, 80, TRUE),
('Matcha Latte', 'Teh hijau jepang dengan susu', 35000, 50, TRUE),
('Croissant', 'Roti mentega khas Perancis', 25000, 30, TRUE),
('Nasi Goreng Spesial', 'Nasi goreng dengan telur dan ayam', 45000, 40, TRUE),
('Chocolate Ice', 'Cokelat dingin premium', 28000, 60, TRUE),
('Americano', 'Kopi hitam dengan air panas', 22000, 100, TRUE),
('Fried Chicken', 'Ayam goreng krispi', 35000, 25, TRUE),
('Caramel Macchiato', 'Kopi manis karamel', 38000, 45, TRUE),
('Taro Latte', 'Minuman talas ungu', 32000, 55, TRUE);

INSERT INTO "products_category" ("product_id", "category_id") VALUES 
(1,1), (2,1), (3,2), (4,3), (5,3), (6,2), (7,1), (8,3), (9,1), (10,2);

INSERT INTO "product_images" ("product_id", "path") VALUES 
(1, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg'),
(2, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg'),
(3, 'https://images.pexels.com/photos/5946637/pexels-photo-5946637.jpeg'),
(4, 'https://images.pexels.com/photos/3892461/pexels-photo-3892461.jpeg'),
(5, 'https://images.pexels.com/photos/2092906/pexels-photo-2092906.jpeg'),
(6, 'https://images.pexels.com/photos/1187317/pexels-photo-1187317.jpeg'),
(7, 'https://images.pexels.com/photos/4348444/pexels-photo-4348444.jpeg'),
(8, 'https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg'),
(9, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg'),
(10, 'https://images.pexels.com/photos/5947020/pexels-photo-5947020.jpeg');


INSERT INTO "product_variant" ("product_id", "variant_name", "additional_price") VALUES 
(1, 'Hot', 0), (2, 'Ice', 2000), (5, 'Spicy', 5000), (8, 'Non-Spicy', 0);


INSERT INTO "product_size" ("product_id", "size_name", "additional_price") VALUES 
(1, 'Regular', 0), (2, 'Medium', 3000), (3, 'Large', 5000), (7, '250gr', 50000);

INSERT INTO "transaction" ("user_id", "transaction_number", "delivery_method", "subtotal", "total", "status", "payment_method") VALUES 
(2, 'ORD-2026022509301234', 'Pick Up', 60000, 65000, 'Success', 'Cash'),
(3, 'ORD-2026022509355678', 'Dine In', 35000, 35000, 'Success', 'Cash'),
(4, 'ORD-2026022509409912', 'Take Away', 45000, 45000, 'Pending', 'Cash');

INSERT INTO "transaction_product" ("transaction_id", "product_id", "quantity", "size", "variant", "price") VALUES 
(1, 2, 2, 'Medium', 'Ice', 60000),
(2, 3, 1, 'Large', 'Ice', 35000),
(3, 5, 1, 'Regular', 'Spicy', 45000);
