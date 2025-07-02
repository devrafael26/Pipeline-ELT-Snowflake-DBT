-- models/clean_sales_data.sql

{{ config(materialized='view') }}
WITH cleaned_data AS (
    SELECT 
        "TRANSACTION_ID", 
        "DATE",
        "CUSTOMER_ID", 
        "GENDER",
        "AGE",
        "PRODUCT_CATEGORY", 
        "QUANTITY",
        "PRICE_PER_UNIT", 
        "TOTAL_AMOUNT"
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    WHERE "QUANTITY" > 0
    AND "TOTAL_AMOUNT" > 0
)

SELECT * FROM cleaned_data
