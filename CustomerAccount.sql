create database customers;
use customers;

create table customer(
    customer_id int auto_increment primary key,
    customer_name varchar(255),
    customer_street varchar(255),
    customer_city varchar(255)
);

create table account(
    account_number varchar(255) primary key,
    balance int
);


create table depositor(
    customer_id int,
    account_number varchar(255),
    FOREIGN KEY customer_id (customer_id)
    REFERENCES customer(customer_id),
    FOREIGN KEY account_number (account_number)
    REFERENCES account(account_number)
);

insert into customer(customer_name,customer_street,customer_city)
VALUES
('Johnson','12 Alma St.','Palo Alto'),
('Smith','4 North St.','Rye'),
('Hayes','3 Main St.','Harrison'),
('Turner','123 Putnam St.','Stanford'),
('Jones','100 Main St.','Harrison'),
('Lindsay','175 Park Ave.','Pittsfield'),
('Jane','72 North St.','Rye');

insert into account(account_number,balance)
VALUES
('A-101',500),
('A-215',700),
('A-102',400),
('A-305',350),
('A-201',900),
('A-217',750),
('A-222',700);


insert into depositor(customer_id,account_number)
VALUES
(1,'A-101'),
(1,'A-201'),
(2,'A-215'),
(3,'A-102'),
(4,'A-305'),
(5,'A-217'),
(6,'A-222'),
(7,'A-201');


show create table depositor;

alter table depositor
drop foreign key depositor_ibfk_1;

alter table depositor
add constraint name customer_id
foreign key (customer_id)
REFERENCES customer(customer_id);
