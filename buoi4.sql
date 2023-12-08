--ex1
SELECT DISTINCT CITY FROM STATION 
WHERE ID%2=0
;
--ex2
SELECT 
COUNT (CITY) - COUNT(DISTINCT CITY)
FROM STATION;
--ex3
....
--ex4
-- 1 mặt hàng/1 đơn -> 500 đơn  
-- 2 mặt hàng/1 đơn -> 1000 đơn 
-- 3 mặt hàng/1 đơn -> 800 đơn 
-- 4 mặt hàng/1 đơn -> 1000 đơn 
-- => Require tìm số loại hàng trung bình/1 đơn = Tổng loại hàng/ tổng đơn
-- Tổng loại hàng = 1*500+...4*1000 
-- Tổng đơn hàng = 500+1000+800+10001000
SELECT
ROUND(CAST(SUM(item_count * order_occurrences) / SUM(order_occurrences) 
AS DECIMAL),1) as mean 
from items_per_order
;
--ex5
SELECT DISTINCT candidate_id 
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(SKILL) = 3
;
--ex6
SELECT user_id,
DATE(MAX(post_date)) - DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date >= '01/01/2021' AND post_date <= '01/01/2022'
GROUP BY user_id
HAVING COUNT(post_id) >=2
;
--ex7
SELECT card_name,
MAX(issued_amount)-MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
;
--ex8
SELECT manufacturer,
COUNT(drug) AS drug_count,
ABS(SUM(cogs-total_sales)) AS total_loss
FROM pharmacy_sales
WHERE total_sales<cogs
GROUP BY manufacturer
ORDER BY total_loss DESC
;
--ex9
SELECT id, movie, description, rating
FROM cinema
WHERE ID%2 = 1
AND description <> 'boring'
ORDER BY rating DESC
;
--ex10
SELECT teacher_id, 
COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id
;
--ex11
SELECT user_id, 
COUNT(follower_id) AS followers_count 
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC 
;
--ex12
SELECT class
FROM Courses
HAVING COUNT(class) >5
;
