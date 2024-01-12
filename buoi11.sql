--ex1
SELECT Country.Continent, ROUND(AVG(City.Population))
FROM Country
JOIN City ON Country.Code = City.CountryCode
GROUP BY Country.Continent;
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
SELECT customer_id 
FROM customer_contracts AS cc
JOIN products as p ON cc.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(p.product_category) = (SELECT
COUNT(product_category) FROM products);
--ex5
SELECT 
e.employee_id,
e.name,
COUNT(r.employee_id) AS reports_count,
ROUND(AVG(r.age)) AS average_age
FROM Employees AS e
JOIN Employees AS r ON e.employee_id = r.reports_to
GROUP BY e.employee_id, e.name
HAVING COUNT(r.employee_id) > 0
ORDER BY e.employee_id;
--ex6
SELECT
p.product_name,
SUM(o.unit) AS unit
FROM Products as p
LEFT JOIN
Orders as o ON p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29' OR o.order_date IS NULL
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit) >= 100;
--ex7
SELECT p.page_id 
FROM pages AS p
LEFT JOIN page_likes AS pl ON p.page_id = pl.page_id
WHERE pl.page_id IS NULL
ORDER BY p.page_id ASC;
