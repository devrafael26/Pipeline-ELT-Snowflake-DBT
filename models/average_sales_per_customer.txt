-- models/average_sales_per_customer.sql

{{ config(materialized='view') }}
WITH customer_sales AS (
    SELECT
        "CUSTOMER_ID",
        SUM("TOTAL_AMOUNT") AS total_gasto,
        COUNT(DISTINCT "TRANSACTION_ID") AS total_transacoes
    FROM {{ source('sales_data', 'RETAIL_SALES') }}
    GROUP BY "CUSTOMER_ID"
)

SELECT
    "CUSTOMER_ID",
    total_gasto,
    total_transacoes,
    total_gasto / NULLIF(total_transacoes, 0) AS media_venda_por_transacao
FROM customer_sales