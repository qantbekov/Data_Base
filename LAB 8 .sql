--TASK-1
--a
create function inc(val integer) returns integer
    language plpgsql
as
$$
BEGIN RETURN val + 1;
END;
$$;

select inc(58)

--b

create function sum(val integer,val2 integer) returns int
    language plpgsql
as
$$
BEGIN RETURN val + val2; END;
$$;

SELECT sum(50,55)

--c

create function check_divis(num numeric) returns BOOLEAN
    language plpgsql
as
$$
BEGIN
    IF (num%2=0)
        then return true;
    else
        return false;
     END IF;
END;
$$;

select check_divis(4)
select check_divis(5)

--d

create function check_pass(pass text) returns BOOLEAN
    language plpgsql
as
$$
BEGIN
    IF (length(pass) > 10)
        then return true;
    else
        return false;
     END IF;
END;
$$;

select check_pass('81820306Ff!')
select check_pass('81820306Ff')

--e
create or replace function in_out(kilometr integer,out metr integer, out santimetr integer)
     as $$
     begin
     metr := kilometr * 1000;
     santimetr := kilometr * 100000;
     end;$$
     language plpgsql;
select * from in_out(4);


--task 2
--a
create table movie(
    id serial primary key,
    title varchar(50) not null,
    changed timestamp
);

insert into movie(title) values('5:32');
insert into movie(title) values('Sheker');
insert into movie(title) values('Serzhan Bratan');

create or replace function changing() returns trigger as $$
begin
    new.changed = now();
    return new;
end;
$$ language plpgsql;

create trigger movie_changed before insert or update on movie
    for each row execute procedure changing();

select * from movie

insert into movie(title)  values ('$ake');

--b
create table person(
    id int generated always as identity primary key,
    name varchar(20),
    age integer,
    year_of_birth integer not null
);
create or replace function age_calculate()
    returns trigger
    language plpgsql
    as
$$
    begin
        new.age = extract(year from current_date) - new.year_of_birth;
        return new;
    end;
$$;
create trigger age1 before insert or update on person
    for each row execute procedure age_calculate();


insert into person(name, year_of_birth) values ('Cristiano', 1985);
insert into person(name, year_of_birth) values ('Leo', 1987);
insert into person(name, year_of_birth) values ('Haaland', 2000);
insert into person(name, year_of_birth) values ('Mbappe', 1998);

select * from person

-- c
CREATE table product(
    id int primary key,
    name varchar(80),
    price integer
);

create or replace FUNCTION total()
returns trigger
    language plpgsql
    as

    $$
        BEGIN
            update product
            set price=0.12*price+price;
            where id = new.id;
            return new;
        end;
    $$;


create trigger cost after insert on product
    for each row execute procedure total();

select * from product;

insert into product(id, name, price) values (4894984,'Cola', 350);
insert into product(id, name, price) values (4891474,'Sprite',300);
insert into product(id, name, price) values (7894914,'Red Bull', 500);

-- d
create or replace function reset() returns trigger language plpgsql
    as $$
    begin
        insert into product(id,name,price) values(old.id,old.name,old.price);
        return old;
    end;
    $$;

create trigger back7
    after delete
    on product
    for each row
    execute procedure reset();

delete from product where id=2;
select * from product;


--TASK 4
--a

create table empl(
    id integer primary key ,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
);

insert into empl values (5,'MARAT','12-05-1997',24,45000,1,6000);
insert into empl values (6,'BARAT','10-04-1985',36,75000,3,7000);
insert into empl values (7,'SAMAT','11-05-1967',54,100000,10,15000);
insert into empl values (8,'QANAT','01-06-1991',29,30000,4,4000);

create or replace procedure increase()
      as $$
      begin
            update empl set salary = ( workexperience/2)*0.1*salary+salary;
            update empl set discount = ( workexperience/2)*0.1*empl.discount + empl.discount;
            update empl set discount = ( workexperience/5)*0.01 * empl.discount + empl.discount;
        commit;
      end; $$
      language plpgsql;
call increase();
select * from empl;

--b
create or replace procedure increase2()
      as $$
      begin
          update empl set salary = salary*1.15 where age>=40;
          update empl set salary = salary*1.15 where workexperience>=8;
          update empl set discount = discount*1.20  where workexperience>=8;
      end; $$
      language plpgsql;
call increase2();

call increase2();
select * from empl;

-- task 5
create table members(
    memid integer,
    surname varchar(200),
    firstname varchar(200),
    address varchar(300),
    zipcode integer,
    telephone varchar(20),
    recommendedby integer,
    joindate timestamp
);
create table bookings(
    facid integer,
    memid integer,
    starttime timestamp,
    slots integer
);
create table facilities(
    facid integer,
    name varchar(200),
    membercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric
);
