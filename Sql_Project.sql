-- Q.1 Write a Query To Retrive All Columns For Sales Made On 2022-11-05
Select *
	From retail_sales
    Where sale_date = '2022-11-05';
    
-- Q. 2 Write a Query to retrive all transaction where category is 'Clothing' and the quantity sold as More Than 10
     -- In the Month of Nov - 2022.
     Select 
		category,
        SUM(quantity)
        FROM retail_sales
	WHERE category = 'Clothing'
    GROUP BY category;
    
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    YEAR (sale_date) as year,
    MONTH(sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as Rank1
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE Rank1 = 1;
    
-- ORDER BY 1, 3 DESC
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, 
--  Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN HOUR (sale_time) < 12 THEN 'Morning'
        WHEN HOUR (sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift





























