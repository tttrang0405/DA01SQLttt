--ex1
SELECT name FROM city
WHERE population > 120000
AND COUNTRYCODE = 'USA';
--ex9
SELECT product_id FROM products
WHERE low_fats = 'Y'
AND recyclable = 'Y';
