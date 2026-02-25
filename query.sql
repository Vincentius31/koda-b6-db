-- Mendapatkan satu product yang dimana sudah di agregasikan dengan variant dan size yang dipilih

SELECT 
    products.id_product,
    products.name AS "Product Name",
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