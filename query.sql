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
    users.id_user AS "Customer ID",
    products.name AS "Product Name",
    products.price AS "Base Price",
    product_variant.variant_name AS "Variant" ,
    product_size.size_name "Size",
    product_variant.additional_price AS "Variant Price",
    product_size.additional_price AS "Size Price",
    (
        SELECT (p2.price + pv2.additional_price + ps2.additional_price)
        FROM products AS p2
        JOIN product_variant AS pv2 ON p2.id_product = pv2.product_id
        JOIN product_size AS ps2 ON p2.id_product = ps2.product_id
        WHERE p2.id_product = products.id_product 
          AND pv2.id_variant = product_variant.id_variant 
          AND ps2.id_size = product_size.id_size
    ) AS "Unit Price",
    10 AS "Quantity",
    (
        SELECT (p2.price + pv2.additional_price + ps2.additional_price)
        FROM products AS p2
        JOIN product_variant AS pv2 ON p2.id_product = pv2.product_id
        JOIN product_size AS ps2 ON p2.id_product = ps2.product_id
        WHERE p2.id_product = products.id_product 
          AND pv2.id_variant = product_variant.id_variant 
          AND ps2.id_size = product_size.id_size
    ) * 10 AS "Subtotal"
FROM products
JOIN product_variant ON products.id_product = product_variant.product_id
JOIN product_size ON products.id_product = product_size.product_id
CROSS JOIN users 
WHERE 
    users.id_user = 2                 
    AND products.id_product = 2       
    AND product_variant.id_variant = 8
    AND product_size.id_size = 10;