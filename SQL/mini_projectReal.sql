create database project;

use project;

create table Organizer(
	org_id int primary key auto_increment,
    org_name varchar(200),
    email_id varchar(200),
    org_password varchar(200) check(length(org_password) >= 8),
    phone_number varchar(200) unique not null
);
select * from organiZer;
create table participant(
	p_id int primary key auto_increment,
    p_name varchar(200),
    p_email_id varchar(200),
    p_password varchar(200) check(length(p_password) >=8),
    p_phone_number varchar(200) unique not null
);

create table Events(
	event_id int auto_increment primary key,
    org_id int,
    event_name varchar(200),
    event_desc varchar(500),
    event_venue varchar(200),
    event_date_time varchar(50),
    participant_limit int,
    event_category varchar(200),
    event_status int default 0,
    foreign key(org_id) references Organizer(org_id)
    
);
use project;
select * from Events;

create table event_participant(
	evp_id int primary key auto_increment,
    p_id int,
    event_id int,
    
    foreign key(p_id) references participant(p_id),
    foreign key(event_id) references Events(event_id)
);


create table sponsors(
	s_id int primary key auto_increment,
    sname varchar(200),
    s_email varchar(200) unique not null,
    s_password varchar(200) check (length(s_password)>=8),
    s_phonenumber varchar(200) unique not null
);

create table event_sponsorship(
	eventid int,
    sid int,
    sponsor_amount float,
    
    foreign key(eventid) references Events(event_id),
    foreign key(sid) references sponsors(s_id)
);


select current_timestamp();
use project;
select *from Organizer;
select *from participant;
select *from sponsors;
select *from Events;
select *from event_sponsorship;
select *from event_participant;
alter table event_participant add column approval boolean default 0;
update events set event_status=1 where event_name="new";
show tables;
alter table event_sponsorship rename column approval_needed to approval;
alter table event_sponsorship add column approval_needed boolean default 0;
select * from events where id in (select event_id from event_participant where p_id=1);