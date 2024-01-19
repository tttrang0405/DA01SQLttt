--EX1
WITH SpendByYear AS (
    SELECT
        product_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS total_spend
    FROM
        user_transactions
    GROUP BY
        product_id,
        EXTRACT(YEAR FROM transaction_date)
)

SELECT
    year,
    product_id,
    total_spend AS curr_year_spend,
    LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend,
    ROUND(((total_spend - LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year)) / LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year)) * 100, 2) AS yoy_rate
FROM
    SpendByYear
ORDER BY
    product_id, year;
--EX2: 
