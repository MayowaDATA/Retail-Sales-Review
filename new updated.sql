


-- Fix 'Bea', 'Beau', and 'Beaut' all at once
UPDATE retail_sales 
SET category = 'Beauty' 
WHERE category LIKE 'Bea%';

-- Ensure Clothing is unified (handles 'Clo', 'Clot', etc.)
UPDATE retail_sales 
SET category = 'Clothing' 
WHERE category LIKE 'Clo%';

-- Ensure Electronics is unified (handles 'Electr', 'Electron', etc.)
UPDATE retail_sales 
SET category = 'Electronics' 
WHERE category LIKE 'Electr%';

-- Rename the column from the typo 'quantiy' to 'quantity'
ALTER TABLE retail_sales 
CHANGE COLUMN quantiy quantity INT;

SELECT 
    category, 
    SUM(quantity) as total_items_sold 
FROM retail_sales 
GROUP BY category;

SELECT *
FROM retail_sales;
