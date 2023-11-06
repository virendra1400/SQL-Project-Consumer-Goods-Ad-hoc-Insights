/*
Follow-up: Which segment had the most increASe in unique products in 2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference
*/

WITH CTE AS 
(
	SELECT 
		fiscal_year, segment, 
		COUNT(DISTINCT(s.product_code)) AS distinct_product_count
	FROM 
		gdb023.dim_product p
	JOIN 
		fact_sales_monthly s ON p.product_code= s.product_code
	GROUP BY 
		fiscal_year, segment 
	ORDER BY 
		fiscal_year
)

SELECT 
	c1.segment,
	c2.distinct_product_count AS distinct_product_count_2021,
	c1.distinct_product_count AS distinct_product_count_2022,
	c2.distinct_product_count - c1.distinct_product_count AS difference
FROM 
	CTE c1 
JOIN 
	CTE c2
ON 
	c1.fiscal_year = 2020 AND 
    c2.fiscal_year = 2021 AND 
    c1.segment = c2.segment;