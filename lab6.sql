create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Максат', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Елмира', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Шынгысхан', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Назерке', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Балнур', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Асылжан', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Зангар', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Бекжан', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Майра', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Бекзат', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Ерзат', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Шолпан', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Канат', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Шугыла', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

--1.Write a SQL query using Joins:
select * from dealer natural full outer join client;
select * from dealer inner join client on dealer.id = client.dealer_id;
select * from dealer d inner join client c on d.id = c.dealer_id and d.location=c.city;
select sell.id,amount,name,city from sell inner join client c on c.id = sell.client_id and sell.amount>=100 and sell.amount<=500;
select * from dealer natural left join client;
select c.name,c.city,dealer.name,charge from dealer inner join client c on dealer.id = c.dealer_id;
select c.name,city,d.name,charge from dealer d inner join client c on d.id = c.dealer_id INNER JOIN  sell on c.id=sell.client_id and d.id=sell.dealer_id and d.charge>0.12;
select c.name,city,s.id,s.date,d.name,d.charge from client c left Join dealer d on d.id = c.dealer_id left join sell s on c.id = s.client_id;
select dealer.id,dealer.name,count(*) as times from dealer inner join client c on dealer.id = c.dealer_id group by dealer.id having count(*)>0;

--2.Create following views:
create view ss as select count(distinct client_id),avg(amount),sum(amount) as total,date from sell group by date;
select * from ss;

create view vg as select date,total from vs order by total desc LIMIT 5;
select * from vg;

create view ds as select dealer_id,count(*), avg(amount),sum(amount) as total from sell group by dealer_id;
select * from ds;

create view vt as select location,sum(amount*charge) as total from dealer inner join sell on dealer.id = sell.dealer_id group by location;
select * from vt;

create view tt as select location,count(*) as times,avg(amount),sum(amount) as total from dealer inner join sell s on dealer.id = s.dealer_id group by location;
select * from tt;

create view ct as select city,count(*) as times,avg(amount),sum(amount) as total from client inner join sell s on client.id = s.client_id group by city;
select * from ct;

create view dv as select distinct city from ct inner join tt on ct.total>tt.total;
select * from dv;
