use parks_and_recreation;
select * from employee_demographics;
select * from employee_salary;
select first_name,last_name,birth_date,age from employee_demographics;
select first_name,last_name,birth_date,age+10 from employee_demographics;
select first_name,last_name,birth_date,age,(age+10)*10 from employee_demographics;
select first_name,last_name,birth_date,(age*10)+100 from employee_demographics;

#Distinct
select distinct gender from employee_demographics;
select distinct gender,first_name from employee_demographics;


