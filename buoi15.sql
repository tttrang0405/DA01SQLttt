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
--ex2 +3 - khó quá huhu
--ex4
WITH cte AS
(SELECT visited_on, SUM(amount) AS total_amount
FROM Customer
GROUP BY  visited_on),

cte2 AS
(SELECT
  a.visited_on,
  SUM(b.total_amount) AS amount,
  ROUND(SUM(b.total_amount)/7,2) AS average_amount
FROM cte a, cte b
WHERE DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6
GROUP BY a.visited_on
ORDER BY a.visited_on)

SELECT *
FROM cte2
WHERE visited_on >= (SELECT visited_on FROM cte ORDER by visited_on LIMIT 1 ) + 6
ORDER BY visited_on 
--ex5
    SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)
--ex6
SELECT Department, Employee, Salary
FROM (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY d.name ORDER BY Salary DESC) AS rnk
    FROM Employee e
    JOIN Department d
    ON e.departmentId = d.id
) AS rnk_tbl
WHERE rnk <= 3;
--ex7 - bài này cũng khó nữa ạ :((
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

