create database if not exists salesdb;
use salesdb;
create table Test(first_col decimal(5,3));
insert into Test values(1.503402984);

insert into Test values(1.00);
select * from Test;
drop table Test;

-- adding column to existing table by using alter

alter table Test add column second_col int after first_col; 
select * from Test;


-- auto increment column or identity columns are those columns which generate values on their own. We don't pass values in insert stmt
create table Customers(
	purchase_number int not null auto_increment primary key,
    date_of_purchase date not null,
    customer_id int unique,
    item_code varchar(10) not null
);
drop table customers;
insert into Customers(date_of_purchase, customer_id, item_code) values
('2021-02-25',101,'P01020'),
('2021-03-22',102,'P01079'),
('2021-04-12',103,'P01075'),
('2021-05-22',104,'P01032'),
('2021-06-19',105,'P01073');

select * from customers;

create table orders(
	order_id int auto_increment primary key,
    qty int not null,
    txnvalue int not null,
    order_date date not null
);

insert into orders(qty, txnvalue, order_date) values
(1,2,'2022-07-28'),
(2,3,'2022-07-29');

select * from orders;

desc orders;

-- Activity-2
select * from customers;
create table transactions(transaction_id int primary key, txnValue int, cust_id int, txnDate date, 
foreign key (cust_id) references customers(customer_id));

insert into transactions values
(1,2,103,'2022-09-11'),
(2,3,104,'2022-09-11'),
(3,4,105,'2022-09-11');

insert into transactions values(1,2,106,'2022-09-11');

select * from transactions;


-- activity-3
create table customer_complaints(
	customer_id int auto_increment primary key,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
	number_of_complaints int default 0
);


insert into customer_complaints(first_name, last_name, email_address, number_of_complaints) values
('david','marcov','david4u@gmail.com',100),
('Jon','Seto','setojohn@gmail.com',default);

select * from customer_complaints;

desc customer_complaints;


-- dropping the constratins using the alter command
alter table customer_complaints alter column number_of_complaints drop default;

desc customer_complaints;
 
 
 -- changing the data type of number_of_complaints using modify
 
 alter table customer_complaints modify number_of_complaints varchar(255);
 select * from customer_complaints;
 desc customer_complaints;
 
-- changing the entire column using alter command
alter table customer_complaints change column number_of_complaints grivances int not null default 0; 

-- alter is used to add or remove column
-- change is used to change both name and datatype of a column
-- modify is used to change only datatype of a column

-- writing basic select queries
use world;
show tables;
select * from city;
select * from country;

-- can we compute columns mathematically? Yes
select name, district, population, population+1000 as 'new_pop' from city;

-- filtering rows using where
select * from city where id=24;
select * from city where population<1000;

-- cities with even id
select * from city where id%2=0;

-- logical operators and,or,not
select * from city where id>=4 and id<=12;
select * from city where District="Punjab" and CountryCode="IND";
select * from city where District="Punjab" and CountryCode="IND";

-- cities with id either 5,15,or 55
select * from city where id=5 or id=15 or id=55;

-- cities of China, India and Australia
select * from city where CountryCode="CHN" or CountryCode="IND" or CountryCode="AUS";

-- usage of not
-- cities where the id's are excluding between the range 2 and 999
select * from city where not (id>=2 and id<=999);

-- cities other than China , india and australia
select distinct(CountryCode) from city where not (CountryCode="CHN" or CountryCode="IND" or CountryCode="AUS");

-- sql best practices
-- Between 
select * from city where id between 2 and 15;
select * from city where id not between 2 and 999;

-- in
select * from city where countrycode in ("can","nld","afg");
select * from city where id in (2,56,77);x