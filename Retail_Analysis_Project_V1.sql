SELECT *
FROM retail_sales;

-- 1. Standardize Category Names
UPDATE retail_sales SET category = 'Clothing' WHERE category LIKE 'Clo%';
UPDATE retail_sales SET category = 'Electronics' WHERE category LIKE 'Electr%';
UPDATE retail_sales SET category = 'Beauty' WHERE category LIKE 'Beau%';

-- 2. Standardize Gender
UPDATE retail_sales SET gender = 'Male' WHERE gender LIKE 'M%';
UPDATE retail_sales SET gender = 'Female' WHERE gender LIKE 'F%';

-- 3. Handle Missing Values (Example: filling age with the average)
UPDATE retail_sales SET age = (SELECT AVG(age) FROM (SELECT age FROM retail_sales) as sub) WHERE age IS NULL;

-- 4. Delete rows with critical missing sales data
DELETE FROM retail_sales WHERE total_sale IS NULL OR quantiy IS NULL;


SELECT * 
FROM retail_sales;

-- 1. Calculate total profit and profit margin
SELECT 
    SUM(total_sale) as total_revenue,
    SUM(total_sale - cogs) as total_profit,
    (SUM(total_sale - cogs) / SUM(total_sale)) * 100 as profit_margin_percentage
FROM retail_sales;

-- 2. Rank categories by total profit.
SELECT 
    category,
    SUM(quantiy) as items_sold,
    SUM(total_sale) as total_revenue,
    SUM(total_sale - cogs) as total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- 3. Find the top 10 spenders.
SELECT 
    customer_id,
    SUM(total_sale) as lifetime_value,
    COUNT(ï»¿transactions_id) as purchase_frequency
FROM retail_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

-- 4. Analyze sales by Gender and Age Groups.
SELECT 
    CASE 
        WHEN age < 30 THEN 'Youth (Under 30)'
        WHEN age BETWEEN 30 AND 50 THEN 'Adult (30-50)'
        ELSE 'Senior (50+)'
    END as age_group,
    gender,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY age_group, gender
ORDER BY total_sales DESC;

-- 5. Find the peak sales month and hour.
(SELECT 'Peak Month' AS Period_Type, MONTHNAME(sale_date) AS Peak_Time, SUM(total_sale) AS Total_Sales
 FROM retail_sales
 GROUP BY Peak_Time
 ORDER BY Total_Sales DESC
 LIMIT 1)

UNION ALL

(SELECT 'Peak Hour' AS Period_Type, HOUR(sale_time) AS Peak_Time, SUM(total_sale) AS Total_Sales
 FROM retail_sales
 GROUP BY Peak_Time
 ORDER BY Total_Sales DESC
 LIMIT 1);
 
 (SELECT 
    'Peak Month' AS Period_Type, 
    MONTHNAME(STR_TO_DATE(sale_date, '%m/%d/%Y')) AS Peak_Time, 
    SUM(total_sale) AS Total_Sales
 FROM retail_sales
 GROUP BY Peak_Time
 ORDER BY Total_Sales DESC
 LIMIT 1)

UNION ALL

(SELECT 
    'Peak Hour' AS Period_Type, 
    HOUR(sale_time) AS Peak_Time, 
    SUM(total_sale) AS Total_Sales
 FROM retail_sales
 GROUP BY Peak_Time
 ORDER BY Total_Sales DESC
 LIMIT 1);
 
-- 6. Analyze transaction size.
SELECT 
    quantiy,
    COUNT(*) as transaction_count,
    SUM(total_sale) as revenue_contribution
FROM retail_sales
GROUP BY quantiy
ORDER BY quantiy DESC;




 
 
 




