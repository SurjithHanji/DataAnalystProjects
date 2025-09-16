show databases;
create database health;
use health;
show tables;

select * from healtht;

alter table healtht add column id int auto_increment primary key;

-- **BASIC EXPLORATION**
-- How many patients are in the dataset?
select distinct name from healtht;
select count(distinct name) from healtht;

-- What are the unique medical conditions recorded?
select distinct `medical condition` from healtht;

-- How many patients belong to each gender?
select gender,count(id) as no_of_patients 	
	from healtht
    group by gender;

-- What is the age distribution of patients?
select 
	case
		when age<20 then 'below 20'
        when age between 20 and 40 then 'young'
        when age in(40,70) then 'respect'
        else 'Old'
	end as Agegroup,
    count(*) as total_patients
from healtht
group by agegroup
order by agegroup;


-- Univariate Analysis
-- Which are the top 5 most common medical conditions?
select `medical condition`,sum(`billing amount`) as amount from healtht
	group by `medical condition`
    order by amount limit 5;
    
-- What is the average billing amount for each insurance provider?
select `insurance provider`,round(avg(`billing amount`),2) as amount 
	from healtht
    group by `insurance provider`;
    
-- Which medications are most frequently prescribed?
select Medication,count(*) as total_prescribed
	from healtht
    group by Medication;

-- What is the highest billing amount recorded, and for which patient?
select name,max(`Billing Amount`) as highest_billing_amount
		from healtht
        group by name
        order by highest_billing_amount desc limit 1;
        

-- Bivariate Analysis
-- Do older patients tend to have higher billing amounts? (Age vs. Billing)
SELECT 
    CASE 
        WHEN Age < 20 THEN 'Below 20'
        WHEN Age BETWEEN 20 AND 39 THEN '20-39'
        WHEN Age BETWEEN 40 AND 59 THEN '40-59'
        ELSE '60+'
    END AS AgeGroup,
    AVG(`Billing Amount`) AS avg_billing,
    COUNT(*) AS total_patients
FROM healtht
GROUP BY AgeGroup
ORDER BY avg_billing DESC;

-- Which medical conditions lead to the longest hospital stays?
select * from healtht;

SELECT 
    `Medical Condition`,
    AVG(DATEDIFF(
        STR_TO_DATE(`Discharge Date`, '%d-%m-%Y'),
        STR_TO_DATE(`Date of Admission`, '%d-%m-%Y')
    )) AS avg_no_of_days
FROM healtht
WHERE `Discharge Date` IS NOT NULL
GROUP BY `Medical Condition`
ORDER BY avg_no_of_days DESC;

-- What is the average billing amount by gender?
select gender,round(avg(`billing amount`),2) as avg_bill
	from healtht
    group by gender;
    
-- Advanced / Application-Level
-- Which doctor has treated the most patients?
select doctor,
	count(*) as total_patients from healtht
	group by doctor
    order by total_patients desc limit 1;
    
-- Which hospital generates the highest average billing?
select hospital,avg(`billing amount`) as avg_bill 
	from healtht
    group by hospital
    order by avg_bill desc limit 1;

-- What is the monthly trend of patient admissions?
select date_format(str_to_date(`date of admission`,'%d-%m-%y'),'%y-%m') as adm_month,
	count(*) as patient_admitfrom from healtht
	group by adm_month
    order by patient_admitfrom;
    
-- How do admission types (emergency, elective, etc.) affect billing amount?
select `admission type`,sum(`billing amount`) as bill
	from healtht 
    group by `admission type`;
    
-- Which room numbers are most frequently used?
SELECT 
    `Room Number`,
    COUNT(*) AS total_patients
FROM healtht
GROUP BY `Room Number`
ORDER BY total_patients DESC
LIMIT 10;
