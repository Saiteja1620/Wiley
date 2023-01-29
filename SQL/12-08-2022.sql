Create database rankingdb;

Use rankingdb;

create table employee(emp_id int(5),Name varchar(20),Phone varchar(20),Address varchar(20),salary int(10),projects_comp int (5));

insert  into `employee`(`emp_id`,`Name`,`phone`,`Address`,`salary`,`projects_comp`) values 
(103,'Atelie',8059912345,'New York',137000,21),
(100,'Harris',9546248620,'California',200000,25),
(1002,'Murphy',8568612304,'Washington',120000,14),
(102,'Maria',8568705304,'Washington',125000,24),
(105,'Max',8708612304,'Chicago',132000,25),
(107,'Martin',7456612304,'	Los Angeles',130000,15),
(106,'Thomas',7456632504,'Austin',135000,17),
(108,'Jessica',7866632504,'Boston',140000,16),
(109,'James',8479632504,'Chicago',115000,14),
(110,'John',9516632504,'New York',137000,15),
(111,'Jackie',7421032504,'Boston',138000,27),
(101,'Janet',7050032504,'Houston',139000,19);

select * from employee;
-- row_number(), dense_rank(),rank()

-- it will jst generate row number..it won't consider same values
select *,row_number() over( order by projects_comp desc) from employee;

-- it will consider value irrespective of whether the value is same or not.
-- for every repeated rank nxt occurence is skipped..
-- i.e if rank 2 is repeated for 2 times then rank 3 won't be assigned...
-- directly 4th rank will be assigned to the next person
select *,rank() over( order by projects_comp desc) from employee;

-- if we wan't ideal behaviour then go with dense_rank()
select *, dense_rank() over(order by projects_comp desc) from employee;


use world;
select *, dense_rank() over(order by population desc) as cityRank from city where countrycode='ind';

with indianCities as
(
select *,dense_rank() over(order by population desc) as cityRank from city where countrycode='ind'
)
select * from indianCities where cityRank=1;

select * from country;

with largest as
(
select *, dense_rank() over(order by surfaceArea desc) as ran from country where continent='Asia'
)
select * from largest where ran=2;


CREATE TABLE IF NOT EXISTS sales1(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);


INSERT INTO sales1(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
select * from sales1;

select *, dense_rank() over(partition by fiscal_year order by sale desc) from sales1;

select *, dense_rank() over(order by sale desc) from sales1 where fiscal_year=2017;

use world;
with largest_continent as
(
select name,continent, dense_rank() over(partition by continent order by surfacearea desc) as continent_rank from country
)
select name,continent from largest_continent where continent_rank=3;


use employees;
select * from salaries;

with salary_rank as(
select emp_no,salary, dense_rank() over(partition by emp_no order by to_date desc) as latest from salaries)
select emp_no,salary from salary_rank where latest=1;

select * from countrylanguage;
with least as 
(
select *,dense_rank() over(partition by countrycode order by percentage ) lang_rank from countrylanguage
)
select countrycode,language,percentage from least where lang_rank=1;



-- working with indexes
-- mysql uses indexes to quickly find rows
-- mysql indexes help us improve search operation performance in Data.
-- without mysql indexes the mysql server will scan complete table data to find rows


use employees;
show index from employees;

select emp_no,first_name from employees where first_name='Shahab';
explain select emp_no,first_name from employees where first_name='Shahab';

create index firstNameIndex on employees(first_name);
show index from employees;
drop index firstNameIndex on employees;
explain select emp_no,first_name from employees where first_name='Shahab';

