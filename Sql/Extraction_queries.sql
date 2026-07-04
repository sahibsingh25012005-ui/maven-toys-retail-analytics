-- 1.Revenue,Profit,Units sold....

select round(sum(p.product_price*s.units),2) as Revenue,
sum(s.units)as Total_Units_sold,
sum((p.product_price-p.product_cost)*s.units)as Profit
from product p join sales s using(product_id);



-- 2.Top 10 product generate highest revenue

select p.product_name,round(sum(p.product_price*s.units),2) as Revenue
from product p join sales s using(product_id)
group by product_name
order by revenue desc limit 10;



-- 3.product which generate highest Profit

SELECT 
    p.product_name,
    ROUND(SUM((p.product_price - p.product_cost) * s.units),
            2) AS Profit
FROM
    product p
        JOIN
    sales s USING (product_id)
GROUP BY product_name
ORDER BY profit DESC
LIMIT 1;



-- 4.which store generate highest revenue

select st.store_name,
	round(sum(product_price *units),2) as Sales_Revenew,
	rank()over(order by sum(p.product_price * sl.units) desc) as "Rank"
from 
	stores st
join 
	sales sl 
using(store_id) 
	join 
product p 
	using(product_id)
group by store_name;



-- 5.City which generate highest revenue

select st.store_city,
	round(sum(product_price *units),2) as Revenue
from 
	stores st
join 
	sales sl 
using(store_id) 
	join 
product p 
	using(product_id)
group by store_city
order by Revenue desc
;



-- 6.Product Contribution to Total Revenue (%)
select 
	product_name,
round((sum(s.units*p.product_price)/
	(select sum(units*product_price)
from 
	sales join 
		product using(product_id)))*100,2) as Percentage 
	from 
sales s join 
	product p using(product_id)
group by product_name
	order by percentage desc;



-- 7.Analyze the Cumulative revenue generated over months.

with cte as (select year(date) Year,month(date) as Month,round(sum(product_price*units),2)as Revenue from 
product right join sales using(product_id)  group by year(date),month(date))
select Year,Month,round(sum(Revenue)over(order by Year,Month),2)as Cumulative_revenue from cte;
