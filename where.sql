#where clause
select * from employee_salary
 where salary >= 50000;
 select * from employee_salary where first_name='Leslie';
select * from employee_demographics where gender = 'female';
select * from employee_demographics where gender != 'female';
select * from employee_demographics;

-- and,or,not--logical operators
select * from employee_demographics where birth_date > '1985-01-01' and gender='male';
select * from employee_demographics where birth_date > '1985-01-01' or gender='male';
select * from employee_demographics where birth_date > '1985-01-01' or not gender='male';
select * from employee_demographics where birth_date > '1985-01-01' and not gender='male';
select * from employee_demographics where (first_name = 'Leslie' and age = 44) or age>50;

-- Like(%,__)
select * from employee_demographics where first_name like 'jer%';
select * from employee_demographics where first_name like '%er%';
select * from employee_demographics where first_name like 'a__';
select * from employee_demographics where first_name like 'a___';
select * from employee_demographics where first_name like 'a___%';
select * from employee_demographics where birth_date like '1989%';










