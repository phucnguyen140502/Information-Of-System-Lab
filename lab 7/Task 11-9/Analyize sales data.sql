select region, avg(sales_amount) avg_sales_amount
from sales_data sd
group by region ;

select payment_method, count(*) total_count
from sales_data sd
group by payment_method ;

select transaction_time , count(*) the_interval_time_transaction
from sales_data sd
group by transaction_time  
order by the_interval_time_transaction desc;

select region,
	avg(case when product_type = 'Furniture' then sales_amount end) as Furniture,
	avg(case when product_type = 'Groceries' then sales_amount end) as Groceries,
	avg(case when product_type = 'Toys' then sales_amount end) as Toys,
	avg(case when product_type = 'Clothing' then sales_amount end) as Clothing,
	avg(case when product_type = 'Electronics' then sales_amount end) as Electronics
from sales_data sd
group by region ;