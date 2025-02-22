select *
from supplier_data sd;


select vendor_name , count(purchaser_order_number) total_orders,
	sum(cost_per_item) / count(purchaser_order_number) avg_cost_per_item, 
	sum(arrival_date - order_date) / count(purchaser_order_number) as avg_delivery_days,
	sum(accounts_payable_terms_per_days) / count(purchaser_order_number) avg_accounts_payable_terms_per_days 
from supplier_data sd 
group by vendor_name 
order by avg_cost_per_item desc, avg_delivery_days desc, avg_accounts_payable_terms_per_days desc;
