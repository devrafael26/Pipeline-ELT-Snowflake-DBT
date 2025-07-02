-- models/total_sales_by_product.sql

{{ config(materialized='view') }}
WITH sales_data AS (
    SELECT
        "PRODUCT_CATEGORY",
        SUM("TOTAL_AMOUNT") AS total_sales
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "PRODUCT_CATEGORY"
)

SELECT * FROM sales_data
