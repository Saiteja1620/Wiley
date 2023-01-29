create database Academy;
use Academy;
create table Students(studentid int primary key, name varchar(255), address varchar(255), city varchar(255), nationality varchar(255) not null, age int);
select * from Students;
insert into Students values(1,'Saiteja','Ecil','Hyderabad','Indian',21);
drop table Students;

create table Courses(course_id int primary key, cname varchar(255), cduration int, cdescription varchar(255), cfee float not null);
select * from Courses;

insert into Courses values(1,'English', 12, 'Advanced', 1000);

create table Subscriptions(stud_id int, course_id int, foreign key(stud_id) references Students(studentid), foreign key(course_id) references Courses(course_id));
select * from Subscriptions;
insert into Subscriptions values(1,1);
insert into Subscriptions values(1,1);
rollback;