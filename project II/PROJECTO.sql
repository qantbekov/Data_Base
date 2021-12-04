CREATE TABLE customer (
customer_id int unique not null primary key ,
customer_fname VARCHAR(256) NOT NULL,
customer_lname VARCHAR(256) NOT NULL,
customer_email varchar(256) NOT NULL,
customer_number varchar(256) NOT NULL,
customer_address varchar(256) NOT NULL
);

CREATE TABLE  store (
store_id int unique NOT NULL primary key ,
store_name varchar(256),
store_address varchar(256) NOT NULL
);

CREATE TABLE product (
product_id int unique not null primary key,
manufacturer_id int references manufacturer(manu_id),
store_id int not null references store(store_id),
prov_id int not null references provider(prov_id),
product_name varchar(256),
product_brand varchar(256),
product_price INT,
sold_in_2019 int not null,
sold_in_2020 int not null,
sold_in_2021 int not null
);

CREATE TABLE manufacturer(
    manu_id int not null primary key,
    manu_name varchar(256),
    manu_adress varchar(256),
    manu_number varchar(256)
);

CREATE TABLE provider (
prov_id int not null primary key ,
prov_name varchar(256),
prov_number varchar(256)
);

CREATE TABLE delivery_service(
deliver_id int not null primary key ,
deliver_name varchar(256)
);

CREATE TABLE cars
(
    car_number          text primary key ,
    driver_name         varchar,
    driver_number       bigint,
    tracking_number     int not null unique ,
    delivery_company_id int not null references delivery_service (deliver_id)
);


CREATE TABLE  delivering_order (
package_id int unique not null primary key ,
date_ordered varchar(256),
date_delivered varchar(256),
delver_id int not null references delivery_service(deliver_id),
tracking_number int references cars(tracking_number),
product_id int not null references product(product_id),
customer_id int not null references customer(customer_id),
date_received varchar(256)
);


CREATE TABLE warehouse(
   product_id int references product(product_id),
   prov_id int references provider(prov_id),
   manu_id int references manufacturer(manu_id),
   number_bill_of_lading int not null,
   data_of_delivery date,
   price int not null ,
   quantity int not null ,
   available int not null
);

CREATE TABLE orders(
ord_id int not null primary key ,
customer_id int references customer(customer_id),
product_id int not null references product(product_id),
empl_id int references employees(empl_id),
date_of_order date,
quantity int not null ,
price_of_order int not null,
payment_in varchar
);

CREATE TABLE employees (
empl_id int unique not null primary key ,
empl_fname VARCHAR(256) NOT NULL,
empl_lname VARCHAR(256) NOT NULL,
store_id int not null
);

CREATE TABLE payment_methods (
card_id int unique not null primary key ,
card_number BIGINT,
card_data text,
CVV int,
customer_id int not null references customer(customer_id)
);

CREATE TABLE   transaction (
trans_id int unique not null,
customer_id int not null references  customer(customer_id),
store_id int not null references store(store_id),
card_id int not null references payment_methods(card_id)
);


INSERT INTO customer values
(1, 'Qantbek', 'ShynGyskhan', 'kantbekov_03@gmail.com', '+77078056022', 'Tole bi, 58'),
(2, 'Cristiano', 'Leo', 'cris77@gmail.com', '+77078054822', 'Turgut Ozal, 70'),
(3, 'Messi', 'Thiago', 'medsa@gmail.com', '+77017548560', 'Abay, 7'),
(4, 'Quanysh', 'Shonbay', 'shonbye@mail.ru', '+77777891954', 'Qazybek bi, 10');

INSERT INTO store values
(1, 'Sulpak', 'Rozybakieva 54');


INSERT INTO manufacturer values
(1, 'Samsung', 'Al-Fabi, 87', '+77785459545'),
(2, 'Iphone', 'Al-Fabi, 7', '+77717459845'),
(3, 'LG', 'Abay, 15', '+77714568749'),
(4, 'Sony', 'Ualihanov,44', '+77785459545');

INSERT INTO provider values
(7, 'Duman' , '+77477565148'),
(8, 'Shalqar' , '+77006514879'),
(9, 'Gulgaisha' , '+77078884565'),
(10, 'Dinara' , '+77077514877');

INSERT INTO product values
(78, 2, 1, 7, 'Iphone 13 Pro', 'Apple', 350000, 0, 0, 58),
(79, 1, 1, 8, 'Galaxy S21', 'Samsung', 310000, 0, 15, 45),
(80, 2, 1, 7, 'Iphone 12', 'Apple', 300000, 0, 44, 70),
(81, 3, 1, 9, 'LG SMART TV', 'LG', 400000, 15, 10, 8),
(82, 4, 1, 10, 'Playstation 5', 'Sony', 500000, 0, 0, 100),
(83, 1, 1, 8, 'Note 9', 'Samsung', 250000, 0, 45, 14),
(84, 4, 1, 10, 'PlayStation 4', 'Sony', 200000, 45, 58 ,58);

INSERT INTO employees values
(14, 'Kantbek', 'Maksat', 1),
(15, 'Abildaeva', 'Elmira', 1),
(16, 'Qojahmetova', 'Maira', 1);

INSERT INTO warehouse values
(78, 7, 2, 45, '2021-05-25',3500000,10, 8),
(79, 8, 1, 46, '2020-04-26',4650000,15, 10),
(80, 7, 2, 47, '2021-04-27',7500000,25, 7),
(81, 9, 3, 48, '2021-02-28',4400000,11, 9),
(82, 10, 4, 49, '2021-05-25',5000000,10, 8),
(83, 8, 1, 50, '2021-04-25',1250000,5, 3),
(84, 10, 4, 51, '2020-01-25',1600000,8, 7);

INSERT INTO delivery_service values
    (17, 'Kazpost'),
    (18, 'FedEx'),
    (19, 'NurDEL');

INSERT INTO cars values
('145wer13', 'MARAT', 77478741256, 54, 17),
('789dsa17', 'BARAT', 77078523698, 55, 19),
('541hfd05', 'SAMAT', 77012959201, 56, 18);

INSERT INTO orders values
(777, 1, 78, 14, '2021-04-12',1, 350000,'contract'),
(778, 2, 79, 15, '2021-04-14',2, 620000,'debit cards'),
(779, 3, 80, 14, '2021-04-16',1, 300000,'debit cards'),
(780, 3, 81, 16, '2021-05-01',3, 1200000,'contract'),
(781, 4, 82, 15, '2021-05-14',1, 500000,'debit cards');

INSERT INTO delivering_order values
(98,'2021-04-12','2021-04-13', 17, 54, 78, 2,'2021-04-13'),
(100, '2021-04-14', '2021-04-14', 19, 55, 79, 2,'2021-04-14'),
(101, '2021-04-16', '2021-04-17', 18, 56, 80, 3,'2021-04-18'),
(102, '2021-05-01', '2021-05-02', 18, 56, 81, 3,'2021-05-02'),
(103, '2021-05-14', '2021-05-16', 17, 54, 82, 4,'2021-05-17');

INSERT INTO payment_methods values
(465, 440040325845, '2324',998, 1),
(466, 440044841254,'0423',885, 2),
(467, 440071445845,'0522',554,3),
(469, 440074158441,'0325',118, 4);

INSERT INTO transaction values
(258, 1, 1, 465),
(259, 2, 1, 466),
(260, 3, 1, 467),
(261, 3, 1, 467),
(262, 4, 1, 469);

--------------------------------------------------
--1task
INSERT INTO delivery_service values (20, 'USPS');
INSERT INTO cars values ('874aax', 'BERIK', 77475412565, 123456, 20);
INSERT INTO orders values (770, 1, 78, 14, '2021-11-20',1, 350000,'contract');
INSERT INTO delivering_order values (555,'2021-11-20','yet not' , 20, 123456, 78, 1, 'yet not');
-----
select customer_id from delivering_order where tracking_number=123456;
select customer_fname,customer_lname,customer_number from customer;

select customer_fname,customer_lname,customer_number
from customer
left outer join  delivering_order id on customer.customer_id = id.customer_id;

--2task
((((((((
--3task






