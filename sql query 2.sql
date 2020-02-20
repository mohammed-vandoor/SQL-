#Query 1. Our first query should return the "sku", "product_quantity", "date" and
# "unit_price" from the line_item table together with the "name" and the "price" of
# each product from the "products" table. We want only products present in both tables.
select line_item.date,line_item.sku,
line_item.product_quantity,
line_item.unit_price,products.price,products.name_en
from line_item
inner join products on line_item.sku=products.sku;
#Query 2. You might notice that the unit_price from the line_item table and the price 
#from the product table is not the same. Let's investigate that! Extend your previous 
#query by adding a column with the difference in price. Name that column price_difference.
select line_item.date,line_item.sku,
line_item.product_quantity,
line_item.unit_price,products.price,products.name_en,products.price-line_item.unit_price as price_difference
from line_item
inner join products on line_item.sku=products.sku;
#Query 3. Build a query that outputs the price difference that you just calculated, 
#grouping products by category. Round the result.
select round(products.price-line_item.unit_price ) as price_difference,products.manual_categories
from line_item
inner join products on line_item.sku=products.sku
group by manual_categories
order by price_difference desc;
#Query 4. Create the same query as before (calculating the price difference between the line_item and the products tables,
# but now grouping by brands instead of categories.
select round(products.price-line_item.unit_price ) as price_difference,products.brand
from line_item
inner join products on line_item.sku=products.sku
group by brand
order by price_difference desc;
#Query 5. Let's focus on the brands with a big price difference: 
#run the same query as before, but now limiting the results to only brands with an avg_price_dif of more than 50000. 
#Order the results by avg_price_dif (bigger to smaller).
select round(avg(products.price-line_item.unit_price )) as price_difference,products.brand
from line_item
inner join products on line_item.sku=products.sku
group by brand
having price_difference >50000
order by price_difference desc;
#Query 6. First, we will connect each product (sku) from the line_item table to the orders table. 
#We only want sku that have been in any order. This table will contain duplicates, 
#and we're ok with that. We will group and count this information later.
select orders.id_order,
orders.created_date,
orders.state,
orders.total_paid,
line_item.sku
from orders
inner join line_item on line_item.id_order=orders.id_order;
#Query 7. Now, add to the previous query the brand and the category from the products table to this query.
select orders.id_order,
orders.created_date,
orders.state,
orders.total_paid,
line_item.sku,
products.brand,
products.manual_categories
from orders
inner join line_item on line_item.id_order=orders.id_order
inner join products on products.sku=line_item.sku;
#Query 8. Let's keep working on the same query: now we want to keep only Cancelled orders.
#Modify this query to group the results from the previous query, first by category and then by brand,
# adding in both cases a count so we know which categories and which brands are most times present in Cancelled orders
select  count(*),brand,state
from (
select orders.state,
products.brand
from orders
inner join line_item on line_item.id_order=orders.id_order
inner join products on products.sku=line_item.sku
having state='Cancelled') as cancel
group by brand;



select  count(*),manual_categories,state
from (
select orders.state,
products.manual_categories
from orders
inner join line_item on line_item.id_order=orders.id_order
inner join products on products.sku=line_item.sku
having state='Cancelled') as cancel
group by manual_categories;