-- Mendapatkan satu product yang dimana sudah di agregasikan dengan variant dan size yang dipilih

SELECT products.id_product, products.name, products.price AS "base_price", category.name_category,
    ARRAY_AGG(DISTINCT product_variant.variant_name) FILTER (WHERE product_variant.variant_name IS NOT NULL) AS "available_variants",
    ARRAY_AGG(DISTINCT product_size.size_name) FILTER (WHERE product_size.size_name IS NOT NULL) AS "available_sizes"
FROM products LEFT JOIN products_category ON products.id_product = products_category.product_id 
LEFT JOIN category ON products_category.category_id = category.id_category
LEFT JOIN product_variant ON products.id_product = product_variant.product_id
LEFT JOIN product_size ON products.id_product = product_size.product_id
GROUP BY products.id_product, category.name_category;