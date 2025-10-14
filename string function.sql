use parks_and_recreation;
select first_name,length(first_name)
from employee_demographics
order by 2;

select length('skylight');

SELECT UPPER('skyline');

SELECT 
    first_name, UPPER(first_name)
FROM
    employee_demographics;

SELECT TRIM('       skyline    ');

SELECT RTRIM('       skyline    ');

SELECT 
    first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 3),
    SUBSTRING(first_name, 3, 2),
    birth_date,
    SUBSTRING(birth_date, 6, 2) birth_month
FROM
    employee_demographics;
    
select first_name,replace(first_name,'a','e')
from employee_demographics;

select locate('r','Varsha Anand')
from employee_demographics;

select first_name,locate('an',first_name)
from employee_demographics;

select concat(first_name," ",last_name)
from employee_demographics;

