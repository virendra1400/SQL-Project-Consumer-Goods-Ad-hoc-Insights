/*
In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, 
Quarter 
total_sold_quantity
*/

SELECT 
	CASE
		WHEN MONTH(date) IN (9,10,11) THEN 'Q1'
		WHEN MONTH(date) IN (12,1,2) THEN 'Q2'
		WHEN MONTH(date) IN (3,4,5) THEN 'Q3'
		ELSE 'Q4'
	END  AS "Qtr" ,
	SUM(sold_quantity) AS "total_sold_quantity"
FROM 
	fact_sales_monthly s
JOIN 
	dim_customer c ON c.customer_code = s.customer_code
WHERE 
	s.fiscal_year= '2020'
GROUP BY 
	Qtr
ORDER BY  
	SUM(sold_quantity) DESC;