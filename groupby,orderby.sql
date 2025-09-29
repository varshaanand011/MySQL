use parks_and_recreation;
select * from parks_and_recreation.employee_demographics;
select gender from employee_demographics group by gender;
select gender,max(age),min(age),avg(age),count(age) from employee_demographics group by gender;
select * from parks_and_recreation.employee_salary;
select occupation as grpby_occupation ,avg(salary) as avg_of_salary from employee_salary group by occupation,salary;
use parks_and_recreation;
-- orderBy
select * from employee_demographics order by gender,age;
select * from employee_salary;

select occupation,avg(salary) as avg_salary from 
employee_salary where salary>50000
group by occupation
having avg(salary)>58000
order by avg_salary;

select occupation,avg(salary) from employee_salary 
where salary>50000
group by occupation
order by avg(salary); 
