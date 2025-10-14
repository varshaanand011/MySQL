-- subqueries
use parks_and_recreation;
SELECT first_name, salary, AVG(salary)
from employee_salary
group by first_name,salary; -- not

select first_name,last_name,salary,
(select avg(salary)
from employee_salary)
from employee_salary;

select avg(max_age)
from
(select gender,avg(age) avg_age,
min(age)min_age,
max(age) max_age,
count(age) count_age
from employee_demographics
group by gender) as agg_gender;

select avg(max_age),avg(min_age)
from (select gender,avg(age),
min(age) min_age,
max(age) max_age
,count(age)
from employee_demographics
group by gender) as agg_age;


