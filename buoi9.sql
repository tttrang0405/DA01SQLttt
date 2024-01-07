--EX1:
SUM(
CASE
WHEN device_type = 'laptop' THEN 1 ELSE 0 END) 
  AS laptop_views,
SUM(CASE
WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) 
  AS mobile_views
FROM viewership;
--EX2:
SELECT x, y, z,
CASE
WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
ELSE 'No'
END AS 'triangle'
FROM Triangle;
--EX3:
SELECT COUNT(case_id) AS uncategorised_calls
FROM callers
WHERE call_category IS NULL
  OR call_category = 'n/a';
--EX4: 
SELECT name
FROM customer
WHERE referee_id != 2 or referee_id is NULL;
--EX5:
SELECT survived,
SUM(CASE 
  WHEN pclass = 1 THEN 1 ELSE 0 END) 
  AS first_class,
SUM(CASE 
  WHEN pclass = 2 THEN 1 ELSE 0 END) 
  AS second_class,
SUM(CASE 
  WHEN pclass = 3 THEN 1 ELSE 0 END) 
  AS third_class
FROM titanic
GROUP BY survived
