--ex1
--ex2
SELECT 
user_id, 
CONCAT(UPPER(LEFT(name,1)),LOWER(RIGHT(name,length(name)-1))) AS name
FROM Users 
ORDER BY User_id
;
--ex3
SELECT 
manufacturer, 
'$'||ROUND(SUM(total_sales)/1000000,0)||' ' ||'million'
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer
;
--ex4
SELECT 
EXTRACT(month FROM submit_date) AS mth,
product_id as product,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id
;
--ex5
SELECT 
sender_id,
COUNT(content) as message_count
FROM messages
WHERE sent_date BETWEEN '08/01/2022' AND '09/01/2022'
GROUP BY sender_id, message_count
HAVING COUNT(content) >1
ORDER BY COUNT(content) DESC
;
--ex6
SELECT 
tweet_id
FROM Tweets
WHERE length(content)>15
;
--ex3
--ex3
--ex3
--ex3
--ex3
