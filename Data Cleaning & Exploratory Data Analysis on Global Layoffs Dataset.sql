-- data cleaning

select * from bikebuyers_data;
select * from layoffs;
-- 1. remove duplicates
-- 2. standardize the data
-- 3. null values or blank values
-- 4. remove any columns 

-- creating a copy table of another table 
create table layoffs_copy
like layoffs;
select * from layoffs_copy;

-- inserting values into a copy table from the original table
insert layoffs_copy 
select * from layoffs;

with duplicate_cte as
(select *,
row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions order by company) as row_num
from layoffs)
select * from duplicate_cte
where row_num >1;
select * from layoffs where
company='oda';

select * from layoffs_copy2
where row_num >1;

insert into layoffs_copy2 
select *,
row_number() over(partition by company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,country,funds_raised_millions order by company) as row_num
from layoffs;

delete from layoffs_copy2
where row_num >1;

select * from layoffs_copy2;

-- standardizing data
select company,trim(company)
from layoffs_copy2;

update layoffs_copy2
set company=trim(company);

select distinct industry from layoffs_copy2;

select industry from layoffs_copy2
where industry like 'crypto%';

update layoffs_copy2
set industry='Crypto'
where industry like 'Crypto%';

#using distinct we can remove duplicates
select distinct location from layoffs_copy2
order by 1;

-- to remove the extra space using trim
select distinct location,trim(location) 
from layoffs_copy;

-- using trailing to remove symbols
select distinct country,trim(trailing '.' from country) from layoffs_copy2;
update layoffs_copy2 set country=trim(trailing '.' from country)
where country like 'United States%' ;

-- to change the date format
select `date`,
str_to_date(`date`,'%m/%d/%Y')as Dates
 from layoffs_copy2;

update layoffs_copy2 
set `Date`=str_to_date(`date`,'%m/%d/%Y');

-- to convert texted date into date format
alter table layoffs_copy2 modify column
`date` Date;

-- to find the null values and if want two columns use "and"
select * from layoffs_copy2
where total_laid_off is null
and percentage_laid_off is null;

-- to find null or blank cells
select * from layoffs_copy2
where industry is null or
industry='';

select * from
layoffs_copy2 where
company='airbnb';

-- to join the industry which is from same comapny
SELECT 
    lf1.industry,lf2.industry
FROM
    layoffs_copy2 lf1
        JOIN
    layoffs_copy2 lf2 ON lf1.company = lf2.company
WHERE
    (lf1.industry IS NULL or lf1.industry ='')
        AND lf2.industry IS NOT NULL;
        
update layoffs_copy2 set industry = null
where industry='';

update layoffs_copy2 lf1 join
layoffs_copy2 lf2 on
lf1.company=lf2.company
set lf1.industry=lf2.industry
where lf1.industry is null
and lf2.industry is not null;

select * from layoffs_copy2
where total_laid_off is null;

update layoffs_copy2 set funds_raised_millions=0
where funds_raised_millions is null;

alter table layoffs_copy2 
drop column row_num;

select * from layoffs_copy2;

-- exploratory Data Analysis

select * from layoffs_copy2; 
select max(total_laid_off),max(percentage_laid_off)
from layoffs_copy2;
select * from layoffs_copy2
where percentage_laid_off =1
order by total_laid_off desc;

select company,sum(total_laid_off) sum_of_laidoff
 from layoffs_copy2
group by company
order by 2 desc;

select * from layoffs_copy2
where percentage_laid_off =1;

select min(`date`),max(`date`)
from layoffs_copy2;

select year(`date`),sum(total_laid_off) 
from layoffs_copy2
group by year(`date`)
order by 1 desc;

select stage,sum(total_laid_off) 
from layoffs_copy2
group by stage
order by 1 desc;

select company,sum(percentage_laid_off) sum_of_laidoff
 from layoffs_copy2
group by company
order by 2 desc;

select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_laid
from layoffs_copy2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc ;

WITH rolling_off AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `month`,
        SUM(total_laid_off) AS total_laid
    FROM layoffs_copy2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
)
SELECT 
    `month`,
    total_laid,
    SUM(total_laid) OVER(ORDER BY `month`) AS rolling_total
FROM rolling_off
ORDER BY `month`;

with company_cte
(company,years,total_laid_off) as
(select company,year(`date`),sum(total_laid_off)
from layoffs_copy2
group by company,year(`date`)
),company_rank as
(
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranks
from company_cte
where years is not null
)
select * from company_rank
where ranks<=5;



