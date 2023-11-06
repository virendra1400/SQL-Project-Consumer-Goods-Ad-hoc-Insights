/*
Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields, 
division 
product_code
product 
total_sold_quantity 
rank_order
*/

WITH cte AS
(
	SELECT 
		division,
		p.product_code,
		product,
		SUM(sold_quantity) AS "total_sold_quantity", 
		RANK() OVER(PARTITION BY division ORDER BY SUM(sold_quantity) desc) AS rank_order
	FROM 
		fact_sales_monthly s
	JOIN 
		dim_product p ON p.product_code = s.product_code
	WHERE 
		s.fiscal_year = 2021
	GROUP BY 
		division,
		p.product_code,
		product
)
SELECT 
division,
product_code,
product,
total_sold_quantity,
rank_order
FROM cte WHERE rank_order IN (1,2,3);