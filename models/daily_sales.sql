-- models/daily_sales.sql

{{ config(materialized='view') }}
WITH daily_sales AS (
    SELECT
        "DATE",
        SUM("TOTAL_AMOUNT") AS total_sales
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "DATE"
)

SELECT * FROM daily_sales
