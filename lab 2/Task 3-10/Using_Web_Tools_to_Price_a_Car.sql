select *
from honda_crv_data hcd;

update honda_crv_data 
set trims = TRIM(REPLACE(model, 'Honda CR-V', ''));

update honda_crv_data 
set model = 'Honda CR-V';

-- Analysis price and trend

select *, avg_price_for_dealer_and_years_for_Autol - avg_price_for_dealer_and_years_for_Carvargo 
		as compare_avg_price_Autol_website_with_Carvargo
from (
	select *,
		lag(avg_price_for_dealer_and_years_for_Autol) 
			over (partition by years order by avg_price_for_dealer_and_years_for_Autol) 
			as avg_price_for_dealer_and_years_for_Carvargo
	from (
		select  years, avg(price) as avg_price_for_dealer_and_years_for_Autol
		from honda_crv_data hcd
		group by dealer, years
		order by years, dealer 
	)
)
where avg_price_for_dealer_and_years_for_Carvargo is not null;

-- Analysis following trims
select trims, avg(price) as avg_price, sum(mileage) as the_mileage_for_trims
from honda_crv_data hcd 
group by trims 
order by avg(price) desc;

select trims, dealer, count(*) as the_amount_trims_in_websites
from honda_crv_data hcd 
group by trims, dealer 
order by count(*) desc; 

select trims, conditions, count(*)
from honda_crv_data hcd 
where conditions = 'Like New'
group by trims, conditions 
order by count(*) desc;

-- Analysis following mileage 
SELECT 
    CASE 
        WHEN mileage < 50000 THEN 'Low Mileage (<50K)'  
        WHEN mileage BETWEEN 50000 AND 100000 THEN 'Medium Mileage (50K-100K)'  
        ELSE 'High Mileage (>100K)'  
    END AS mileage_category,  
    AVG(price) AS avg_price,  
    COUNT(*) AS total_cars  
FROM honda_crv_data 
GROUP BY mileage_category  
ORDER BY avg_price DESC;

SELECT 
    conditions,  
    AVG(mileage) AS avg_mileage,  
    COUNT(*) AS total_cars  
FROM honda_crv_data  
GROUP BY conditions  
ORDER BY avg_mileage ASC;

SELECT 
    dealer,  
    AVG(mileage) AS avg_mileage,  
    COUNT(*) AS total_cars  
FROM honda_crv_data  
GROUP BY dealer  
ORDER BY avg_mileage DESC;

-- Analysis conditions 
select conditions, avg(price) avg_price
from honda_crv_data hcd
group by conditions
order by avg(price);

select conditions, dealer, count(*) total_cars 
from honda_crv_data hcd
where conditions = 'Used - Good' or conditions = 'Like New'
group by conditions, dealer 
order by count(*) desc;

select conditions, financing_available, count(*) total_cars
from honda_crv_data hcd
group by conditions, financing_available 
order by count(*) desc;


-- Analysis financing_available 
select *, avg_price_having_financing_available - avg_price_not_having_financing_available 
	as compare_avg_price_having_and_nothaving_finacing_available
from (
	select *,
		lag(avg_price_having_financing_available) 
				over (order by avg_price_having_financing_available) 
				as avg_price_not_having_financing_available
	from (
		select financing_available, avg(price) avg_price_having_financing_available 
		from honda_crv_data hcd 
		group by financing_available 
	)
)
where avg_price_not_having_financing_available is not null ;


select financing_available , dealer, count(*) total_cars 
from honda_crv_data hcd
where financing_available = true
group by financing_available , dealer 
order by count(*) desc;

select delivery_available ,avg(price) avg_price  
from honda_crv_data hcd
group by delivery_available 
order by avg(price) desc;

select delivery_available , dealer, avg(price) avg_price  
from honda_crv_data hcd
where delivery_available = true
group by delivery_available , dealer 
order by avg(price) desc;