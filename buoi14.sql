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
WITH LaunchInfo AS (
    SELECT
        card_name,
        MIN(issue_year * 12 + issue_month) AS launch_month
    FROM
        monthly_cards_issued
    GROUP BY
        card_name
)
SELECT
    m.card_name,
    m.issued_amount
FROM
    monthly_cards_issued m
JOIN
    LaunchInfo l ON m.card_name = l.card_name AND (m.issue_year * 12 + m.issue_month) = l.launch_month
ORDER BY
    m.issued_amount DESC;
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
--EX6
--EX7
WITH ranked_spending_cte AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)

SELECT 
  category, 
  product, 
  total_spend 
FROM ranked_spending_cte 
WHERE ranking <= 2 
ORDER BY category, ranking;
--EX8
WITH global_rank AS 
(
  SELECT 
  a. artist_name, 
  DENSE_RANK() OVER (
    ORDER BY COUNT(b.song_id) DESC) AS artist_rank
  FROM artists a
  JOIN songs b ON a.artist_id = b.artist_id
  JOIN global_song_rank c ON b.song_id= c.song_id
  WHERE c.rank <='10'
  GROUP BY a.artist_name
)

  SELECT artist_name, artist_rank
  FROM global_rank
  WHERE artist_rank <= 5
  ORDER BY artist_rank
