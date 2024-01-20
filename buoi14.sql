--EX1
WITH SpendByYear AS (
    SELECT
        product_id,
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS total_spend
    FROM
        user_transactions
    GROUP BY
        product_id,
        EXTRACT(YEAR FROM transaction_date)
)

SELECT
    year,
    product_id,
    total_spend AS curr_year_spend,
    LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year) AS prev_year_spend,
    ROUND(((total_spend - LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year)) / LAG(total_spend) OVER (PARTITION BY product_id ORDER BY year)) * 100, 2) AS yoy_rate
FROM
    SpendByYear
ORDER BY
    product_id, year;
--EX2: 
--EX3:
WITH RankedTransactions AS (
  SELECT
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER () OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_rank
  FROM transactions
) 
  SELECT 
  user_id,
  spend,
  transaction_date
  FROM RankedTransactions
  WHERE transaction_rank ='3'

--EX4:
WITH latest_transactions_cte AS (
  SELECT
    transaction_date,
    user_id,
    product_id,
    RANK() OVER 
      (PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank
    FROM user_transactions
  )
  SELECT 
  transaction_date,
  user_id,
  COUNT(product_id) AS purchase_count
  FROM latest_transactions_cte 
  WHERE transaction_rank = 1
  GROUP BY  transaction_date,
  user_id
  ORDER BY transaction_date,user_id ASC 
--EX5 BAI NAY LAM KHONG RA HUHUHUHU
WITH rolling_avg_3d_CTE AS ( 
  SELECT
      user_id,
      tweet_date,	
      tweet_count,
      COALESCE(LAG(tweet_count, 1) OVER (PARTITION BY user_id ORDER BY tweet_date), 0) AS prev_day_count,
      COALESCE(LAG(tweet_count, 2) OVER (PARTITION BY user_id ORDER BY tweet_date), 0) AS prev_2nd_day_count
    FROM tweets 
  )
  SELECT 
  user_id,
  tweet_date, 
  ROUND(AVG(prev_day_count + prev_2nd_day_count + tweet_count),2)
  FROM rolling_avg_3d_CTE
  GROUP BY user_id, tweet_date
