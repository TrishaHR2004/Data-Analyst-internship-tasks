select * from e_commerce_churn;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'e_commerce_churn'
ORDER BY ordinal_position;

--Create CUSTOMER DIMENSION TABLE
CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id TEXT UNIQUE,

    age INT,
    gender TEXT,
    country TEXT,
    subscription_status TEXT,

    signup_date DATE,
    purchase_frequency INT,
    cancellations_count INT
);


INSERT INTO dim_customer (
    customer_id,
    age,
    gender,
    country,
    subscription_status,
    signup_date,
    purchase_frequency,
    cancellations_count
)
SELECT DISTINCT
    customerid,
    age,
    gender,
    country,
    subscriptionstatus,
    signupdate,
    purchasefrequency,
    cancellationscount
FROM e_commerce_churn
WHERE customerid IS NOT NULL;



SELECT COUNT(*) FROM dim_customer;
SELECT * FROM dim_customer LIMIT 5;

SELECT * FROM dim_customer;

-- Create PRODUCT DIMENSION TABLE
CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id TEXT UNIQUE,

    product_name TEXT,
    category TEXT,
    preferred_category TEXT
);

INSERT INTO dim_product (
    product_id,
    product_name,
    category,
    preferred_category
)
SELECT DISTINCT
    productid,
    productname,
    category,
    preferredcategory
FROM e_commerce_churn
WHERE productid IS NOT NULL;

SELECT COUNT(*) FROM dim_product;
SELECT * FROM dim_product LIMIT 5;
SELECT * FROM dim_product;

--Create DATE DIMENSION TABLE
CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    month INT,
    day INT
);


INSERT INTO dim_date (full_date, year, month, day)
SELECT DISTINCT
    d.full_date,
    EXTRACT(YEAR FROM d.full_date)::INT AS year,
    EXTRACT(MONTH FROM d.full_date)::INT AS month,
    EXTRACT(DAY FROM d.full_date)::INT AS day
FROM (
    SELECT orderdate AS full_date FROM e_commerce_churn WHERE orderdate IS NOT NULL
    UNION
    SELECT lastpurchasedate FROM e_commerce_churn WHERE lastpurchasedate IS NOT NULL
    UNION
    SELECT signupdate FROM e_commerce_churn WHERE signupdate IS NOT NULL
) d;


SELECT COUNT(*) FROM dim_date;
SELECT * FROM dim_date ORDER BY full_date LIMIT 5;
SELECT * FROM dim_date;




--Create REGION DIMENSION TABLE 

CREATE TABLE dim_region (
    region_key SERIAL PRIMARY KEY,
    country TEXT UNIQUE
);


INSERT INTO dim_region (country)
SELECT DISTINCT
    country
FROM e_commerce_churn
WHERE country IS NOT NULL;

SELECT COUNT(*) FROM dim_region;
SELECT * FROM dim_region;


--Create FACT TABLE 

CREATE TABLE fact_orders (
    fact_key SERIAL PRIMARY KEY,

    customer_key INT REFERENCES dim_customer(customer_key),
    product_key INT REFERENCES dim_product(product_key),
    date_key INT REFERENCES dim_date(date_key),
    region_key INT REFERENCES dim_region(region_key),

    unit_price NUMERIC(12,2),
    quantity INT,
    revenue NUMERIC(14,2)
);


INSERT INTO fact_orders (
    customer_key,
    product_key,
    date_key,
    region_key,
    unit_price,
    quantity,
    revenue
)
SELECT
    dc.customer_key,
    dp.product_key,
    dd.date_key,
    dr.region_key,

    ec.unitprice,
    ec.quantity,
    (ec.unitprice * ec.quantity) AS revenue

FROM e_commerce_churn ec
JOIN dim_customer dc
    ON ec.customerid = dc.customer_id
JOIN dim_product dp
    ON ec.productid = dp.product_id
JOIN dim_date dd
    ON ec.orderdate = dd.full_date
JOIN dim_region dr
    ON ec.country = dr.country;

SELECT * FROM fact_orders;


SELECT * FROM e_commerce_churn;

SELECT * FROM dim_customer;
SELECT * FROM dim_product;
SELECT * FROM dim_date;
SELECT * FROM dim_region;


SELECT * FROM fact_orders;



CREATE INDEX idx_fact_customer ON fact_orders(customer_key);
CREATE INDEX idx_fact_product ON fact_orders(product_key);
CREATE INDEX idx_fact_date ON fact_orders(date_key);
CREATE INDEX idx_fact_region ON fact_orders(region_key);



SELECT inet_server_addr() AS server_ip,
       inet_server_port() AS server_port;

