use employees;
show tables;
select * from employees;
select count(*) from employees;
select * from dept_manager;
select count(*) from dept_manager;
select first_name, last_name from employees where emp_no in (select emp_no from dept_manager);

-- 1
use world;
select * from city;
select avg(population) from city where countrycode="IND";
select name,population from city where population > (select avg(Population) from city where CountryCode="IND") and CountryCode="IND" order by population desc limit 10;
select name from city where population > (select avg(Population) from city where CountryCode="IND") and CountryCode="IND" order by population desc limit 10;

-- 2 select most populated city from australia without using sorting
select name from city where population=(
select max(population) from city where countrycode="AUS");

-- 3
use employees;
select * from employees;
select * from titles;
select first_name, last_name from employees where emp_no in (select emp_no from titles where title="Senior Engineer" and from_date like "%-12-%") limit 5;

-- 4
use world;
select * from country;
select * from countrylanguage;
select name from country where country.code in (select countrylanguage.countrycode from countrylanguage group by countrycode having count(language)=12);


-- 5
select * from city c where population>(select avg(population) from city where countrycode=c.countrycode) ;


-- 6
select * from country;
select name from country c where LifeExpectancy < (select avg(LifeExpectancy) from country where region=c.region) limit 5;


-- 7
select * from city;
select name,countrycode,population from city c where population = (select max(population) from city where countrycode=c.countrycode) limit 5;