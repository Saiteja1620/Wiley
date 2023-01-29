use employees;
show tables;
-- creating a table
create table saiteja(id int);

-- dropping a table
drop table saiteja;

-- adding column
alter table tejasai add address varchar(255);

-- renaming a table
rename table saiteja to tejasai;

-- truncating a table i.e. removing all the records but schema exists
truncate table tejasai;

-- changing datatype using modify
alter table tejasai modify nme integer;

-- changing column name and datatype using change
alter table tejasai change nme name varchar(255);

-- dropping a column
alter table tejasai drop name;


-- check constraint
alter table tejasai add constraint check_constriant check(length(name)>8);
alter table tejasai add constraint not_null primary key (id);
desc tejasai;


-- dropping a constraint
alter table tejasai drop primary key;


create table teja(id int);
alter table teja add foreign key (id) references tejasai(id);

-- adding foreign key
ALTER TABLE teja ADD CONSTRAINT F_K FOREIGN KEY (id) REFERENCES tejasai(id);
alter table teja add constraint foreign key (id) references tejasai(id);

-- dropping a foreign key
alter table teja drop constraint F_K;
alter table teja drop foreign key F_K;


desc teja;
rollback;
set @@autocommit=0;



