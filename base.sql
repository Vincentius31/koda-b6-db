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
(1,1), 
(2,1), 
(3,2), 
(4,3), 
(5,3), 
(6,2), 
(7,1), 
(8,3), 
(9,1), 
(10,2);

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
(1, 'Hot', 0), (1, 'Ice', 2000),
(2, 'Hot', 0), (2, 'Ice', 2000),
(7, 'Hot', 0), (7, 'Ice', 2000),
(9, 'Hot', 0), (9, 'Ice', 2000),
(3, 'Hot', 0), (3, 'Ice', 2000),
(6, 'Hot', 0), (6, 'Ice', 2000),
(10, 'Hot', 0), (10, 'Ice', 2000),
(5, 'Spicy', 2000), (5, 'Non-Spicy', 0),
(8, 'Spicy', 2000), (8, 'Non-Spicy', 0),
(4, 'Chocolate', 2000), (4, 'Matcha', 3000);

INSERT INTO "product_size" ("product_id", "size_name", "additional_price") VALUES 
(1, 'Regular', 0), (1, 'Medium', 3000), (1, 'Large', 5000),
(2, 'Regular', 0), (2, 'Medium', 3000), (2, 'Large', 5000),
(3, 'Regular', 0), (3, 'Medium', 3000), (3, 'Large', 5000),
(6, 'Regular', 0), (6, 'Medium', 3000), (6, 'Large', 5000),
(9, 'Regular', 0), (9, 'Medium', 3000), (9, 'Large', 5000),
(10, 'Regular', 0), (10, 'Medium', 3000), (10, 'Large', 5000),
(7, '250gr', 50000), (7, '500gr', 90000),
(4, 'Regular', 0),
(5, 'Regular', 0),
(8, 'Regular', 0);

INSERT INTO "transaction" ("id_transaction", "user_id", "transaction_number", "delivery_method", "subtotal", "total", "status", "payment_method") VALUES 
(1, 2, 'ORD-2026022509301234', 'Pick Up', 60000, 66000, 'Success', 'Cash'),
(2, 3, 'ORD-2026022509355678', 'Dine In', 35000, 38500, 'Success', 'Cash'),
(3, 4, 'ORD-2026022509409912', 'Take Away', 45000, 49500, 'Pending', 'Cash'),
(4, 5, 'ORD-2026022510014421', 'Take Away', 80000, 88000, 'Success', 'Cash'),
(5, 6, 'ORD-2026022510051192', 'Dine In', 25000, 27500, 'Success', 'Cash'),
(6, 7, 'ORD-2026022510103384', 'Take Away', 120000, 132000, 'Pending', 'Cash'),
(7, 8, 'ORD-2026022510156672', 'Take Away', 45000, 49500, 'Success', 'Cash'),
(8, 9, 'ORD-2026022510208819', 'Dine In', 32000, 35200, 'Canceled', 'Cash'),
(9, 10, 'ORD-2026022510255543', 'Take Away', 55000, 60500, 'Success', 'Cash'),
(10, 2, 'ORD-2026022510302211', 'Take Away', 90000, 99000, 'Success', 'Cash');

INSERT INTO "transaction_product" ("transaction_id", "product_id", "quantity", "size", "variant", "price") VALUES 
(1, 2, 2, 'Medium', 'Ice', 60000),      
(2, 3, 1, 'Large', 'Ice', 35000),       
(3, 5, 1, 'Regular', 'Spicy', 45000),   
(4, 8, 2, 'Regular', 'Non-Spicy', 80000), 
(5, 4, 1, 'Regular', NULL, 25000),      
(6, 7, 2, '500gr', 'Ice', 120000),      
(7, 5, 1, 'Regular', 'Spicy', 50000),   
(8, 10, 1, 'Regular', 'Ice', 32000),    
(9, 3, 1, 'Large', 'Hot', 40000),      
(10, 2, 3, 'Medium', 'Ice', 90000);     

INSERT INTO "discount" ("product_id", "discount_rate", "description", "is_flash_sale") VALUES 
(1, 0.1, 'Morning Coffee Promo 10%', FALSE),
(2, 0.15, 'Latte Love Discount', FALSE),
(5, 0.5, 'Flash Sale Nasi Goreng!', TRUE),
(9, 0.2, 'Caramel Sweet Weekend', FALSE),
(3, 0.05, 'Matcha Monday', FALSE),
(4, 0.12, 'Pastry Bundle', FALSE),
(6, 0.25, 'Chocolate Rush', TRUE),
(7, 0.1, 'Morning Coffee', FALSE),
(8, 0.2, 'Chicken Weekend', FALSE),
(10, 0.15, 'Taro Special', TRUE);

INSERT INTO "review" ("user_id", "product_id", "messages", "rating") VALUES 
(2, 1, 'Espresso-nya mantap, nendang banget!', 5.0),
(3, 2, 'Latte-nya lembut, tapi kurang manis sedikit.', 4.0),
(4, 7, 'Biji kopinya segar, harum pas dibuka.', 5.0),
(5, 5, 'Pedasnya juara! Porsinya juga pas.', 4.5),
(6, 3, 'Matcha-nya agak terlalu manis buat saya.', 3.5);
(7, 8, 'Ayamnya krispi banget!', 5.0),
(8, 9, 'Karamelnya berasa premium.', 4.8),
(9, 10, 'Warna taronya cantik, rasanya enak.', 4.5),
(10, 4, 'Croissant paling lembut di kota ini.', 5.0),
(2, 6, 'Cokelatnya pekat, anak saya suka.', 4.7);

-- DATA TAMBAHAN UNTUK PRODUCTS BESERTA OPSI NYA

INSERT INTO "products" ("name", "desc", "price", "quantity", "is_active") VALUES 
('Caramel Latte', 'Espresso dengan susu dan sirup karamel', 32000, 50, TRUE),
('Hazelnut Coffee', 'Kopi dengan aroma kacang hazelnut', 33000, 45, TRUE),
('Vanilla Macchiato', 'Macchiato manis dengan sentuhan vanilla', 35000, 40, TRUE),
('Mocha Mix', 'Perpaduan cokelat dan kopi espresso', 34000, 55, TRUE),
('Gula Aren Coffee', 'Kopi susu kekinian dengan gula aren', 25000, 100, TRUE),
('Affogato', 'Espresso dengan satu scoop es krim vanilla', 28000, 30, TRUE),
('Irish Coffee', 'Kopi dengan krim lembut di atasnya', 38000, 20, TRUE),
('Pandan Coffee', 'Kopi susu dengan sirup pandan wangi', 30000, 40, TRUE),
('Cold Brew Classic', 'Kopi seduh dingin selama 12 jam', 35000, 25, TRUE),
('Piccolo Latte', 'Latte kecil dengan rasa kopi yang kuat', 27000, 35, TRUE),

('Red Velvet Latte', 'Minuman manis rasa kue red velvet', 32000, 50, TRUE),
('Thai Tea', 'Teh khas Thailand dengan susu kental manis', 22000, 80, TRUE),
('Earl Grey Tea', 'Teh premium dengan aroma bergamot', 25000, 60, TRUE),
('Lemon Tea Ice', 'Teh segar dengan perasan lemon asli', 20000, 100, TRUE),
('Strawberry Smoothies', 'Buah strawberry segar yang diblender', 35000, 40, TRUE),
('Cookies and Cream', 'Susu vanilla dengan remahan biskuit cokelat', 36000, 45, TRUE),
('Peach Tea', 'Teh rasa buah persik yang menyegarkan', 28000, 50, TRUE),
('Lychee Yakult', 'Minuman lychee segar dengan yakult', 30000, 55, TRUE),
('Chocolate Avocado', 'Perpaduan cokelat dan buah alpukat', 38000, 30, TRUE),
('Blueberry Milk', 'Susu segar dengan selai blueberry', 34000, 40, TRUE),

('Mie Goreng Jawa', 'Mie goreng khas jawa dengan bumbu rempah', 35000, 40, TRUE),
('Spaghetti Bolognese', 'Pasta dengan saus daging sapi cincang', 48000, 30, TRUE),
('Nasi Gila', 'Nasi dengan tumisan telur, sosis, dan bakso', 38000, 45, TRUE),
('Beef Burger', 'Roti burger dengan daging sapi tebal', 50000, 25, TRUE),
('Fish and Chips', 'Ikan goreng tepung dengan kentang goreng', 55000, 20, TRUE),
('Chicken Wings', 'Sayap ayam goreng dengan saus madu', 40000, 35, TRUE),
('Sate Ayam', 'Sate ayam isi 10 tusuk dengan bumbu kacang', 45000, 30, TRUE),
('Ayam Geprek', 'Ayam goreng tepung yang dipenyet pedas', 30000, 60, TRUE),
('Club Sandwich', 'Roti lapis isi ayam, telur, dan keju', 42000, 25, TRUE),
('Mac and Cheese', 'Makaroni panggang dengan saus keju melimpah', 45000, 20, TRUE),

('Cinnamon Roll', 'Roti kayu manis yang harum', 28000, 30, TRUE),
('Cheese Cake', 'Kue keju lembut khas New York', 35000, 25, TRUE),
('Chocolate Muffin', 'Muffin cokelat dengan choco chips', 25000, 40, TRUE),
('Almond Croissant', 'Croissant dengan taburan kacang almond', 32000, 20, TRUE),
('Tiramisu Cake', 'Kue rasa kopi dan keju mascarpone', 38000, 15, TRUE),
('Donut Glazed', 'Donat empuk dengan lapisan gula', 15000, 50, TRUE),
('Banana Bread', 'Roti pisang panggang yang padat', 22000, 30, TRUE),
('Red Velvet Cake', 'Irisan kue red velvet dengan cream cheese', 35000, 20, TRUE),
('Eclair', 'Pastry panjang isi krim cokelat', 24000, 35, TRUE),
('Apple Pie', 'Pai isi buah apel kayu manis', 30000, 20, TRUE);

INSERT INTO "product_images" ("product_id", "path") VALUES 
(11, 'https://images.pexels.com/photos/312418/pexels-photo-312418.jpeg'),
(12, 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg'),
(13, 'https://images.pexels.com/photos/302896/pexels-photo-302896.jpeg'),
(14, 'https://images.pexels.com/photos/4348444/pexels-photo-4348444.jpeg'),
(15, 'https://images.pexels.com/photos/230567/pexels-photo-230567.jpeg'),
(16, 'https://images.pexels.com/photos/374885/pexels-photo-374885.jpeg'),
(17, 'https://images.pexels.com/photos/851558/pexels-photo-851558.jpeg'),
(18, 'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg'),
(19, 'https://images.pexels.com/photos/2615323/pexels-photo-2615323.jpeg'),
(20, 'https://images.pexels.com/photos/1235706/pexels-photo-1235706.jpeg'),

(21, 'https://images.pexels.com/photos/5946637/pexels-photo-5946637.jpeg'),
(22, 'https://images.pexels.com/photos/159291/tea-cup-drink-herbal-tea-159291.jpeg'),
(23, 'https://images.pexels.com/photos/1417945/pexels-photo-1417945.jpeg'),
(24, 'https://images.pexels.com/photos/1187317/pexels-photo-1187317.jpeg'),
(25, 'https://images.pexels.com/photos/103566/pexels-photo-103566.jpeg'),
(26, 'https://images.pexels.com/photos/3727250/pexels-photo-3727250.jpeg'),
(27, 'https://images.pexels.com/photos/1493080/pexels-photo-1493080.jpeg'),
(28, 'https://images.pexels.com/photos/103566/pexels-photo-103566.jpeg'),
(29, 'https://images.pexels.com/photos/3625372/pexels-photo-3625372.jpeg'),
(30, 'https://images.pexels.com/photos/5947020/pexels-photo-5947020.jpeg'),

(31, 'https://images.pexels.com/photos/2092906/pexels-photo-2092906.jpeg'),
(32, 'https://images.pexels.com/photos/1279330/pexels-photo-1279330.jpeg'),
(33, 'https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg'),
(34, 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg'),
(35, 'https://images.pexels.com/photos/46273/salmon-dish-food-meal-46273.jpeg'),
(36, 'https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg'),
(37, 'https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg'),
(38, 'https://images.pexels.com/photos/106343/pexels-photo-106343.jpeg'),
(39, 'https://images.pexels.com/photos/1600711/pexels-photo-1600711.jpeg'),
(40, 'https://images.pexels.com/photos/2714722/pexels-photo-2714722.jpeg'),

(41, 'https://images.pexels.com/photos/3892461/pexels-photo-3892461.jpeg'),
(42, 'https://images.pexels.com/photos/1126359/pexels-photo-1126359.jpeg'),
(43, 'https://images.pexels.com/photos/913136/pexels-photo-913136.jpeg'),
(44, 'https://images.pexels.com/photos/2133989/pexels-photo-2133989.jpeg'),
(45, 'https://images.pexels.com/photos/6347/coffee-cup-working-happy.jpg'),
(46, 'https://images.pexels.com/photos/1470511/pexels-photo-1470511.jpeg'),
(47, 'https://images.pexels.com/photos/2691459/pexels-photo-2691459.jpeg'),
(48, 'https://images.pexels.com/photos/1055272/pexels-photo-1055272.jpeg'),
(49, 'https://images.pexels.com/photos/132694/pexels-photo-132694.jpeg'),
(50, 'https://images.pexels.com/photos/616833/pexels-photo-616833.jpeg');

INSERT INTO "products_category" ("product_id", "category_id") VALUES
(11,1), (12,1), (13,1), (14,1), (15,1), (16,1), (17,1), (18,1), (19,1), (20,1),
(21,2), (22,2), (23,2), (24,2), (25,2), (26,2), (27,2), (28,2), (29,2), (30,2),
(31,3), (32,3), (33,3), (34,3), (35,3), (36,3), (37,3), (38,3), (39,3), (40,3), 
(41,4), (42,4), (43,4), (44,4), (45,4), (46,4), (47,4), (48,4), (49,4), (50,4);

INSERT INTO "product_variant" ("product_id", "variant_name", "additional_price") VALUES 
(11, 'Hot', 0), (11, 'Ice', 2000), (12, 'Hot', 0), (12, 'Ice', 2000),
(13, 'Hot', 0), (13, 'Ice', 2000), (14, 'Hot', 0), (14, 'Ice', 2000),
(15, 'Hot', 0), (15, 'Ice', 2000), (16, 'Hot', 0), (16, 'Ice', 2000),
(17, 'Hot', 0), (17, 'Ice', 2000), (18, 'Hot', 0), (18, 'Ice', 2000),
(19, 'Hot', 0), (19, 'Ice', 2000), (20, 'Hot', 0), (20, 'Ice', 2000),

(21, 'Hot', 0), (21, 'Ice', 2000), (22, 'Hot', 0), (22, 'Ice', 2000),
(23, 'Hot', 0), (23, 'Ice', 2000), (24, 'Hot', 0), (24, 'Ice', 2000),
(25, 'Hot', 0), (25, 'Ice', 2000), (26, 'Hot', 0), (26, 'Ice', 2000),
(27, 'Hot', 0), (27, 'Ice', 2000), (28, 'Hot', 0), (28, 'Ice', 2000),
(29, 'Hot', 0), (29, 'Ice', 2000), (30, 'Hot', 0), (30, 'Ice', 2000),

(31, 'Non-Spicy', 0), (31, 'Spicy', 2000), (32, 'Non-Spicy', 0), (32, 'Spicy', 2000),
(33, 'Non-Spicy', 0), (33, 'Spicy', 2000), (34, 'Non-Spicy', 0), (34, 'Spicy', 2000),
(35, 'Non-Spicy', 0), (35, 'Spicy', 2000), (36, 'Non-Spicy', 0), (36, 'Spicy', 2000),
(37, 'Non-Spicy', 0), (37, 'Spicy', 2000), (38, 'Non-Spicy', 0), (38, 'Spicy', 2000),
(39, 'Non-Spicy', 0), (39, 'Spicy', 2000), (40, 'Non-Spicy', 0), (40, 'Spicy', 2000),

(41, 'Chocolate', 2000), (41, 'Cheese', 3000), (42, 'Original', 0), (42, 'Strawberry', 3000),
(43, 'Chocolate', 2000), (43, 'Vanilla', 2000), (44, 'Almond', 2000), (44, 'Honey', 2000),
(45, 'Coffee Latte', 0), (45, 'Caramel', 2000), (46, 'Glazed', 0), (46, 'Chocolate Overload', 3000),
(47, 'Original', 0), (47, 'Cheese Nut', 3000), (48, 'Cream Cheese', 0), (48, 'Berry Mix', 3000),
(49, 'Chocolate', 2000), (49, 'Matcha', 3000), (50, 'Apple Cinnamon', 0), (50, 'Custard', 2000);

INSERT INTO "product_size" ("product_id", "size_name", "additional_price") VALUES 
(11, 'Regular', 0), (11, 'Medium', 3000), (11, 'Large', 5000),
(12, 'Regular', 0), (12, 'Medium', 3000), (12, 'Large', 5000),
(13, 'Regular', 0), (13, 'Medium', 3000), (13, 'Large', 5000),
(14, 'Regular', 0), (14, 'Medium', 3000), (14, 'Large', 5000),
(15, 'Regular', 0), (15, 'Medium', 3000), (15, 'Large', 5000),
(16, 'Regular', 0), (16, 'Medium', 3000), (16, 'Large', 5000),
(17, 'Regular', 0), (17, 'Medium', 3000), (17, 'Large', 5000),
(18, 'Regular', 0), (18, 'Medium', 3000), (18, 'Large', 5000),
(19, 'Regular', 0), (19, 'Medium', 3000), (19, 'Large', 5000),
(20, 'Regular', 0), (20, 'Medium', 3000), (20, 'Large', 5000),
(21, 'Regular', 0), (21, 'Medium', 3000), (21, 'Large', 5000),
(22, 'Regular', 0), (22, 'Medium', 3000), (22, 'Large', 5000),
(23, 'Regular', 0), (23, 'Medium', 3000), (23, 'Large', 5000),
(24, 'Regular', 0), (24, 'Medium', 3000), (24, 'Large', 5000),
(25, 'Regular', 0), (25, 'Medium', 3000), (25, 'Large', 5000),
(26, 'Regular', 0), (26, 'Medium', 3000), (26, 'Large', 5000),
(27, 'Regular', 0), (27, 'Medium', 3000), (27, 'Large', 5000),
(28, 'Regular', 0), (28, 'Medium', 3000), (28, 'Large', 5000),
(29, 'Regular', 0), (29, 'Medium', 3000), (29, 'Large', 5000),
(30, 'Regular', 0), (30, 'Medium', 3000), (30, 'Large', 5000),

(31, 'Regular', 0), (32, 'Regular', 0), (33, 'Regular', 0), (34, 'Regular', 0), (35, 'Regular', 0),
(36, 'Regular', 0), (37, 'Regular', 0), (38, 'Regular', 0), (39, 'Regular', 0), (40, 'Regular', 0),

(41, 'Regular', 0), (42, 'Regular', 0), (43, 'Regular', 0), (44, 'Regular', 0), (45, 'Regular', 0),
(46, 'Regular', 0), (47, 'Regular', 0), (48, 'Regular', 0), (49, 'Regular', 0), (50, 'Regular', 0);
