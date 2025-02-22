select distinct extract ( year from (week_ending))
from sales_data;

select distinct item_number, item_description
from sales_data sd;
-- Analysis the revenue in 2022


-- for week 
-- The revenue for regions for product_name = 24-inch Monitor
SELECT sales_region, item_number,  item_description ,
    EXTRACT(MONTH FROM week_ending) AS months,
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0) AS week_of_month, sum(unit_price*units_sold) as total_revenue_daily
FROM sales_data
where item_description = '24-inch Monitor' and item_number = '24M1001'
group by sales_region, item_number,  item_description ,
    EXTRACT(MONTH FROM week_ending),
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0)
order by EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0), sum(unit_price*units_sold) desc ;

-- The revenue for product_name = 24-inch Monitor and stores in East
select store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending) AS months,
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0) AS week_of_month, sum(unit_price*units_sold) as total_revenue_daily
FROM sales_data
where item_description = '24-inch Monitor' and item_number = '24M1001' and sales_region = 'East'
group by store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending),
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0)  
order by  store_id, EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0);

-- The revenue for product_name and store in East
select sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending) AS months,
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0) AS week_of_month, sum(unit_price*units_sold) as total_revenue_daily
FROM sales_data
where  sales_region = 'East'
group by sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending),
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0)  
order by  EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0), sum(unit_price*units_sold) desc;



--- East is the hightest in regions 
-- 24-inch Monitor is the highest revenue in products 




---- The stores and products have hightest revenue for each week 
select *
from (
select store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending) AS months,
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0) AS week_of_month, sum(unit_price*units_sold) as total_revenue_daily,
    rank() over (partition by EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0) order by sum(unit_price*units_sold) desc) as ranks
FROM sales_data
where sales_region = 'East'
group by store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending),
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0)  
order by EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0))
where ranks = 1;


---- The stores and products have lowest revenue for each week 
select *
from (
select store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending) AS months,
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0) AS week_of_month, sum(unit_price*units_sold) as total_revenue_daily,
    rank() over (partition by EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0) order by sum(unit_price*units_sold) asc) as ranks
FROM sales_data
where sales_region = 'East'
group by store_id, store_name, sales_region, item_number,  item_description,
    EXTRACT(MONTH FROM week_ending),
    CEIL(EXTRACT(DAY FROM week_ending) / 7.0)  
order by EXTRACT(MONTH FROM week_ending), CEIL(EXTRACT(DAY FROM week_ending) / 7.0))
where ranks = 1;