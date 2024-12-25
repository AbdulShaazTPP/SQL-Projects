----Data Analysis----

--1--How many people in each city are estimated to consume coffee, given that 25% of the population does?


select
city_name,
round((population * 0.25)/1000000, 2) as coffee_consumers_in_millions,
city_rank
from city
order by 2 desc


--2--what is the total revenue generated from coffee sales across all the cities in the last quarter?

select
ct.city_name,
sum(total) as revenue
from sales as s
join customers as c
on s.customer_id = c.customer_id
join city as ct
on ct.city_id = c.city_id
where 
extract(quarter from s.sale_date) = 4
and
extract(year from s.sale_date ) = 2023
group by city_name
order by 2 desc


--3--How many units of each coffee product have been sold?


select 
p.product_name,
count(s.sale_id) as total_orders
from products as p
left join 
sales as s 
on p.product_id = s.product_id
group by 1
order by 2 desc


--4--what is the average sales amount per customer in each city?


SELECT
ct.city_name,
SUM(s.total) AS revenue,
COUNT(DISTINCT s.customer_id) AS total_cx,
ROUND(CAST(SUM(s.total) * 1.0 / COUNT(DISTINCT s.customer_id) AS NUMERIC), 2) AS average_sales
FROM sales AS s
JOIN customers AS c
ON s.customer_id = c.customer_id
JOIN city AS ct
ON ct.city_id = c.city_id
GROUP BY ct.city_name
ORDER BY revenue DESC;


--5--provide the list of cities along with their population and estimated coffee consumers?

with city_table as 
(select city_name,
Round((population * 0.25)/1000000 , 2) as coffee_consumers
from city
),
customers_table
as
(select ci.city_name, count(distinct c.customer_id) as unique_customer
from sales as s
join customers as c
on c.customer_id = s.customer_id
join city as ci
on ci.city_id = c.city_id
group by 1
)

select customers_table.city_name,
city_table.coffee_consumers as coffee_consumers_in_millions,
customers.unique_customers
from city_table
join
customers_table
on
city_table.city_name = customers_table.city_name


--6--What are the top 3 selling products in each city based on sales?

SELECT 
    ct.city_name,
    p.product_name,
    COUNT(s.sale_id) AS total_orders
FROM sales AS s
JOIN products AS p
ON s.product_id = p.product_id
JOIN customers AS c
ON c.customer_id = s.customer_id
JOIN city AS ct
ON ct.city_id = c.city_id
GROUP BY ct.city_name, p.product_name
ORDER BY total_orders DESC;


