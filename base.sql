CREATE TABLE ROLES (
    "id_roles" INT PRIMARY KEY,
    "name_roles" VARCHAR(50) NOT NULL
);

CREATE TABLE USERS (
    "id_user" INT PRIMARY KEY,
    "roles_id" INT,
    "fullname" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) UNIQUE NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "address" TEXT,
    "phone" VARCHAR(20),
    "profile_picture" VARCHAR(255),

    FOREIGN KEY ("roles_id") REFERENCES "ROLES"("id_roles") ON DELETE SET NULL
);

CREATE TABLE CATEGORY (
    "id_category" INT PRIMARY KEY,
    "name_category" VARCHAR(100) NOT NULL
);

CREATE TABLE PRODUCTS (
    "id_product" INT PRIMARY KEY,
    "name" VARCHAR(150) NOT NULL,
    "desc" TEXT,
    "price" INT NOT NULL,
    "quantity" INT DEFAULT 0,
    "isActive" BOOLEAN DEFAULT TRUE
);

CREATE TABLE PRODUCTS_CATEGORY (
    "product_id" INT,
    "category_id" INT,
    
    PRIMARY KEY ("product_id", "category_id"),

    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE,
    FOREIGN KEY ("category_id") REFERENCES "CATEGORY"("id_category") ON DELETE CASCADE
);

CREATE TABLE PRODUCT_IMAGES (
    "id_image" INT PRIMARY KEY,
    "product_id" INT,
    "path" VARCHAR(255) NOT NULL,

    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE
);

CREATE TABLE PRODUCT_VARIANT (
    "id_variant" INT PRIMARY KEY,
    "product_id" INT,
    "variant_name" VARCHAR(100),
    "additional_price" INT DEFAULT 0,

    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE
);

CREATE TABLE PRODUCT_SIZE (
    "id_size" INT PRIMARY KEY,
    "product_id" INT,
    "size_name" VARCHAR(50),
    "additional_price" INT DEFAULT 0,

    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE
);

CREATE TABLE DISCOUNT (
    "id_discount" INT PRIMARY KEY,
    "product_id" INT,
    "discount_rate" FLOAT NOT NULL,
    "description" VARCHAR(255),
    "isFlashSale" BOOLEAN DEFAULT FALSE,

    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE
);

CREATE TABLE CART (
    "id_cart" INT PRIMARY KEY,
    "user_id" INT,
    "product_id" INT,
    "variant_id" INT,
    "size_id" INT,
    "quantity" INT NOT NULL DEFAULT 1,

    FOREIGN KEY ("user_id") REFERENCES "USERS"("id_user") ON DELETE CASCADE,
    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE,
    FOREIGN KEY ("variant_id") REFERENCES "PRODUCT_VARIANT"("id_variant"),
    FOREIGN KEY ("size_id") REFERENCES "PRODUCT_SIZE"("id_size")
);

CREATE TABLE TRANSACTION (
    "id_transaction" INT PRIMARY KEY,
    "user_id" INT,
    "delivery_method" VARCHAR(50),
    "subtotal" INT NOT NULL,
    "total" INT NOT NULL,
    "status" VARCHAR(50) DEFAULT 'Pending',
    "payment_method" VARCHAR(50),
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY ("user_id") REFERENCES "USERS"("id_user") ON DELETE SET NULL
);

CREATE TABLE TRANSACTION_PRODUCT (
    "id_trans_prod" INT PRIMARY KEY,
    "transaction_id" INT,
    "product_id" INT,
    "quantity" INT NOT NULL,
    "size" VARCHAR(50),
    "variant" VARCHAR(100),   
    "price" INT NOT NULL,

    FOREIGN KEY ("transaction_id") REFERENCES "TRANSACTION"("id_transaction") ON DELETE CASCADE,
    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE SET NULL
);

CREATE TABLE REVIEW (
    "id_review" INT PRIMARY KEY,
    "user_id" INT,
    "product_id" INT,
    "messages" TEXT,
    "rating" INT CHECK ("rating" >= 1 AND "rating" <= 5),

    FOREIGN KEY ("user_id") REFERENCES "USERS"("id_user") ON DELETE CASCADE,
    FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("id_product") ON DELETE CASCADE
);

