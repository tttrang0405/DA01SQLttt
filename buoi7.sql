--ex1
SELECT name
FROM STUDENTS
WHERE marks>75
ORDER BY RIGHT(name,3), ID
;
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
--ex7
SELECT
activity_date as day, 
count(distinct(user_id )) as active_users
FROM activity
WHERE activity_date BETWEEN ' 2019-06-27' AND ' 2019-07-27'
group by day 
;
--ex8
SELECT 
count(employee_id)as total_employees, 
joining_date as total_date
FROM employees
WHERE where extract(month from joining_date) between 1 and 7
AND extract(year from joining_date) ='2022'
--ex9
select 
first_name,
POSITION('a' in first_name)
FROM worker
WHERE first_name ='Amitah'
;
--ex10
SELECT 
country,
winery|| ' ' ||SUBSTRING(title, length(winery)+2,4) as title_wine
FROM winemag_p2
WHERE country = 'Macedonia'
;
