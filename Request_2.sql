/*
What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
unique_products_2020 
unique_products_2021 
percentage_chg
*/
 
WITH cte AS (
    SELECT 
        fiscal_year, 
        COUNT(DISTINCT s.product_code) AS distinct_product_count
    FROM 
        dim_product p
    JOIN
        fact_sales_monthly s ON s.product_code = p.product_code
    GROUP BY
        fiscal_year
)
SELECT 
    c1.distinct_product_count AS unique_products_2020, 
    c2.distinct_product_count AS unique_products_2021, 
    ROUND(((c2.distinct_product_count - c1.distinct_product_count) * 100.0 / NULLIF(c1.distinct_product_count, 0)), 2) AS percentage_chg 
FROM 
    cte c1 
JOIN 
    cte c2 
ON 
    c1.fiscal_year = '2020' AND c2.fiscal_year = '2021';