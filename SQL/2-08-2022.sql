use employees;
select * from employees;
select first_name,count(emp_no) as count from employees group by first_name having count>250 order by count desc limit 5;
use employees;
select * from employees;
select count(city),count(distinct(city)) from employees;

use world;
show tables;
select name from city group by name having count(name)>1 order by count(name) desc limit 5;

use world;
show tables;
select * from countrylanguage;
select * from country;
select countrycode from countrylanguage where language="Hindi";
select name from country;
select name from country as c where countrycode in (select countrycode from countrylanguage where language="Hindi");

