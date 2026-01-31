SELECT * 
FROM retail_sales
LIMIT 10;


-- STEP 1: Total Sales Per Customer
SELECT 
    customerid,
    country,
    SUM(totalsales) AS total_sales
FROM retail_sales
GROUP BY customerid, country
ORDER BY total_sales DESC;

-- STEP 2: Dense Rank Customers per Country
SELECT *,
ROW_NUMBER() OVER (
    PARTITION BY country
    ORDER BY total_sales DESC
) AS row_num
FROM (
    SELECT 
        customerid,
        country,
        SUM(totalsales) AS total_sales
    FROM retail_sales
    GROUP BY customerid, country
) t
ORDER BY country, row_num;

-- STEP 3: Row Number Ranking per Country
SELECT *,
ROW_NUMBER() OVER (
    PARTITION BY country
    ORDER BY total_sales DESC
) AS row_num
FROM (
    SELECT 
        customerid,
        country,
        SUM(totalsales) AS total_sales
    FROM retail_sales
    GROUP BY customerid, country
) t;



-- STEP 4: Rank vs Dense Rank Comparison
SELECT *,
RANK() OVER (
    PARTITION BY country
    ORDER BY total_sales DESC
) AS rank_num,

DENSE_RANK() OVER (
    PARTITION BY country
    ORDER BY total_sales DESC
) AS dense_rank_num
FROM (
    SELECT 
        customerid,
        country,
        SUM(totalsales) AS total_sales
    FROM retail_sales
    GROUP BY customerid, country
) t
ORDER BY country, rank_num;



-- STEP 5: Running Total Sales
SELECT
    invoicedate,
    totalsales,
    SUM(totalsales) OVER (
        ORDER BY invoicedate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM retail_sales
ORDER BY invoicedate;



-- STEP 6: Month-over-Month Growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', invoicedate) AS month,
        SUM(totalsales) AS total_sales
    FROM retail_sales
    GROUP BY month
)
SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales
ORDER BY month;



-- STEP 7: Top 3 Products per Country
WITH product_sales AS (
    SELECT
        country,
        description AS product_name,
        SUM(totalsales) AS total_sales
    FROM retail_sales
    GROUP BY country, description
),
ranked_products AS (
    SELECT *,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS rank_num
    FROM product_sales
)
SELECT
    country,
    product_name,
    total_sales,
    rank_num
FROM ranked_products
WHERE rank_num <= 3
ORDER BY country, rank_num;
