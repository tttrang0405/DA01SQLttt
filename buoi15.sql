--ex1
WITH RankedOrders AS (
    SELECT
        delivery_id,
        customer_id,
        order_date,
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank
    FROM Delivery
)
SELECT
    ROUND(SUM(CASE WHEN order_rank = 1 AND order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) /
          COUNT(DISTINCT customer_id) * 100, 2) AS immediate_percentage
FROM RankedOrders;

--ex8
WITH cte AS (
    SELECT
        product_id,
        new_price,
        change_date,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rn
    FROM Products
    WHERE change_date <='2019-08-16'
)

SELECT
    product_id,
    COALESCE(new_price, 10) AS price
FROM cte
WHERE rn = 1
UNION
SELECT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM cte)

