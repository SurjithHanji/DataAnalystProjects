show databases;
create database sql_portfolios;
use sql_portfolios;

create table if not exists walmart(
	invoice_id varchar(30) not null primary key,
    branch varchar(5) not null ,
    city varchar(20) not null,
    customer_type varchar(30) not null,
    gender varchar(20) not null,
    product_line varchar(100) not null,
    unit_price decimal(10,2) not null,
    quantity int not null,
    vat float(6,4) not null,
    total decimal(12,4) not null,
    date datetime not null,
    time time not null,
    payment_method varchar(15) not null,
    cogs decimal(10,2) not null,
    gross_margin_per float(11,9) ,
    gross_income decimal(12,3) not null,
    rating float(2,1)
);

desc walmart;
select count(*) from walmart;
select * from walmart;

-- 1)time_of_day
select time,
	(
    case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
        when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
        end
	) as time_of_date
from walmart;

alter table walmart add column time_of_date varchar(30) not null;

update walmart set
	time_of_date= (
		case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
        when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
        end
);

set sql_safe_updates=0;


-- 2) Day Name
select `date`,
	dayname(date)
from walmart;

alter table walmart add column day_name varchar(20);

update walmart set 
	day_name=dayname(date);

-- 3) Month Name
select `date`,
	month(date)
from walmart;

select `date`,
	monthname(date)
from walmart;

alter table walmart add column month_name varchar(20) ;

update walmart set month_name=monthname(date);


-- 4) Number of unique cities
select count(distinct city) as unique_cities from walmart;

-- 5) in which city each bracnh
select distinct branch from walmart;

select distinct city,
branch
from walmart;

-- 6)how many unique products
select distinct product_line as unique_products from walmart;
select distinct count(distinct product_line) as unique_products from walmart;

-- 7)Most common payment method
select payment_method ,
	count(payment_method) as cnt
from walmart 
group by payment_method
order by cnt desc;

-- 8)what is most selling product line
select distinct product_line,
count(product_line) as cnt
from walmart 
group by product_line
order by cnt desc;

-- 9)what is total revenue by month
select month_name,
	sum(total) as total_rev
    from walmart
    group by month_name
    order by total_rev;
    
-- 10)what month had largest cogs
select month_name,sum(cogs) as total_cogs 
from walmart
group by month_name
order by total_cogs desc;

-- 11)which product_line has the largest rev
select product_line,sum(total) as total_rev
	from walmart
    group by product_line
    order by total_rev desc;
    
-- 12)what is city with largest revenue
select city,sum(total) as revnue
	from walmart
    group by city
    order by revnue desc
    limit 1;
    
-- 13)what product had the largest vat
select product_line,
	sum(vat) as VAT
    from walmart
group by product_line
order by vat desc limit 1;

-- 15)which branch sold more products tha average products sold
select branch,
	sum(quantity) as qty
from walmart 
group by branch
having sum(quantity) > (select avg(quantity) from walmart);

-- 16)what is most common product line by gender
select product_line,gender,
	count(gender) as total_cnt
from walmart
group by gender,product_line
order by total_cnt desc;

-- 17)what is average rating of each product_line
select product_line,
	avg(rating) as average_rating
from walmart
group by product_line;