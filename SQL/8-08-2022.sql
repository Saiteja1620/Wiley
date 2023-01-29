create database triggerLab;
use triggerLab;

create table employees(empName varchar(255),salary int);
select * from employees;
insert employees values('nicklaus',7000),('windy',12000);
select * from employees;

create table avg_salary(average float);
insert avg_salary select avg(salary) from employees;
select * from avg_salary;

delimiter //
create trigger salary_checker BEFORE INSERT ON employees 
FOR EACH ROW
IF NEW.salary < 5000 THEN 
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT='Grrr! Salary is too less, must be greater than 5000';
END IF;//
delimiter ;


insert into employees values('sai', 4999);
insert employees values('teja',4999);


create trigger update_salary_1 after INSERT
ON Employees FOR EACH ROW
update avg_salary set average = (select avg(salary) from employees);



drop trigger update_salary;
select * from employees;
show triggers;
insert into employees values('sairam',6000);
select * from avg_salary;
insert into employees values('satya',10000);





create table emp_backup;
create table emp_backup like employees;
select * from emp_backup;
insert emp_backup values('nicklaus',7000),('windy',12000);

create trigger delete_backup after delete on employees for each row 
insert emp_backup values(old.empName,old.salary); 
drop table emp_backup;
delete from employees where empName='satya';
select * from emp_backup;

create trigger delete_backup_1 before delete on employees for each row 
insert emp_backup values(old.empName,old.salary); 



create table emp_update like employees;
insert emp_update values('nicklaus',7000),('windy',12000);

create table emp_update_2 like emp_update;
insert emp_update values('nicklaus',7000),('windy',12000);

drop table emp_update_2;

create trigger update_example after update on emp_update for each row 
insert emp_update_2 values(new.empName,new.salary);

insert emp_update values('shubham',20000);
update emp_update set salary=10000 where empName='shubham';
select * from emp_update_2;

