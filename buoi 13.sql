--EX1
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_listings
WHERE (title, description, company_id) IN 
(
SELECT title, description, company_id
FROM job_listings
GROUP BY title, description, company_id
HAVING COUNT(*) > 1
);
--EX2
--EX3
SELECT COUNT(DISTINCT policy_holder_id) AS member_count
FROM callers
WHERE policy_holder_id IN 
(
SELECT policy_holder_id
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(DISTINCT case_id) >= 3
);
--EX4
SELECT page_id
FROM pages
WHERE page_id NOT IN 
(
SELECT DISTINCT page_id
FROM page_likes
)
ORDER BY page_id ASC;
--EX5
--EX6
--EX7
WITH FirstYearSales AS (
SELECT s.product_id, MIN(s.year) AS first_year
FROM
Sales as s
GROUP BY s.product_id
)
SELECT fs.product_id, fs.first_year, s.quantity, s.price
FROM FirstYearSales as fs
JOIN Sales as s 
ON fs.product_id = s.product_id 
AND fs.first_year = s.year;
--EX8
--EX9
SELECT employee_id
FROM employees
WHERE manager_id  NOT IN
(SELECT employee_id FROM employees) 
AND salary < 30000
ORDER BY employee_id
--EX11
SELECT
    (SELECT name
     FROM Users u
     WHERE u.user_id = r.user_id
     GROUP BY user_id
     ORDER BY COUNT(movie_id) DESC, name ASC
     LIMIT 1) AS results
FROM MovieRating r
GROUP BY user_id
UNION
SELECT
    (SELECT title
     FROM Movies m
     WHERE m.movie_id = r.movie_id
     GROUP BY movie_id
     ORDER BY AVG(rating) DESC, title ASC
     LIMIT 1) AS results
FROM MovieRating r
WHERE EXTRACT(YEAR_MONTH FROM created_at) = '202002'
GROUP BY movie_id
LIMIT 2;
--EX12
SELECT id, COUNT(DISTINCT friend_id) AS number_fr
FROM (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS friends
GROUP BY id
ORDER BY number_fr DESC, id
LIMIT 1;
-- mấy bài còn lại khó quá anh :(( em chưa nghĩ ra được 



