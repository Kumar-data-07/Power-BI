# monthly trend
select 
    order_year,
    order_month,
    order_month_name,
    round(sum(revenue),2) as total_revenue,
    count(qty) as total_units
from
   fact_sales
where
    is_cancelled=0 and revenue is not null and order_date is not null
group by
    order_year,
    order_month,
    order_month_name
order by
    order_year,
    order_month;

# category wise sales
SELECT
    category,
    ROUND(SUM(revenue), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(qty) AS total_units,
    ROUND(AVG(amount), 2) AS average_amount
FROM fact_sales
WHERE is_cancelled = 0
  AND revenue IS NOT NULL
GROUP BY category
ORDER BY total_revenue DESC;

# category's percentage of revenue
select 
     category,
     round(sum(revenue),2) as total_revenue,
     round(sum(revenue)*100/
     (select
           sum(revenue)
	  from
          fact_sales
	  where is_cancelled=0 and revenue is not null),2) as revenue_percentage
from
   fact_sales
where is_cancelled=0 and revenue is not null
group by
     category
order by 
     total_revenue desc;

# state wise sales 
select 
     ship_state,
     round(sum(revenue),2) as total_sales,
     count(distinct order_id) as total_orders,
     count(qty) as total_units
from
    fact_sales
where
     revenue is not null and is_cancelled=0
group by
    ship_state
order by
     total_sales desc;
     
# fulfillent analysis
select
     fulfilment,
     round(sum(revenue),2) as total_sales,
     count(distinct order_id) as total_orders,
     count(qty) as total_units
from
    fact_sales
where
     is_cancelled=0 and revenue is not null
group by
     fulfilment
order by 
     total_sales desc;
     
# orders by status
select
     status,
     round(sum(revenue),2) as total_sales,
     count(distinct order_id) as total_orders,
     count(qty) as total_units
from
    fact_sales
group by
    status
order by 
    total_sales desc;
    
# b2b sales analysis
select 
    b2b,
    count(distinct order_id) as total_orders,
    count(qty) as total_units,
    round(sum(revenue),2) as total_revenue
from
   fact_sales
where
    is_cancelled=0 and revenue is not null
group by
    b2b
order by 
     total_revenue desc;
     
#size by sales analysis
select
    size,
    count(distinct order_id) as total_orders,
    count(qty) as total_units,
    round(sum(revenue),2) as total_revenue
from
  fact_sales
group by
    size
order by
    total_revenue
    
# sales by sales channel
select
     fulfilment,
     round(sum(revenue),2) as total_sales,
     count(distinct order_id) as total_orders,
     count(qty) as total_units
from
    fact_sales
where
     is_cancelled=0 and revenue is not null
group by
     fulfilment
order by 
     total_sales desc;
     
# orders by status
select
     status,
     round(sum(revenue),2) as total_sales,
     count(distinct order_id) as total_orders,
     count(qty) as total_units
from
    fact_sales
group by
    status
order by 
    total_sales desc;
    
# b2b sales analysis
select 
    b2b,
    count(distinct order_id) as total_orders,
    count(qty) as total_units,
    round(sum(revenue),2) as total_revenue
from
   fact_sales
where
    is_cancelled=0 and revenue is not null
group by
    b2b
order by 
     total_revenue desc;
     
#size by sales analysis
select
    sales_channel,
    count(distinct order_id) as total_orders,
    count(qty) as total_units,
    round(sum(revenue),2) as total_revenue
from
  fact_sales
where
   revenue is not null and is_cancelled=0 and sales_channel is not null
group by
    sales_channel
order by
    total_revenue desc;

# top 10 products by units sold
select
    sku,
    count(distinct order_id) as total_orders,
    count(qty) as total_units_sold,
    round(sum(revenue),2) as total_revenue
from
  fact_sales
where
   revenue is not null and is_cancelled=0 
group by
    sku
order by
    total_units_sold desc;

# Analyse monthly order volume
select 
     year(order_date) as order_year,
     month(order_date) as order_month,
     count(distinct order_id) as total_orders,
     count(qty) as total_units_sold,
     round(sum(revenue),2) as total_revenue
from
   fact_sales
where
     is_cancelled=0 and order_date is not null and revenue is not null
group by
      year(order_date), month(order_date)
order by 
     order_year,
     order_month;
     
# average of order value
select
     count(*) as total_order_lines,
     count(distinct order_id) as total_orders,
     round(sum(revenue),2) as total_revenue,
     round(sum(revenue)/count(distinct order_id),2) as average_order_value
from
   fact_sales
where
    is_cancelled=0 and revenue is not null
    
# cancellation_rate
select
     count(distinct order_id) as total_orders,
     count(distinct case when is_cancelled=1 then order_id end) as cancelled_orders,
     round(count(distinct case when is_cancelled=1 then order_id end)*100/
     nullif(count(distinct order_id),0)) as cancellation_rate_pct 
from
    fact_sales;

# Promotion analysis
select
      case when promotion_ids is null or
				trim(promotion_ids)= '' or 
                promotion_ids = 'No Promotion'
			then 'No Promotion' else 'Promotion Applied' end as promotion_status,
	  count(distinct order_id) as total_orders,
      count(qty) as total_unit_sold,
      round(sum(revenue),2) as total_revenue
from
    fact_sales
where
    is_cancelled=0 and revenue is not null
group by 
      promotion_status
order by 
     total_revenue;
     
# sales amount validation
select
     count(*) as total_rows,
     sum(amount is null) as null_amounts,
     sum(amount=0) as zero_amounts,
     sum(amount<0) as negative_amounts,
     round(min(amount),2) as minimum_amount,
     round(max(amount),2) as maximum_amount,
     round(avg(amount),2) as average_amount
from
    fact_sales;

# duplicate records
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS(
        '|',
        order_id,
        sku,
        order_date,
        qty,
        amount,
        ship_state
    )) AS distinct_records,
    COUNT(*) - COUNT(DISTINCT CONCAT_WS(
        '|',
        order_id,
        sku,
        order_date,
        qty,
        amount,
        ship_state
    )) AS possible_duplicate_rows
FROM fact_sales;

# row difference
select
     (select count(*) from stg_amazon_sales) as staging_rows,
     (select count(*) from fact_sales) as fact_rows,
     (select count(*) from stg_amazon_sales)-(select count(*) from fact_sales) as row_count_difference;
     
# Compare revenue with amount
     SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN is_cancelled = 0
             AND amount IS NOT NULL
             AND revenue IS NOT NULL
             AND ABS(revenue - amount) > 0.01
            THEN 1
            ELSE 0
        END
    ) AS mismatched_rows,
    SUM(
        CASE
            WHEN is_cancelled = 0
             AND amount IS NOT NULL
             AND revenue IS NULL
            THEN 1
            ELSE 0
        END
    ) AS missing_revenue_rows
FROM fact_sales;

# KPI 
SELECT
    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT CASE
        WHEN is_cancelled = 1 THEN order_id
    END) AS cancelled_orders,

    count(CASE
        WHEN is_cancelled = 0 THEN qty
        ELSE 0
    END) AS units_sold,

    ROUND(SUM(CASE
        WHEN is_cancelled = 0 THEN revenue
        ELSE 0
    END), 2) AS total_revenue,

    ROUND(
        SUM(CASE
            WHEN is_cancelled = 0 THEN revenue
            ELSE 0
        END)
        / NULLIF(COUNT(DISTINCT CASE
            WHEN is_cancelled = 0 THEN order_id
        END), 0),
        2
    ) AS average_order_value

FROM fact_sales;

# create monthly trend view
CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM fact_sales
WHERE order_date IS NOT NULL
  AND is_cancelled = 0
  AND revenue IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date);
    
select * from
     vw_monthly_sales
     
# category sales view
CREATE OR REPLACE VIEW vw_category_sales AS
SELECT
    category,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(qty) AS total_units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM fact_sales
WHERE is_cancelled = 0
  AND revenue IS NOT NULL
  AND category IS NOT NULL
GROUP BY category;

#  State wise sales view
create or replace view vw_state_sales as 
select
     ship_state,
     count(distinct order_id) as total_orders,
     sum(qty) as total_units_sold,
     round(sum(revenue),2) as total_revenue
from
    fact_sales
where
    is_cancelled=0 and revenue is not null and ship_state is not null
group by
     ship_state;
     
# fulfilment analysis view
create or replace view vw_fulfilment_analysis as 
select 
    fulfilment,
    count(distinct order_id) as total_orders,
    sum(qty) as total_units_sold,
    round(sum(revenue),2) as total_revenue
from
    fact_sales
where
    is_cancelled=0 and revenue is not null and fulfilment is not null
group by 
    fulfilment;

# b2b sales analysis
create or replace view vw_b2b_sales as 
select
     b2b,
     count(distinct order_id) as total_orders,
     sum(qty) as total_units_sold,
     round(sum(revenue),2) as total_revenue
from
   fact_sales
where
    is_cancelled=0 and revenue is not null and b2b is not null
group by
     b2b;

# product level sales analysis
create or replace view vw_product_sales as 
select
      sku,
      count(distinct order_id) as total_orders,
      sum(qty) as total_units_sold,
      round(sum(revenue),2) as total_revenue
from
    fact_sales
where
     is_cancelled=0 and revenue is not null and sku is not null
group by
     sku;

# KPI Summary 
create or replace view vw_kpi_summary as 
select
     count(distinct order_id) as total_orders,
     round(sum(case when is_cancelled=0 then revenue else 0 end),2) as total_revenue,
     count(distinct case when is_cancelled=1 then order_id else 0 end) as cancelled_orders,
     count(distinct case when is_cancelled=0 then order_id else 0 end) as completed_orders,
     sum(case when is_cancelled=0 then qty else 0 end) as total_units_sold,
     round(sum(case when is_cancelled=0 then revenue else 0 end)/
           count(distinct case when is_cancelled=0 then order_id else 0 end),2) as average_order_value
from
    fact_sales;
    


     
     
      
                
    
     