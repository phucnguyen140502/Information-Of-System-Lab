-- Top 5 most expensive products
select *
from products p 
order by price desc
limit 5;

-- Supplier, Product, and Inventory List: Includes information sorted by supplier and product name.
select p.*, s.supplier_name, s.contact 
from products p 
left join suppliers s 
on p.supplier_id = s.supplier_id 
where s.supplier_id is not null;

-- Add-On Products List: Includes products with inventory quantities below the reorder level.
select *
from products p 
where quantity_on_hand < reorder_level;

