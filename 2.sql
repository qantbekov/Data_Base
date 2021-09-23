create database Company;

create table customers(
    customer_id integer primary key ,
    full_name varchar(50) not null,
    timestamp timestamp not null,
    delivery_address text not null
);
create table products(
    product_id varchar primary key ,
    name varchar unique not null ,
    description text not null,
    price double precision not null check ( price > 0 )
);
create table orders(
    order_code integer,
    customer_id integer,
    total_sum double precision not null check ( total_sum > 0 ),
    is_paid boolean not null,
    primary key (order_code),
    foreign key (customer_id) references customers(customer_id)
);
create table order_items(
    order_code integer references orders(order_code),
    product_id varchar references products(product_id),
    quantity integer not null check ( quantity>0 ),
    constraint order_items_pkey primary key (order_code, product_id)
);
