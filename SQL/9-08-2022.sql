use world;
select * from city;

-- let us assume that i am asked to display restricted access to data.
-- data must be from India and only for uttar pradesh, only the name and district details are supposed to be displayed.

create view upCities as 
select name as cityName,district as 'District(State)' from city where countrycode='IND' and district='uttar pradesh';
drop view upCities;
desc upCities;
select * from upCities;

-- changing view defn using alter
alter view upCities as 
select name as cityName, district as 'District(State)', population from city where countrycode='IND' and district='uttar pradesh';


-- can we use view to update the data in the underlying table ? Yes
update upCities set population=0 where cityName='Kanpur';
select * from upCities;
select * from city where name='Kanpur';


use northwind;
show tables;
select * from employees;
select now();
select first_name,city from employees order by city;
SELECT 
    first_name, city
FROM
    employees
GROUP BY city;


SELECT 
    GROUP_CONCAT(first_name) AS first_name, city
FROM
    employees
GROUP BY city;

use world;
delimiter //
create procedure getUpCities() begin
select name,district from city where countrycode='ind' and district='uttar pradesh';
end //
delimiter ;


drop procedure getUpCities;

call getUpCities();

delimiter //
create procedure updatePopulation() 
begin
update city set countrycode='PAK' where district='uttar pradesh';
end //
delimiter ;

drop procedure updatePopulation;
call updatePopulation();
select * from city where district='uttar pradesh';

select * from city;

delimiter //
create procedure lastfifty()
begin 
select * from city where id >= (SELECT COUNT(id)/2 FROM city);
end //
delimiter ;

delimiter //
create procedure getCityById(in cityName varchar(255)) 
begin
select * from city where name=cityName;
end //
delimiter ;

call getCityById('dehra dun');
delimiter //
create procedure getRowsByCode(in code varchar(10))
begin
select * from city where countrycode=code;
end //
delimiter ;

call getRowsByCode('ind');

delimiter //
create procedure getCityCount(in districtName varchar(255),out count int)
begin
select count(*) from city where district=districtName;
end //
delimiter ;

call getCityCount('uttar pradesh',@total);

delimiter //
create procedure getCountOfPopulationByCountry(in code varchar(10),out count int)
begin
select sum(population) from city where countrycode=code;
end //
delimiter ;

call getCountOfPopulationByCountry('ind',@count);
select @count;

-- inout
delimiter //
create procedure getAveragePopulationByDistrict(inout mydata varchar(255))
begin
select avg(population) into mydata from city where district=mydata;
end //
delimiter ;

set @average='uttar pradesh';
call getAveragePopulationByDistrict(@average);
select @average;


-- afternoon acitivity
-- 
-- 
create database walmartdb;
use walmartdb;
create table foodItems(id int primary key, item varchar(255), product_category varchar(255), weight_per_cup int);
create table foodPurchaseDate(id int primary key, price int, purchase_unit int,price_per_unit int,invoice_id int,food_item_id int, foreign key (food_item_id) references foodItems(id),foreign key 
(invoice_id) references invoices(id));
create table invoices(id int primary key, invoice_date datetime, ordered_id int, price int, file_date datetime, vendor_id int, description varchar(255), invoice_number varchar(255));
drop table foodPurchaseDate;



use northwind;
show tables;
select * from products;
-- 1 SAI TEJA
select product_name, quantity_per_unit from products;

-- 2 SAI TEJA
select id,product_name from products where discontinued=0;

-- 3 SAI TEJA
select id,product_name from products where discontinued=1;

-- 4 SAI TEJA
select * from products;
show tables;
select product_name,list_price from products;


create table table1(id int);
insert table1 values(1),(1),(1),(2);

create table table2(id int);
insert table2 values(1),(1),(2),(2);

select * from table1 inner join table2  on table1.id=table2.id;
