create database university_db;

create table KBTU
(
    id char(10) primary key,
    name varchar(20),
    dept_name varchar(20),
    salary numeric(8,2) check(salary > 0)
);

alter database university_db rename to KBTU_DB;

drop database KBTU_DB;