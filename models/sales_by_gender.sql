-- models/sales_by_gender.sql

{{ config(materialized='view') }}
WITH gender_sales AS (
    SELECT
        "GENDER",
        SUM("TOTAL_AMOUNT") AS total_sales
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "GENDER"
)

SELECT * FROM gender_sales