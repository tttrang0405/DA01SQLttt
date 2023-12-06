--ex1
SELECT name FROM city
WHERE population > 120000
AND COUNTRYCODE = 'USA'
;
--ex2
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN'
;
--ex3
SELECT CITY, STATE FROM STATION;
--ex4
SELECT DISTINCT CITY FROM STATION 
WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR LIKE 'I%' LIKE 'o%' OR LIKE 'U%' 
;
--ex5
SELECT DISTINCT CITY FROM STATION 
WHERE CITY LIKE '%A' OR CITY LIKE '%E' OR LIKE '%I' LIKE '%O' OR LIKE '%U' 
;
--ex6
select distinct city from station 
where city Not like 'A%' and city Not like 'E%' and city Not like 'I%' and  city Not like 'o%' and city not like 'U%'
;
--ex7
SELECT name FROM Employee 
ORDER BY name
;
--ex8
SELECT name FROM Employee
WHERE salary > 2000 
AND MONTHS <10
;
--ex9
SELECT product_id FROM products
WHERE low_fats = 'Y'
AND recyclable = 'Y'
;
--ex10
SELECT name FROM Customer
WHERE referee_id <>2 
;
--ex11
SELECT NAME, POPULATION, AREA FROM WORLD
WHERE AREA >=300000 AND POPULATION >=25000000
--ex12
SELECT DISTINCT AUTHOR_ID AS ID
FROM VIEWS 
WHERE AUTHOR_ID = VIEWER_ID
ORDER BY AUTHOR_ID ASC
;
--ex13
SELECT part FROM parts_assembly;
WHERE finish_date is null
;
--ex14
select * from lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary >=70000
;
--ex15
select advertising_channel from uber_advertising
WHERE money_spent > 100000
AND year = 2019
;

