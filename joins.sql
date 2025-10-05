use parks_and_recreation;
select * from employee_demographics;
select * from employee_salary;

-- inner joins
select * from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id;

-- outer joins
#left joins
select * from employee_demographics as dem
left join employee_salary as sal
on dem.employee_id = sal.employee_id;

#right joins
select * from employee_demographics as dem
right join employee_salary as sal
on dem.employee_id = sal.employee_id;

