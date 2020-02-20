#Select only the first 10 rows from the line_item table
SELECT *
FROM line_item
limit 10 ;
#Select only the columns sku, unit_price and date from the line_item table (and only the first 10 rows)
select sku,
unit_price,
date
from line_item
limit 10;
#2. Count the total number of rows of the line_item table
SELECT COUNT(*)
FROM line_item;
#2.1. Count the total number of unique "sku" from the line_item table
SELECT COUNT(DISTINCT sku)
FROM line_item;
#3. Generate a table with the average price of each sku
SELECT 
 DISTINCT SKU,
 AVG(unit_price) AS average_unit_price
 FROM line_item
GROUP BY sku;
#3.1.  …now name the column of the previous query with the average price "avg_price", and sort the list that you by that column (bigger to smaller price)
SELECT 
 DISTINCT SKU,
 AVG(unit_price) AS average_unit_price
 FROM line_item
GROUP BY sku
order by AVG(unit_price) desc ;
#4. Which products were bought in largest quantities? Select the “stock keeping unit” (sku) and product_quantity of the 100 products with the biggest "product quantity"
SELECT 
DISTINCT sku,
product_quantity
FROM line_item
order by product_quantity desc ;
#5. How many orders were placed in total?
SELECT COUNT(distinct id_order)
FROM orders;
#6. Make a count of orders by their state:
select 
distinct state,
count(distinct id_order)
from orders
group by state;
#7. Select all the orders placed in January of 2017
select *
from orders
where created_date BETWEEN '2017-01-01' and '2017-01-31';
#8. Count the number of orders of your previous select query (i.e. How many orders were placed in January of 2017?) 
select count(id_order)
from orders
where created_date BETWEEN '2017-01-01' and '2017-01-31';
#9. How many orders were cancelled on January 4th 2017? 
select count(id_order)
from orders
where  state='Cancelled' and (created_date BETWEEN '2017-01-04 00:00:00' and '2017-01-04 23:59:59');
#10.  How many orders have been placed each month of the year?
select count(id_order),
month(created_date)
from orders
group by month(created_date)
order by month(created_date) asc;
#11. What is the total amount paid in all the orders?
select sum(total_paid)
from orders;
#12. What is the average amount paid per order?
select cast(avg(total_paid) as decimal(10,2))
from orders;
#13. What is the date of the newest order? And the oldest?
select max(created_date) as newest_order,
min(created_date) as oldest_order
from orders;
#what is the day with the highest amount of completed orders (and how many completed orders were placed that day)?
select  Cast(created_date as date),
count(id_order) as max_order
from orders
where state='completed'
group by (cast(created_date as date))
order by max_order desc
limit 1;
#What is the day with the highest amount paid (and how much was paid that day)?
select cast(created_date as date),
sum(total_paid)
from orders
where state='completed'
group by (cast(created_date as date))
order by sum(total_paid) desc
limit 1 ;
#How many products are there?
select count(distinct ProductId)
from products;
#How many brands?
select count(distinct brand)
from products;
#How many categories?
select count(distinct manual_categories)
from products;
#How many products per brand & products per category?
select count(distinct ProductId),
brand
from products
group by brand;
select count(distinct ProductId),
manual_categories
from products
group by manual_categories;
#What's the average price per brand and the average price per category?
select avg(price),
brand
from products
group by brand;
select avg(price),
manual_categories
from products
group by manual_categories;
#What's the name and description of the most expensive product per brand and per category?
select  products.name_en,
products.short_desc_en, products.brand,products.price
from products
inner join (select max(price) as price,brand from products group by brand) as b on (b.price=products.price) and (b.brand=products.brand);

 select  products.name_en,
products.short_desc_en, products.manual_categories,products.price
from products
inner join (select max(price) as price,manual_categories from products group by manual_categories) as b on (b.price=products.price) and (b.manual_categories=products.manual_categories);
 
 