
-- Tạo bảng lưu trữ dữ liệu tài chính của công ty TMĐT giả định
CREATE TABLE financials (
    id serial PRIMARY KEY,
    company_name VARCHAR(255),
    years INT,
    revenue DECIMAL(10,2), -- Doanh thu (tỷ USD)
    operating_expenses DECIMAL(10,2), -- Chi phí hoạt động (tỷ USD)
    net_income DECIMAL(10,2), -- Lợi nhuận ròng (triệu USD)
    net_profit_margin DECIMAL(5,2) -- Biên lợi nhuận ròng (%)
);

-- Tạo dữ liệu giả định với 20,000 dòng
INSERT INTO financials (company_name, years, revenue, operating_expenses, net_income, net_profit_margin)
SELECT 
    CASE 
        WHEN RANDOM() < 0.33 THEN 'Etsy' 
        WHEN RANDOM() < 0.66 THEN 'Amazon' 
        ELSE 'Shopify' 
    END,
    FLOOR(RANDOM() * 10 + 2014), -- Năm từ 2014 đến 2024
    ROUND(CAST(RANDOM() * 5 + 1 AS NUMERIC), 2), -- Doanh thu từ 1 đến 6 tỷ USD
    ROUND(CAST(RANDOM() * 3 + 0.5 AS NUMERIC), 2), -- Chi phí hoạt động từ 0.5 đến 3.5 tỷ USD
    ROUND(CAST(RANDOM() * 500 + 50 AS NUMERIC), 2), -- Lợi nhuận ròng từ 50 đến 550 triệu USD
    ROUND(CAST(RANDOM() * 5 + 1 AS NUMERIC), 2) -- Biên lợi nhuận từ 1% đến 6%
FROM 
    (SELECT 1 FROM generate_series(1,20000));

-- Phân tích xu hướng doanh thu, lợi nhuận ròng, biên lợi nhuận ròng
select company_name, avg(revenue) avg_revenue, avg(net_income) avg_net_income, avg(net_profit_margin) AS avg_profit_margin 
from financials
group by company_name
order by company_name, avg(net_profit_margin) desc;

-- years have highest avg
SELECT years, 
       SUM(net_income) AS total_net_income
FROM financials
GROUP BY years
ORDER BY total_net_income DESC
LIMIT 1;

select years, company_name, avg(revenue) avg_revenue, avg(net_income) avg_net_income, avg(net_profit_margin) AS avg_profit_margin 
from financials
group by years, company_name
order by years, company_name;
