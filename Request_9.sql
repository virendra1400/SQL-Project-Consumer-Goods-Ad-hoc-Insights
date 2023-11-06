/*
Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
channel 
gross_sales_mln 
percentage
*/

WITH cte AS(
	SELECT 
		channel,
        s.fiscal_year,
		ROUND((SUM(sold_quantity * gross_price)/1000000),2) AS "gross_sales_mln"
	FROM 
		fact_sales_monthly s
	JOIN 
		fact_gross_price g ON s.product_code = g.product_code AND s.fiscal_year = g.fiscal_year
	JOIN 
		dim_customer c ON c.customer_code = s.customer_code
	GROUP BY 
		channel,
        s.fiscal_year
)
SELECT 
	c2.channel, 
	c2.gross_sales_mln, 
	ROUND(((c2.gross_sales_mln/(SELECT sum(gross_sales_mln) FROM cte WHERE fiscal_year=2021))*100),2) AS percentage
FROM 
	cte c1
JOIN 
	cte c2  ON c1.fiscal_year= '2020' AND
    c2.fiscal_year= '2021' AND 
    c1.channel = c2.channel
ORDER BY gross_sales_mln DESC;