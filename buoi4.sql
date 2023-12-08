--ex1
--ex2
SELECT 
COUNT (CITY) - COUNT(DISTINCT CITY)
FROM STATION;
--ex3
--ex4
--ex5
SELECT DISTINCT candidate_id 
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(SKILL) = 3
;
--ex6
--ex7
--ex7
--ex8
--ex9
--ex10
--ex11
--ex12
