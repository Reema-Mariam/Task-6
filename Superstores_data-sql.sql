create schema sales;
use sales;

select*from superstore_data; 

UPDATE superstore_data
SET `Order Date` = STR_TO_DATE(`Order Date`, '%d-%m-%Y'),
    `Ship Date` = STR_TO_DATE(`Ship Date`, '%d-%m-%Y');


UPDATE superstore_data
SET Sales = REPLACE(REPLACE(TRIM(Sales), '$', ''), ',', '');
UPDATE superstore_data
SET Profit = REPLACE(REPLACE(TRIM(Profit), '$', ''), ',', '');

ALTER TABLE superstore_data
CHANGE COLUMN `Row ID` row_id INT,
CHANGE COLUMN `Order ID` order_id VARCHAR(20),
CHANGE COLUMN `Order Date` order_date DATETIME,
CHANGE COLUMN `Ship Date` ship_date DATETIME,
CHANGE COLUMN `Ship Mode` ship_mode VARCHAR(30),
CHANGE COLUMN `Customer ID` customer_id VARCHAR(20),
CHANGE COLUMN `Customer Name` customer_name VARCHAR(100),
CHANGE COLUMN Segment segment VARCHAR(50),
CHANGE COLUMN Country country VARCHAR(50),
CHANGE COLUMN City city VARCHAR(50),
CHANGE COLUMN State state VARCHAR(50),
CHANGE COLUMN `Postal Code` postal_code VARCHAR(10),
CHANGE COLUMN Region region VARCHAR(50),
CHANGE COLUMN `Product ID` product_id VARCHAR(20),
CHANGE COLUMN Category category VARCHAR(50),
CHANGE COLUMN `Sub-Category` sub_category VARCHAR(50),
CHANGE COLUMN `Product Name` product_name TEXT,
CHANGE COLUMN Sales sales DOUBLE,
CHANGE COLUMN Quantity quantity INT,
CHANGE COLUMN Discount discount DOUBLE,
CHANGE COLUMN Profit profit DOUBLE;

SELECT Sales FROM superstore_data
WHERE Sales REGEXP '[^0-9\\.\\-]';

select*from superstore_data;

select 
   extract(year from order_date) as order_year,
   extract(month from order_date) as order_month,
   sum(sales) as total_revenue,
   count(distinct order_id) as order_volume
from superstore_data
group by order_year, order_month
order by order_year, order_month;

select
   extract(year from order_date) as order_year,
   quarter(order_date) as quarter,
   sum(sales) as total_revenue,
   count(distinct order_id) as order_volume
from superstore_data
group by order_year, quarter
order by order_year, quarter;

select
    segment,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS order_volume
from superstore_data
group by segment
order by total_revenue desc;

select category, sub_category,
     sum(sales) as total_revenue,
     sum(profit) as total_profit
 from superstore_data
 group by category, sub_category
 order by total_revenue desc
 limit 10;

select
    ship_mode,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
from superstore_data
group by ship_mode
order by total_sales desc;

select 
    region,
    state,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
from superstore_data
group by region, state
order by total_sales desc
limit 10;

select
    AVG(discount) AS avg_discount,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales
from superstore_data;

select
    customer_name,
    COUNT(order_id) AS orders_count,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
from superstore_data
group by customer_name
order by total_sales desc
limit 10;

