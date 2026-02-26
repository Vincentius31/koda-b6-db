-- Mendapatkan satu product yang dimana sudah di agregasikan dengan variant dan size yang dipilih

SELECT 
    products.id_product,
    products.name AS "Product Name",
    products.price AS "Base Price",
    product_variant.variant_name AS "Variant",
    product_size.size_name AS "Size",
    product_variant.additional_price AS "Variant Extra Price",
    product_size.additional_price AS "Size Extra Size",
    (products.price + product_variant.additional_price + product_size.additional_price) AS "Total Price"
FROM 
    products 
JOIN 
    product_variant  ON products.id_product = product_variant.product_id
JOIN 
    product_size ON products.id_product = product_size.product_id
WHERE 
    products.id_product = 4 AND
    product_variant.id_variant = 23 AND
    product_size.id_size = 25;   


-- Membuatkan setiap item yang dipilih beserta opsi nya seperti variant, size serta tampilkan jumlah qty nya berserta subtotal dari item yang kita pilih (diluar harga pajak)

SELECT 
    tabel_belanja."Product Name",
    tabel_belanja."Quantity",
    tabel_belanja."Subtotal"
FROM (
    SELECT 
        products.name AS "Product Name",
        3 AS "Quantity",
        (products.price + product_variant.additional_price + product_size.additional_price) * 3 AS "Subtotal"
    FROM 
        products 
    JOIN 
        product_variant ON products.id_product = product_variant.product_id
    JOIN 
        product_size ON products.id_product = product_size.product_id
    WHERE 
        products.id_product = 4 AND
        product_variant.id_variant = 23 AND
        product_size.id_size = 25

    UNION ALL

    SELECT 
        products.name AS "Product Name",
        5 AS "Quantity", 
        (products.price + product_variant.additional_price + product_size.additional_price) * 5 AS "Subtotal"
    FROM 
        products 
    JOIN 
        product_variant ON products.id_product = product_variant.product_id
    JOIN 
        product_size ON products.id_product = product_size.product_id
    WHERE 
        products.id_product = 3 AND 
        product_variant.id_variant = 14 AND
        product_size.id_size = 12
) AS tabel_belanja;

-- Pada landing page, query apa yang dibutuhkan?

-- Section Product
SELECT product_images.path, products.name, products.desc, products.price
FROM products JOIN product_images ON product_images.product_id = products.id_product
LIMIT 4;

-- Section Testimonial
SELECT users.fullname, review.messages, review.rating
FROM users JOIN review ON review.user_id = users.id_user;

--Pada Browse Product, query apa yang dibutuhkan?

-- Section Today Promos
SELECT discount.description
FROM discount
WHERE discount.is_flash_sale = TRUE;

-- Fitur Filter Search Products
SELECT products.name AS product_name, products.desc AS description, product_images.path AS product_image, AVG(review.rating) AS average_rating, products.price AS normal_price, (products.price - (products.price * discount.discount_rate)) AS discounted_price
FROM products JOIN product_images  ON products.id_product = product_images.product_id
JOIN review ON products.id_product = review.product_id
JOIN discount ON products.id_product = discount.product_id
WHERE products.name ILIKE '%Latte' -- Contoh jika user mencari products dengan kata kunci latte.
GROUP BY products.id_product, products.name, products.desc, products.price, product_images.path, discount.discount_rate;

-- Fitur Filter Berdasarkan Category

SELECT products.name AS product_name, products.desc AS description, product_images.path AS product_image, AVG(review.rating) AS average_rating, products.price AS normal_price, (products.price - (products.price * discount.discount_rate)) AS discounted_price
FROM products
JOIN products_category ON products.id_product = products_category.product_id
JOIN category ON products_category.category_id = category.id_category
LEFT JOIN product_images ON products.id_product = product_images.product_id
LEFT JOIN review ON products.id_product = review.product_id
LEFT JOIN discount ON products.id_product = discount.product_id
WHERE category.name_category = 'Coffee'
GROUP BY products.id_product, products.name, products.desc, product_images.path, products.price, discount.discount_rate;

-- Fitur Filter berdasarkan discount

SELECT products.name AS product_name, products.desc AS description, product_images.path AS product_image, AVG(review.rating) AS average_rating, products.price AS normal_price, 
(products.price - (products.price * discount.discount_rate)) AS discounted_price
FROM products
JOIN discount ON products.id_product = discount.product_id
LEFT JOIN product_images ON products.id_product = product_images.product_id
LEFT JOIN review ON products.id_product = review.product_id
WHERE discount.description = 'Morning Coffee Promo 10%'
GROUP BY products.id_product, products.name, products.desc, product_images.path, products.price, discount.discount_rate;

-- Fitur Filter berdasarkan price range (10000 s/d 20000)

SELECT products.name AS product_name, products.desc AS description, product_images.path AS product_image, AVG(review.rating) AS average_rating, products.price AS normal_price, 
(products.price - (products.price * discount.discount_rate)) AS discounted_price
FROM products
LEFT JOIN product_images ON products.id_product = product_images.product_id
LEFT JOIN review ON products.id_product = review.product_id
LEFT JOIN discount ON products.id_product = discount.product_id
WHERE products.price BETWEEN 10000 AND 20000
GROUP BY 
    products.id_product, 
    products.name, 
    products.desc, 
    product_images.path, 
    products.price, 
    discount.discount_rate;

