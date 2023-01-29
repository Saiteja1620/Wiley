create database transactiondb;
use transactiondb;
create table accounts(accountHolder varchar(255), accBalance int);
insert accounts values('vishal',1000),('shiny',2000);
select * from accounts;

start transaction;
update accounts set accBalance=accBalance-100 where accountHolder='vishal';
update accounts set accBalance=accBalance+100 where accountHolder='shiny';
commit;

start transaction;
update accounts set accBalance=accBalance-100 where accountHolder='vishal';
update accounts1 set accBalance=accBalance+100 where accountHolder='shiny';
commit;

select * from accounts;
select @@autocommit;

select * from accounts;
set @@autocommit=0;

select @@autocommit;


update accounts set accBalance=accBalance-100 where accountHolder='vishal';
update accounts set accBalance=accBalance+100 where accountHolder='shiny';
rollback;

select * from accounts;

update accounts set accBalance=accBalance-100 where accountHolder='vishal';
update accounts set accBalance=accBalance+100 where accountHolder='shiny';

commit;

select * from accounts;
update accounts set accBalance=accBalance+1000 where accountHolder in ('vishal','shiny');

insert accounts values('sai',10000);
commit;

delete from accounts;