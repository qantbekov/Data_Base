create database university_db;

create table students(
    id char(10) primary key ,
    name varchar(20),
    birthday date,
    GPA numeric(2,1) default 3.0
);

insert into students values('20B030235', 'SHYNGYSKHAN', '29.07.2003', 3.5);

insert into students(id, name, birthday, GPA) values('20B030235', 'SHYNGYSKHAN', '29.07.2003', 3.5);

update students set GPA = 2.9 where GPA = 3.5;
update students set GPA = 2.8;

delete from students where GPA > 2.0;