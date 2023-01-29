use shivam;
drop table persons;
create table persons(id int, weight int, day_time datetime);
insert into persons values(3,52,concat('2022-09-07',' ',time(now())));
select * from persons order by id;
insert into persons values(2,86,now());
insert into persons values(3,64,now());
select * from persons order by id, day_time;
select *  from persons order by id,day_time,weight;
select * from (select id from persons group by id) a;

with temp as
(
select *,row_number() over(partition by id) as rowNumber from persons
)
select id from temp;


select *,row_number() over(partition by id order by day_time)  as rowNumber from persons;

select * from persons p1 inner join persons p2 on p1.id=p2.id having min(p1.day_time)< max(p2.day_time) and p1.weight>p2.weight;
select * from persons p1 inner join persons p2 on p1.id=p2.id order by p1.id;
select * from persons order by id;

select date_add(now(),interval 1 minute);
select extract(minute from now());
select day(now());
select month(now());
select monthname(now());
select dayname(now());
select year(now());
select second(now());
select current_date;
select current_date();
select curdate();
select datediff(now(),now()) as date_diff;



-- string functions
select replace('hello world','hello','helo');

select now()+1;
select now();