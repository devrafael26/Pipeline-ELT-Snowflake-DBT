-- models/sales_by_product_and_age_group.sql

{{ config(materialized='view') }}
WITH age_product_sales AS (
    SELECT
        CASE
            WHEN "AGE" BETWEEN 18 AND 24 THEN '18-24'
            WHEN "AGE" BETWEEN 25 AND 34 THEN '25-34'
            WHEN "AGE" BETWEEN 35 AND 44 THEN '35-44'
            WHEN "AGE" BETWEEN 45 AND 54 THEN '45-54'
            WHEN "AGE" BETWEEN 55 AND 64 THEN '55-64'
            WHEN "AGE" >= 65 THEN '65+'
            ELSE 'Unknown' 
        END AS age_group,
        "PRODUCT_CATEGORY",
        SUM("TOTAL_AMOUNT") AS total_sales
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY age_group, "PRODUCT_CATEGORY"
)

SELECT * FROM age_product_sales
