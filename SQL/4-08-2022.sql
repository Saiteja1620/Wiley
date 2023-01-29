create database if not exists restaurandb;

use restaurandb;


create table walkin_customer(
	mobileno varchar(10),
    custname varchar (100),
    address varchar (100),
    email_id varchar (40),
    cust_type varchar(40)
    );
    
create table online_customer(
	mobileno varchar(10),
    custname varchar (100),
    address varchar (100),
    email_id varchar (40),
    cust_type varchar(40)
    );

insert online_customer values
(111,'Ajay','New Patel Nagar','ajay@gmail.com','Online'),
(777,'Sudhir','Park Street','sudhir@live.com','Online'),
(333,'Sujay','Defence Area','sujay@live.com','Online'),
(888,'Rashmi','Kaulagarh','rashmi@fashion.com','Online'),
(555,'jay','Rajpur Road','Jay@iit-delhi.com','Online'),
(999,'Sagar','RamGarh','sagar@indten.com','Online');

insert walkin_customer values
(111,'Ajay','New Patel Nagar','ajay@gmail.com','walk-in'),
(222,'Vijay','Old Street','vijay@yahoo.com','walk-in'),
(333,'Sujay','Defence Area','sujay@live.com','walk-in'),
(444,'Dhananjay','ClockTower','Dhananjay@vista.com','walk-in'),
(555,'jay','Rajpur Road','Jay@iit-delhi.com','walk-in'),
(666,'Sanjay','Mussorie Road','Sanjay@nitRaipur.com','walk-in');

show tables;
select * from online_customer;

select * from online_customer;

select wc.mobileno 'walkinMobileNo' , oc.mobileno 'onlineMobileNo' , wc.custname  'walkinCustomer',   oc.custname 'onlineCustomer',
wc.cust_type 'WalkinCustType',oc.cust_type 'onlineCustType'
from 
walkin_customer wc 
inner join 
online_customer oc 
on wc.custname = oc.custname;

-- afternoon activity-1
use employees;
select * from employees;
select * from dept_manager;
select e.emp_no,e.first_name,e.last_name,d.dept_no from employees e join dept_manager d on e.emp_no=d.emp_no;

-- activity-2
select * from departments;

select e.emp_no,e.first_name,e.last_name,d.dept_no,ds.dept_name from employees e join dept_manager d on e.emp_no = d.emp_no join departments ds 
on ds.dept_no=d.dept_no limit 5;

-- activity-3
-- EQUI JOIN only uses '=' but in inner join we can use '=','<','>','<=','>='... 
-- it never uses 'on' keyword but inner join needs to use it for sure..'where' clause is used in inner join 
select wc.mobileno as 'walkinMobile' , oc.mobileno as 'onlineMobile', wc.custName 'walkinCustomer'
, oc.custName as 'onlineCustomer',wc.cust_type,oc.cust_type from
walkin_customer wc ,online_customer oc
where wc.mobileno=oc.mobileno;

-- NATURAL JOIN
-- it automatically determines the common column and performs join and returns the common records

create table test1(a int, xyz int);
create table test2(a int, jkl int);
create table test7(c varchar(10), abc int);
insert test1 values(1,2);
insert test1 values(3,4);
insert test7 values('sql',2);


-- left join 
-- return all the rows from left table and matching rows from right table
select wc.mobileno 'walkinMobileNo' , oc.mobileno 'onlineMobileNo' , wc.custname  'walkinCustomer',   oc.custname 'onlineCustomer',
wc.cust_type 'WalkinCustType',oc.cust_type 'onlineCustType'
from 
walkin_customer wc 
left join 
online_customer oc 
on wc.custname = oc.custname where oc.mobileNo is null;

-- right join 
-- return all records from right table and returns matching records from the left side
select wc.mobileno 'walkinMobileNo' , oc.mobileno 'onlineMobileNo' , wc.custname  'walkinCustomer',   oc.custname 'onlineCustomer',
wc.cust_type 'WalkinCustType',oc.cust_type 'onlineCustType'
from 
walkin_customer wc 
right join 
online_customer oc 
on wc.custname = oc.custname where wc.mobileNo is null;

-- full join 
-- all records from both the tables
select * from walkin_customer cross join online_customer;
select wc.mobileno 'walkinMobileNo' , oc.mobileno 'onlineMobileNo' , wc.custname  'walkinCustomer',   oc.custname 'onlineCustomer',
wc.cust_type 'WalkinCustType',oc.cust_type 'onlineCustType'
from 
walkin_customer wc 
left join 
online_customer oc 
on wc.custname = oc.custname
union all	
select wc.mobileno 'walkinMobileNo' , oc.mobileno 'onlineMobileNo' , wc.custname  'walkinCustomer',   oc.custname 'onlineCustomer',
wc.cust_type 'WalkinCustType',oc.cust_type 'onlineCustType'
from 
walkin_customer wc 
right join 
online_customer oc 
on wc.custname = oc.custname;

-- union eliminated the duplicate rows but union all allows duplicates

create database electronic_store;
use electronic_store;
create table products(pro_id int,p_price int, p_name varchar(10));
create table accessories(a_id int, acc_name varchar(10),acc_price int);
insert products values
(101,30000,'DellStudio'),
(102,50000,'LenovoYoga'),
(103,70000,'HpSpectre');

insert accessories values
(21,'BagPack',1000),
(22,'WaterBotle',5000),
(23,'TorchLite',8000);

select pro_id,p_name,acc_name, p_price+acc_price from products cross join accessories;
use employees;
create table empcpy as select * from employees limit 5;
select * from empcpy;
select year(birth_date)-100 from empcpy;
select e.first_name,e.birth_date,e2.first_name,e.birth_date, year(e.birth_date)-year(e2.birth_date) as Year_difference
 from empcpy e cross join empcpy e2;
 
 -- important function datediff
select e1.first_name,e1.birth_date,e2.first_name,e2.birth_date, concat(datediff(e1.birth_date,e2.birth_date)/365,' years') as Year_difference 
from empcpy e1 cross join empcpy e2 order by e2.birth_date;

