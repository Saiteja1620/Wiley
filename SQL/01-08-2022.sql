use employees;
show tables;
-- 1
select first_name, last_name from employees;
-- 2
select * from employees where first_name="Denis";

-- 3
select * from employees where first_name="Denis" and gender="M";

-- 4
select * from employees where first_name in ("Denis","Elvis");
select * from employees where first_name="Delvis" or first_name="Elvis";

-- 5
select * from employees where last_name="Denis" and gender in ('M','F');
select distinct(gender) from employees;

-- 6
select * from employees where first_name not in ("Cathie","Mark","Nathan");

use world;
-- 7
show tables;
select * from countrylanguage where IsOfficial="T" and percentage between 80 and 90 limit 5;

-- 8
select * from city;
select * from city where name like "%ing" limit 5;

-- 9
select * from city where name like "Mo%" limit 5;


-- 10
select name from city where name like "%ee%" limit 5;

-- 11 ----important
select name from city where name like '____';
select name from city where length(name)=4;

-- 12
select name from city where name like '_a__';

-- 13---whenever we compare a column with NULL then we need to use "IS" keyword..not "="
select * from country ;
select name,IndepYear from country where IndepYear is NULL limit 5;

-- ----NULL TREATMENT--ifnull() and coalesce() are two functions to handle null values
-- isnull() needs two arguments to be passed.
select ifnull(null,'a');
select ifnull('b',null);
select ifnull('a','b');
select ifnull(null,null);

-- coalesce()  accept any number of arguments.
-- it will return the first non-null value
select coalesce(null,null,null,'ironman',null,'dr.strange');
select coalesce('batman','spiderman');

-- isnull() is a null replacer as we can see below
select name,ifnull(indepyear,'N/A') as 'newindepyear' from country ;

-- coalesce is not a null replacer
-- coalesce is used to fetch a value from table
select productname, coalesce(Price, oldPrice, AvgPrice, 0);

-- 14
select * from country;
select Name, ifnull(indepyear,concat('N/a for ',name)) as IndepYear from country limit 5;

-- sorting
select * from city where countrycode="IND" order by population desc limit 10;

select * from city where countrycode="IND" order by population desc limit 6,8;
 
 -- limit offset count of rows
 select * from city limit 6,8;

-- 15
-- third most populated city from china
select name from city where countrycode="CHN" order by population desc limit 2,1;

-- aggregate functions help us find statistical facts from data
-- max, min, count, avg, sum 
select max(population),min(population),count(population),avg(population),sum(population) from city;

-- 17
select count(*) from country where IndepYear is null;

-- 18
select distinct(name) from country;
select continent, count(name) as countrycount from country group by continent;

select * from city;
select countrycode, count(district) from city group by countrycode order by count(district) desc limit 5;




-- where clause doesn't work with group by so we need to use having clause
-- where is used to filter regular columns
-- having is used to filter aggregated columns i.e. having shd be used only when aggregate fucntions are used

-- 19
show tables;
select * from countrylanguage;
select language,count(language) as lcount from countrylanguage group by language order by lcount desc limit 5;

select * from city;
select district, count(district) as dcount from city where countrycode="IND" group by district order by dcount desc limit 10;

-- 20

select * from country;
select distinct region,avg(lifeexpectancy) as avg from country group by region order by avg limit 3;