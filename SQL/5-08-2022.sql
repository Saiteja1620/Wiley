create database friday;
use friday;
create table Employees(
	EmployeeId int primary key,
    empName varchar(255),
    reportsTo int
);
select * from employees;
insert Employees values
(1,'nicklaus',null),
(2,'windy',1),
(3,'ormanta',1),
(4,'johnseto',2),
(5,'maria',2),
(6,'david',5);
alter table Employees add foreign key (reportsTo) references Employees(EmployeeId);
desc employees;

select e1.EmployeeId,e1.empName,e2.empName from employees e1 left join employees e2 on e1.reportsTo=e2.employeeId;
use imdb;
show tables;
select * from director_mapping;
select count(*) from director_mapping;
select * from genre;
select count(*) from genre;
select * from movie;
select count(*) from movie;
select * from names;
select count(*) from names;
select * from ratings;
select count(*) from ratings;
select * from role_mapping;
select count(*) from role_mapping;

-- 1
select table_name,table_rows from information_schema.tables where table_schema="imdb" ;

-- 2
select count(*) from movie where id is NULL;
select count(*) from movie where title is NULL;
select count(*) from movie where year is null;
select count(*) from movie where date_published is null;
select count(*) from movie where duration is null;
select count(*) from movie where worlwide_gross_income is null;
select count(*) from movie where languages is null;
select count(*) from movie where production_company is null;

-- 3
select year as Year,count(year) as number_of_movies from movie group by Year; 

-- 3-2
select month(date_published) as month_number, count(month(date_published)) number_of_movies from movie group by month_number
 order by month_number;
 
-- 4
select count(*) as number_of_movies from movie where country in ("India","USA") and year=2019;


-- 5 SAI TEJA
select distinct(genre) from genre;

select * from movie;
select * from genre;


select * from movie;

-- 6 SAI TEJA
select genre from genre g join movie m on m.id=g.movie_id group by genre order by count(genre) desc limit 1;

-- 7 SAI TEJA
select count(id) number_of_movies from movie where id in 
( select movie_id from movie,genre where id=movie_id group by movie_id having count(*)=1);


-- 8 SAI TEJA
select genre, avg(duration) from genre g join movie m on m.id=g.movie_id group by genre;

-- 9 SAI TEJA
select * from (select genre, count(movie_id) as number_of_movies, rank() over(order by count(movie_id) desc) as genre_rank from genre g  
join movie m on g.movie_id=m.id group by genre) g where g.genre="Thriller";


-- 10 SAI TEJA
select min(avg_rating) min_avg_rating, max(avg_rating) max_avg_rating, min(total_votes) min_total_votes, max(total_votes) max_total_votes,
min(median_rating) min_median_rating, max(median_rating) max_median_rating from ratings; 


-- 11 SAI TEJA
select m.title,r.avg_rating,g.genre from movie m join genre g on g.movie_id=m.id join ratings r on r.movie_id=g.movie_id where m.title 
like 'The%' and r.avg_rating>8;


-- 12 SAI TEJA
select count(*) from movie m join ratings r on r.movie_id=m.id where date_published
 between "2018-04-01" and "2019-04-01" and r.median_rating=8;
 
 -- 13 SAI TEJA
 select m.country, sum(r.total_votes) from movie m join ratings r on r.movie_id=m.id 
 where m.country in ("Italy","Germany") group by m.country;
 
-- 14 SAI TEJA
select count(*)-count(name) as name_nulls,count(*)-count(height) height_nulls,count(*)-count(date_of_birth) 
date_of_birth_nulls,count(*)-count(known_for_movies) known_for_movies_nulls from names;

select n.name,count(rm.movie_id) as movie_count from role_mapping rm,names n, ratings r where rm.name_id=n.id and 
rm.movie_id=r.movie_id and r.median_rating>=8 and rm.category='actor' group by rm.name_id order by movie_count desc limit 2;

-- 16 SAI TEJA
select n.name,count(rm.movie_id) as movie_count from role_mapping rm join names n on rm.name_id=n.id join
ratings r on r.movie_id=rm.movie_id where r.median_rating>=8 and rm.category="actor" group by rm.name_id order by movie_count desc limit 2;


-- 15 SAI TEJA
select * from names;

select * from director_mapping;
select n.name,d.name_id,g.genre, count(g.movie_id) as cnt from genre g join ratings r on r.movie_id=g.movie_id join director_mapping d on d.movie_id=g.movie_id join names n on n.id=d.name_id group by genre order by cnt desc;

select n.name,count(d.movie_id) as 'movie_count' from names n 
join director_mapping d on d.name_id=n.id
join ratings r on d.movie_id=r.movie_id
join genre g on g.movie_id=d.movie_id
where g.genre in ('drama','thriller','comedy')
group by d.name_id having avg(r.avg_rating)>8 order by movie_count desc limit 3;




