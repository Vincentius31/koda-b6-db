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