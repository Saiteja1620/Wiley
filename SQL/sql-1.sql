create database c275_db;
drop database c275_db;
use c275_db;
create table Products(
	product_id int primary key,
    pname varchar(255),
    price float not null,
    pdesc varchar(500)
);

select * from Products;

insert into Products values(101, 'Acer laptop', 54000,'Entertainment Laptop');
insert into Products values
(102,'Dell Laptop', 45000,'Personal Laptop'),
(103,'Asus Laptop', 80000,'Gaming Laptop'),
(104,'Lenovo Laptop',60000,'Personal Laptop');

insert into Products values(102,'Dell Laptop',10000, 'Gaming');


create table Sales(
prod_id int,
qty int,
ordered_date date,
foreign key(prod_id) references Products(product_id)
);

insert into Sales values(102,24,'2021-02-26');

select * from sales;

insert into Sales values(107,24,'2021-02-26');