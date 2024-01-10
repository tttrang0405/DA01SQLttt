--ex1


-- ex2
SELECT 
ROUND(SUM(CASE WHEN t.signup_action = 'Confirmed' THEN 1 ELSE 0 END)*1.0 / COUNT(t.signup_action),2)
FROM emails AS e
LEFT JOIN texts AS t
ON e.email_id  = t.email_id
WHERE 
e.email_id IS NOT NULL
--ex3
SELECT *
FROM activities
INNER JOIN age_breakdown AS age 
ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;
--ex4
--ex5
--ex6
SELECT p.product_name, o.unit 
FROM   (SELECT product_id, 
               Sum(unit) AS unit 
        FROM   orders 
        WHERE  order_date BETWEEN '2020-02-01' AND '2020-02-29' 
        GROUP  BY product_id 
        HAVING unit >= 100) o 
       INNER JOIN products p 
               ON o.product_id = p.product_id 
