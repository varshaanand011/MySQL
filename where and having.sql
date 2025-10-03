-- where and having
use parks_and_recreation;
select gender,avg(age)
from employee_demographics
group by gender
having avg(age)>40;

select occupation,avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary)>70000;