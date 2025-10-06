use class;
delimiter $$
create function square(x int)
returns int
deterministic
begin
return x*x;
end $$
delimiter ;

select square(6);


DELIMITER $$
CREATE FUNCTION random_num1()
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
  RETURN floor(RAND() * 10);
END $$
DELIMITER ;
select random_num1();


