-- models/top_5_products.sql

{{ config(materialized='view') }}
WITH product_sales AS (
    SELECT
        "PRODUCT_CATEGORY",
        SUM("TOTAL_AMOUNT") AS total_sales
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "PRODUCT_CATEGORY"
    ORDER BY total_sales DESC
)

SELECT * FROM product_sales
LIMIT 5