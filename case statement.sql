-- case statement
use parks_and_recreation;
SELECT first_name,
last_name,age,
case
    when age<=30 then 'adult'
    when age between 30 and 50 then 'old'
    when age >=50 then 'senior citizen'
end as age_group
from employee_demographics;

SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        when salary > 50000 then salary * 1.07
    END AS salary_bonus,
case
       when dept_id = 6 then salary * 0.10
end as finance_dept_bonus

-- orderby
FROM
    employee_salary;
SELECT * ,
    CASE 
        WHEN age between 20 and 40 THEN 'adult'
        WHEN age > 50 THEN 'senior'
        ELSE 'middle'
     END as age_grp
        FROM employee_demographics
    ORDER BY age_grp desc;
 
 -- aggregate
 
select gender,
sum(case when gender='male' then 1 else 0 end)as 'male_count',
sum(case when gender='female' then 1 else 0 end)as 'Female count'
from employee_demographics
group by gender;

