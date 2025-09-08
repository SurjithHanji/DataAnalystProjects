use sql_portfolios;
show tables;
select * from walmart;

-- 1)Number of sales made in ecah time of the day per weekday
select 
	time_of_date,sum(quantity) as total_sales
from walmart
	where day_name='Sunday'
group by time_of_date;

-- 2)which customer type brings most revenue
select customer_type,sum(total) as total_rev
	from walmart
group by customer_type
order by total_rev desc 
limit 1;

-- 3)which city has the largest tax percent/VAT?
select city,
	avg(vat) as vat
	from walmart
group by city
order by vat desc;

-- 4)which cusotmer pays the most vat
select customer_type,
	avg(vat) as vat
	from walmart
group by customer_type
order by vat desc;

-- 5)unique customers type
select count(distinct customer_type) from walmart;

-- 6)how many unique payment methods
select count(distinct payment_method) as unique_pay_meth
	from walmart;

-- 7)most common customer type
select customer_type,count(customer_type) as cmn
	from walmart
group by customer_type
order by cmn desc;

-- 8)which customer type buys the most
select customer_type,
	count(*) as cstm_cnt
from walmart
group by customer_type
order by cstm_cnt desc;

-- 9)what is gendre of most customers
select gender,
	count(*) as gender_count
from walmart
group by gender
order by gender_count;

-- 10)what is gendre distributiion per branch
select branch,
	count(*) as gender_distri
from walmart
group by branch;

-- 11)what is the time of the day customers give most ratings
select time_of_date,
	avg(rating) as customer_rates
from walmart
group by time_of_date
order by customer_rates;

-- 12)what is the time of the day customers give most ratings per branch
select branch,time_of_date,
	avg(rating) as customer_rates
from walmart
group by time_of_date,branch
order by branch desc,time_of_date asc;

-- 13)which day of the week has the best avg ratings
select day_name,
	avg(rating) as average_rates
from walmart
group by day_name
order by average_rates desc
;

-- 14)which day of week has the average rating per branch
select day_name,
	avg(rating) as average_rates
from walmart
group by day_name
order by average_rates desc limit 1
;

