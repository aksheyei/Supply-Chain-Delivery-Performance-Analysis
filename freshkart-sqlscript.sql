create database freshkart;
use freshkart;
show tables;
select * from dim_customers;
select * from dim_products;
select * from fact_aggregate;
select * from fact_order_line;

-- analysing each tables
select * from dim_customers;
select count(*) from dim_customers;
select distinct city from dim_customers;
select distinct currency from dim_customers;

select * from dim_products;
select distinct product_name from dim_products;
select distinct count(*) from dim_products;
select distinct category from dim_products;

select * from fact_aggregate;
select * from fact_order_line;
-- total orders
select count(*) from fact_aggregate;
-- count of orders that met on time
select count(*) as orders from fact_aggregate
where on_time =1;
-- count of orders that not met on time
select count(*) as orders from fact_aggregate
where on_time =0;
-- orders that fully delivered
select count(*) as orders from fact_aggregate
where  in_full=1;
-- orders that not fully delivered
select count(*) as orders from fact_aggregate
where  in_full=0;
-- count of orders that ontime and in full
select count(*) as orders from fact_aggregate
where otif=1;

-- volume rate % (total delivered order/total ordered order
select * from fact_order_line;
select sum(order_qty) as total_qty,
sum(delivery_qty) as total_delivered,
sum(delivery_qty)/sum(order_qty)*100 as volume_rate
from fact_order_line;

-- on time delivery%
select * from fact_aggregate;

select
count(order_id) as total_orders,
sum(on_time) as on_time_orders,
sum(on_time)/count(order_id)*100 as ontime_perc
from fact_aggregate;

-- in full delivery %
select
count(order_id) as total_orders,
sum(in_full) as in_full_orders,
sum(in_full)/count(order_id)*100 as infull_delivery_perc
from fact_aggregate;

-- otif %
select
count(order_id) as total_orders,
sum(otif) as ontime_full_deliveryorder,
sum(otif)/count(order_id) *100 as otif_perc
from fact_aggregate;
 
 
 desc  fact_aggregate;
 UPDATE fact_aggregate
SET order_placement_date = STR_TO_DATE(order_placement_date, '%d-%m-%Y');
ALTER TABLE fact_aggregate
MODIFY order_placement_date DATE;
-- month wise orders

select
count(*) as total_orders,
monthname(order_placement_date) as month_name
from fact_aggregate
group by month_name
order by month_name;

-- customerwise orders

select
 c.customer_name,
 count(a.order_id) as orders
 from dim_customers c
 left join fact_aggregate a
 on(c.customer_id = a.customer_id)
 group by c.customer_name
 order by c.customer_name;
 
 -- customer wise on time in full oitf
 

select
	 c.customer_name,
	 count(a.order_id) as orders,
	 sum(a.on_time) as ontime,
	 sum(a.in_full) as infull,
	 sum(a.otif) as otif
 from dim_customers c
 left join fact_aggregate a
 on(c.customer_id = a.customer_id)
 group by c.customer_name
 order by c.customer_name;
 
 -- identify customers with high otif %
 
 select
	 c.customer_name,
	 sum(a.otif) as otif,
	 count(a.order_id) as total_order,
	  sum(a.otif)/ count(a.order_id)*100  as otif_perc
	from dim_customers c
    left join fact_aggregate a
    on (c.customer_id = a.customer_id)
    group by c.customer_name
    order by otif_perc desc;
    
    -- product wise otif
    
    select * from dim_products;
    
    select
    p.product_name,
     sum(a.otif) as otif,
	 count(a.order_id) as total_order,
	  sum(a.otif)/ count(a.order_id)*100  as otif_perc
      from dim_products p
      left join fact_order_line o
      on (p.product_id=o.product_id)
     left join fact_aggregate a 
     on (a.order_id=o.order_id)
      group by p.product_name
      order by otif_perc;
  
  -- 5 products which have low otif rate
   select * from dim_products;
    
    select
    p.product_name,
     sum(a.otif) as otif,
	 count(a.order_id) as total_order,
	  sum(a.otif)/ count(a.order_id)*100  as otif_perc
      from dim_products p
      left join fact_order_line o
      on (p.product_id=o.product_id)
     left join fact_aggregate a 
     on (a.order_id=o.order_id)
      group by p.product_name
      order by otif_perc
      limit 5;
 
 -- 5 customers having  low otif rate
 select
	 c.customer_name,
	 sum(a.otif) as otif,
	 count(a.order_id) as total_order,
	  sum(a.otif)/ count(a.order_id)*100  as otif_perc
	from dim_customers c
    left join fact_aggregate a
    on (c.customer_id = a.customer_id)
    group by c.customer_name
    order by otif_perc 
    limit 5;


