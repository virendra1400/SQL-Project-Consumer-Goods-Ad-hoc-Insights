/*
Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns: 
Month 
Year 
Gross sales Amount
*/

SELECT 
	CONCAT(DATE_FORMAT(date,'%b')," ",YEAR(date)) AS "Month", 
	s.fiscal_year AS "Year",
	ROUND(SUM((sold_quantity * gross_price)/1000000),2) AS "Gross sales Amount"
FROM 
	fact_sales_monthly s
JOIN 
	fact_gross_price g ON s.product_code = g.product_code AND s.fiscal_year = g.fiscal_year
JOIN 
	dim_customer c ON c.customer_code = s.customer_code
WHERE 
	customer = 'Atliq Exclusive'
GROUP BY 
	Month,
	Year;