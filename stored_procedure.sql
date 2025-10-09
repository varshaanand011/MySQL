use class;
CREATE TABLE Users (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

-- Insert 10 values
INSERT INTO Users (id, name, email, age) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', 25),
(2, 'Bob Smith', 'bob.smith@example.com', 30),
(3, 'Charlie Brown', 'charlie.brown@example.com', 28),
(4, 'Diana Ross', 'diana.ross@example.com', 32),
(5, 'Ethan Hunt', 'ethan.hunt@example.com', 35),
(6, 'Fiona White', 'fiona.white@example.com', 27),
(7, 'George King', 'george.king@example.com', 29),
(8, 'Hannah Lee', 'hannah.lee@example.com', 31),
(9, 'Ian Scott', 'ian.scott@example.com', 26),
(10, 'Julia Adams', 'julia.adams@example.com', 33);
select * from users;

delimiter $$
create procedure get_user(in user_id int)
begin
select * from users where id=user_id;
end $$
delimiter ;

call get_user(2);

#insertion through stored procedure using in parameter
Delimiter $$
create procedure add_users(in user_id int,in user_name varchar(50),in user_email varchar(50),in user_age int)
begin
 insert into users values(user_id,user_name,user_email,user_age);
 end $$
 delimiter ;
 
 call add_users(11,'Ayirin','ayirin22@gmail.com',33);
 
 #updation
 delimiter $$
 create procedure update_user(in user_id int,in user_name varchar(50),in user_email varchar(50),in user_age int)
 begin
 update users set name= user_name,email=user_email where id=user_id;
 end $$
 delimiter ;
 
 #deletion
 delimiter $$
 create procedure delete_user(in user_id int)
 begin
 delete from users where id=user_id;
 end $$
 delimiter ;
 
 #stored procedure with out parameters
 delimiter $$
 create procedure get_user_count(out user_count int)
 begin
 select count(*) into user_count from users;
 end $$
 delimiter ;
  
call get_user_count(@user_count);
select @user_count;
# @ is a temperory variable

#stored procedure with inout parameter
delimiter $$
create procedure update_user_email(inout user_id int,inout new_email varchar(50))
begin
update users set email= new_email where id=user_id;
end$$
delimiter ;

set @user_id=1;
set @user_email='abc@gmail.com';
call update_user_email(@user_id,@user_email);
select @user_id,@user_email;

 