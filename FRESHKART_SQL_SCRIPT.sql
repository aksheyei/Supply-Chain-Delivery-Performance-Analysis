use freshkart;
show tables;

-- ANALYSING EACH TABLES
-- DIM CUSTOMERS
SELECT * FROM dim_customers;
-- COUNT OF CUSTOMER ID
SELECT
DISTINCT COUNT(customer_id) AS TOTAL_CUSTOMERS
FROM dim_customers;
-- CITIES OF CUSTOMER
SELECT
DISTINCT city
FROM dim_customers;

-- DIM PRODUCTS
SELECT * FROM dim_products;
-- CATEGORIES
SELECT
DISTINCT category 
FROM dim_products;
-- PRODUCT NAMES
SELECT
DISTINCT product_name
FROM dim_products;

-- FACT AGGREGATE TABLE
SELECT * FROM fact_aggregate;
-- TOTAL ORDERS
SELECT 
DISTINCT COUNT(order_id) AS ORDERS
FROM fact_aggregate;
-- PERIODS OF ORDER DATE
SELECT
MONTHNAME(order_placement_date) AS MONTH_NAME
FROM fact_aggregate
GROUP BY MONTH_NAME
ORDER BY MONTH_NAME;
-- MONTH WISE ORDERS
SELECT
MONTHNAME(order_placement_date) AS MONTH_NAME,
COUNT(*) AS ORDERS
FROM fact_aggregate
GROUP BY MONTH_NAME
ORDER BY MONTH_NAME;
-- COUNT OF ON TIME ORDERS
SELECT
SUM(on_time) AS ONTIME_ORDERS
FROM fact_aggregate;
-- COUNT OF IN FULL ORDERS
SELECT
SUM(in_full) AS INFULL_ORDERS
FROM fact_aggregate;
-- COUNT OF ONTIME AND INFULL ORDERS
SELECT
SUM(otif) AS OTIF_ORDERS
FROM fact_aggregate;
--  OTIF ORDERS RATE
SELECT
SUM(OTIF)/COUNT(order_id) *100 AS OTIF_RATE
FROM fact_aggregate;
-- MONTH WISE OTIF RATE
SELECT
MONTHNAME(order_placement_date) AS MONTH_NAME,
SUM(OTIF)/COUNT(order_id) *100 AS OTIF_RATE
FROM fact_aggregate
GROUP BY MONTH_NAME
ORDER BY MONTH_NAME;

-- FACT ORDER LINE TABLE
SELECT * FROM FACT_ORDER_LINE;
-- TOTAL ORDER LINES
SELECT 
COUNT(*) AS ORDER_LINES
FROM fact_order_line;
-- TOTAL ORDER QTY
SELECT
SUM(order_qty) AS TOTAL_QTY
FROM fact_order_line;
-- TOTAL DELIVERED_QTY
SELECT
SUM(delivery_qty) AS TOTAL_DELIVERED_QTY
FROM fact_order_line;
-- VOLUME RATE
SELECT
SUM(delivery_qty) /SUM(order_qty)*100 AS VOLUME_RATE
FROM fact_order_line;

-- CITY WISE OTIF RATE
SELECT
c.city AS CITIES,
SUM(a.otif)/count(a.order_id)*100 AS OTIF_RATE
FROM dim_customers c
LEFT JOIN fact_aggregate a
ON (c.customer_id=a.customer_id)
GROUP BY c.city;
-- CUSTOMER NAME WISE OTIF RATE
SELECT
c.customer_name AS CUSTOMER_NAME,
SUM(a.otif)/count(a.order_id)*100 AS OTIF_RATE
FROM dim_customers c
LEFT JOIN fact_aggregate a
ON (c.customer_id=a.customer_id)
GROUP BY c.customer_name
ORDER BY OTIF_RATE ASC;
-- PRODUCT WISE OTIF RATE
SELECT
p.product_name AS PRODUCT_NAME,
SUM(a.otif)/count(a.order_id)*100 AS OTIF_RATE
FROM dim_products p
LEFT JOIN fact_order_line o 
ON (p.product_id=o.product_id)
LEFT JOIN fact_aggregate a
ON (a.order_id=o.order_id)
GROUP BY p.product_name
ORDER BY OTIF_RATE ASC;

--  5 PRODUCT FACING OTIF RATE ISSUE

WITH ABC AS
(
SELECT
p.product_name AS PRODUCT_NAME,
SUM(a.otif)/count(a.order_id)*100 AS OTIF_RATE
FROM dim_products p
LEFT JOIN fact_order_line o 
ON (p.product_id=o.product_id)
LEFT JOIN fact_aggregate a
ON (a.order_id=o.order_id)
GROUP BY p.product_name
ORDER BY OTIF_RATE ASC)

SELECT
PRODUCT_NAME,
OTIF_RATE,
RANK() OVER (ORDER BY OTIF_RATE) AS RANKX
FROM ABC
LIMIT 5;

-- 5 CUSTOMERS FACING LOW OTIF RATE ISSUE

WITH DEF AS
(
SELECT
c.customer_name AS CUSTOMER_NAME,
SUM(a.otif)/count(a.order_id)*100 AS OTIF_RATE
FROM dim_customers c
LEFT JOIN fact_aggregate a
ON (c.customer_id=a.customer_id)
GROUP BY c.customer_name
ORDER BY OTIF_RATE ASC)

SELECT
CUSTOMER_NAME,
OTIF_RATE,
RANK() OVER (ORDER BY OTIF_RATE) AS RANKX
FROM DEF
LIMIT 5;

-- PRODUCTS FACING IN FULL DELIVERY 
SELECT
p.product_name AS PRODUCT_NAME,
COUNT(a.in_full) AS NOT_FULL_DELIVERED
FROM dim_products p
LEFT JOIN fact_order_line o 
ON (p.product_id=o.product_id)
LEFT JOIN fact_aggregate a
ON (a.order_id=o.order_id)
WHERE a.in_full = 0
GROUP BY p.product_name
ORDER BY NOT_FULL_DELIVERED DESC
LIMIT 5;

-- CUSTOMER WISE NOT FULLY ORDER COUNT
SELECT
c.customer_name AS CUSTOMER_NAME,
COUNT(a.in_full) AS NOT_FULL_DELIVERED
FROM dim_customers c
LEFT JOIN fact_aggregate a
ON (c.customer_id=a.customer_id)
WHERE a.in_full = 0
GROUP BY c.customer_name
ORDER BY NOT_FULL_DELIVERED DESC
LIMIT 5;

-- CITY WISE OT IF 
SELECT
c.city AS CITIES,
COUNT(a.on_time) as DELAYED_ORDER
FROM dim_customers c
LEFT JOIN fact_aggregate a
ON (c.customer_id=a.customer_id)
WHERE a.on_time = 0 
GROUP BY c.city;



