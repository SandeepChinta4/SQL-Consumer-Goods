# Resume Challenge

-- Task 1
/*Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region. */
select 
	distinct market
from dim_customer
	where customer = "Atliq Exclusive" and region = "APAC" ;
 
 
-- Task 2
/* What is the percentage of unique product increase in 2021 vs. 2020? 
The final output contains these fields, unique_products_2020 unique_products_2021 percentage_chg */
select
	X.A as unique_products_2020,
    Y.B as unique_products_2021,
    ROUND(((B - A) * 100 / A),2) as percentage_chg
from 
		(select
			count(distinct(product_code)) as A
		from fact_sales_monthly
		where  fiscal_year = 2020) X,
		(select
			count(distinct(product_code)) as B
		from fact_sales_monthly
		where  fiscal_year = 2021) Y ;


-- Task 3
/*Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. 
The final output contains 2 fields, segment product_count  */
select
	segment,
	count(distinct(product_code)) as product_count
from dim_product
	group by segment
    order by product_count desc ;

-- Task 4
/*Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 
The final output contains these fields, segment product_count_2020 product_count_2021 difference  */
with cte1 as (
	select
		p.segment as A,
		count(distinct(s.product_code)) as B
	from fact_sales_monthly s
		join dim_product p
        on p.product_code = s.product_code
	where s.fiscal_year = 2020
	group by p.segment
),
cte2 as (
	select
		p.segment as C,
		count(distinct(s.product_code)) as D
	from fact_sales_monthly s
		join dim_product p
        on p.product_code = s.product_code
	where s.fiscal_year = 2021
	group by p.segment
)
select
	cte1.A as segment,
    cte1.B as product_count_2020,
    cte2.D as product_count_2021,
    (cte2.D - cte1.B) as difference
from cte1, cte2 
where cte1.A = cte2.C; 


-- Task 5
/* Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, product_code product manufacturing_cost */
select 
	m.product_code as product_code,
    concat(p.product, " (", p.variant, ") ") as product,
    m.manufacturing_cost as manufacturing_cost
from fact_manufacturing_cost m
	join dim_product p
    on m.product_code = p.product_code
where 
	m.manufacturing_cost = 	(select min(manufacturing_cost) from fact_manufacturing_cost)
    or
	m.manufacturing_cost = 	(select max(manufacturing_cost) from fact_manufacturing_cost)
order by m.manufacturing_cost desc ;

-- Task 6
/* Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the 
fiscal year 2021 and in the Indian market. 
The final output contains these fields, customer_code customer average_discount_percentage */
select
	c.customer_code,
	c.customer as customer,
    ROUND(avg(f.pre_invoice_discount_pct),2) as average_discount_percentage
from fact_pre_invoice_deductions f
	join dim_customer c
    on f.customer_code = c.customer_code
where fiscal_year = 2021
group by customer_code
order by average_discount_percentage desc 
Limit 5 ;

-- Task 7
/* Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
The final report contains these columns: Month Year Gross_sales_Amount */
with cte1 as (
	select
    c.customer as customer,
    monthname(s.date) as m,
    year(s.date) as y,
    ROUND((s.sold_quantity * g.gross_price),2) as Gross_sales_Amount
from fact_sales_monthly s
	join dim_customer c
		on s.customer_code = c.customer_code
	join fact_gross_price g
		on s.product_code = g.product_code
)
select
	customer,
	m as months,
	y as year,
	Gross_sales_Amount
from cte1
	where customer = "Atliq Exclusive" ;

-- Task 8
/* In which quarter of 2020, got the maximum total_sold_quantity? 
The final output contains these fields sorted by the total_sold_quantity, Quarter total_sold_quantity */
with cte1 as (
	select 
		date,
        month(date_add(date, interval 4 month)) as period,
        fiscal_year,
        sold_quantity
	from fact_sales_monthly 
)
select 
	CASE
		when period/3 <= 1 then "Q1"
        when period/3 <= 2 and period/3 > 1 then "Q2"
		when period/3 <=3 and period/3 > 2 then "Q3"
		when period/3 <=4 and period/3 > 3 then "Q4"
	END as quarter,
    sum(sold_quantity) as sold_quantity
from cte1
	where fiscal_year = 2020
    group by quarter
	order by sold_quantity desc ;    

-- Task 9
/* Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
The final output contains these fields, channel gross_sales_mln percentage */
with cte1 as (
	select
		c.channel as channel,
		sum(g.gross_price * s.sold_quantity) as gross_sales_total
	from fact_sales_monthly s
		join dim_customer c
			on s.customer_code = c.customer_code
		join fact_gross_price g
			on s.product_code = g.product_code
		where s.fiscal_year = 2021
        group by c.channel
        order by gross_sales_total desc 
),
cte2 as (
	select 
		channel,
		round((gross_sales_total/1000000),2) as gross_sales_mln		
	from cte1 
)
select 
	channel,
    gross_sales_mln,
    round(gross_sales_mln * 100 / sum(gross_sales_mln) over(), 2) as percentage
from cte2 ;

-- Task 10
/*Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
The final output contains these fields, division product_code product total_sold_quantity rank_order */
with cte1 as (
	select
		p.division as division,
        s.product_code as product_code,
        concat(p.product, " (", p.variant, ") ") as product,
        sum(s.sold_quantity) as total_sold_quantity,
        dense_rank() OVER (partition by division order by sum(sold_quantity) desc) AS rank_order
	from fact_sales_monthly s
		join dim_product p
        on s.product_code = p.product_code
	where s.fiscal_year = 2021
    group by product_code
)
select
	*
from cte1
	where rank_order <=3 ;
    
    
   

