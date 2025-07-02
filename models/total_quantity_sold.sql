-- models/total_quantity_sold.sql

{{ config(materialized='view') }}
WITH product_quantity AS (
    SELECT
        "PRODUCT_CATEGORY",
        SUM("QUANTITY") AS total_quantity
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "PRODUCT_CATEGORY"
)

SELECT * FROM product_quantity
