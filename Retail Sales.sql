---SALES Analysis---

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id int,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar,
age	int,
category varchar,	
quantiy float,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales;

---WE CHECK FOR NULL VALUES---

SELECT * FROM retail_sales
WHERE
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;



--WE DELETE NULL VALUES--

DELETE FROM retail_sales
WHERE
transactions_id is null
OR
sale_date is null
OR
sale_time is null
OR
sale_time is null
OR
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR
price_per_unit is null
OR
cogs is null
OR
total_sale is null;


--DATA EXPLORATION--

--total sales--
SELECT COUNT(*) AS total_sales from retail_sales;

--Total Customers--
SELECT COUNT(DISTINCT CUSTOMER_ID) AS total_customers FROM RETAIL_SALES;

--CATEGORY--
SELECT DISTINCT CATEGORY AS CATEGORIES FROM RETAIL_SALES;



---1---SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"?

SELECT * FROM RETAIL_SALES
WHERE sale_date = '2022-11-05';

---2---WRITE SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS MORE THAN 4 IN MONTH OF NOVEMBER 2022-11-05

SELECT *
from retail_sales
where
category = 'Clothing'
and 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and
quantiy >= '4'


---3---WRITE AN SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY

SELECT category,
sum(total_sale) AS net_sales
from retail_sales
group by 1


---4---WRITE AN SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY.

SELECT round(avg(age), 0) as avg_age
from retail_sales
where category = 'Beauty'


---5---WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE TOTAL_SALE IS GREATER THAN 1000.

select * from retail_sales
where total_sale > 1000
order by total_sale ASC


---6---WRITE AN SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (TRANSACTIONS_ID) MADE BY EACH GENDER IN EACH CATEGORY

SELECT COUNT(transactions_id) as total_transactions, category, gender from retail_sales
group by category, gender
order by category


---7---WRITE AN SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH, FIND OUT THE BEST SELLING MONTH IN EACH YEAR

SELECT 
    EXTRACT(YEAR FROM sale_date) AS year, 
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS average_sales,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM 
    retail_sales
GROUP BY 
    EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date);




---8---FIND TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES

SELECT
customer_id,
total_sale
FROM RETAIL_SALES
order by 2 desc
limit 5;


---9---WRITE AN SQL QUERY TO FIND NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT  
COUNT(DISTINCT customer_id),
category
FROM RETAIL_SALES
group by 2


---10---WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS 

SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Noon'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 17 AND 20 THEN 'Evening'
		ELSE 'Night'
	end as shift
FROM RETAIL_SALES