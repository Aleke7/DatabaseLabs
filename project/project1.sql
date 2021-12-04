CREATE TABLE orders(
    order_id int PRIMARY KEY,
    company_id int references company(company_id),
    order_date date NOT NULL
);

CREATE TABLE company(
    company_id int PRIMARY KEY,
    company_name VARCHAR NOT NULL
);

CREATE TABLE customer(
    customer_id int PRIMARY KEY,
    customer_name VARCHAR NOT NULL,
    order_id int references orders(order_id),
    customer_address VARCHAR NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE payment(
    payment_id int PRIMARY KEY,
    method VARCHAR NOT NULL,
    customer_id int references customer(customer_id),
    price numeric NOT NULL,
    payment_date date NOT NULL,
    payment_status bool NOT NULL,
    return_money bool NOT NULL
);



CREATE TABLE status(
    status_id int PRIMARY KEY,
    order_id int references orders(order_id),
    waiting_conf bool NOT NULL,
    on_process bool NOT NULL,
    on_delivery bool NOT NULL,
    delivered bool NOT NULL
);

CREATE TABLE shipment(
    shipment_id int PRIMARY KEY,
    tracking_id int references tracking(tracking_id),
    package_id int references package(package_id)
);

CREATE TABLE package(
    package_id int PRIMARY KEY,
    order_id int references orders(order_id),
    shipper_id int references shipper(shipper_id),
    hazard_level int NOT NULL,
    type VARCHAR(20)
);

CREATE TABLE shipper(
    shipper_id int PRIMARY KEY,
    shipper_name VARCHAR NOT NULL
);

CREATE TABLE location(
    location_id int PRIMARY KEY,
    order_id int references orders(order_id),
    country VARCHAR NOT NULL,
    city VARCHAR NOT NULL
);

CREATE TABLE tracking(
    tracking_id int PRIMARY KEY,
    warehouse_id int references warehouse(warehouse_id),
    plane_id int references plane(plane_id),
    truck_id int references truck(truck_id),
    location_id int references location(location_id),
    cur_date date
);

CREATE TABLE plane(
    plane_id int PRIMARY KEY,
    flight_id int NOT NULL
);

CREATE TABLE truck(
    truck_id int PRIMARY KEY,
    licence_id int NOT NULL
);

CREATE TABLE warehouse(
    warehouse_id int PRIMARY KEY,
    capacity int NOT NULL
);

CREATE TABLE monthly(
    account_number int PRIMARY KEY,
    payment_id int references payment(payment_id),
    month_payment numeric NOT NULL,
    is_paid bool NOT NULL
);

CREATE TABLE credit_card(
    card_id int PRIMARY KEY,
    payment_id int references payment(payment_id),
    holder_name VARCHAR NOT NULL,
    exp_date date NOT NULL,
    cvv VARCHAR(3) NOT NULL
);

CREATE TABLE declaration(
    declaration_id int PRIMARY KEY,
    shipment_id int references shipment(shipment_id),
    shipper_id int references shipper(shipper_id)
);


insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (1,'Bekarys B.', 1,'Kazakhstan Almaty', '+77771234567', 'beka@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (2,'Aslan K.', 16,'Kazakhstan Kokshetau', '+7701459863', 'aslk@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (4,'Alikhan S.', 28,'Kazakhstan Pavlodar', '+77051985638', 'alikhsh@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (6,'Samrat A.', 47,'Kazakhstan Kostanay', '+77774298556', 'askarovs@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (7,'Shahriyor', 18,'Tajikistan Dushanbe', '+9927012364896', 'shakh@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (8,'Alisher T.', 15,'Kazakhstan Astana', '+77774529867', 'tilusher@mail.ru');
insert into customer(customer_id, customer_name, order_id, customer_address, phone_number, email) values (10,'Almat B.', 17,'Kazakhstan Kostanay', '+77775817773', 'almat215@mail.ru');

insert into company(company_id, company_name) values(103,'Delivery express');
insert into company(company_id, company_name) values(105,'Kratos');
insert into company(company_id, company_name) values(89,'Goblin');
insert into company(company_id, company_name) values(13,'Octadel');

insert into package(package_id, order_id, shipper_id, hazard_level, type) values (16, 1, 23, 2, 'small pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (12, 16, 15, 4, 'small pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (2, 28, 15, 6, 'big pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (56,47, 63, 3, 'flat pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (100,18, 14, 5, 'big pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (152, 15, 15, 3,'flat pack');
insert into package(package_id, order_id, shipper_id, hazard_level, type) values (31, 17, 14, 4,'small box');

insert into shipper(shipper_id, shipper_name) values (23, 'Alexander');
insert into shipper(shipper_id, shipper_name) values (15, 'Michael');
insert into shipper(shipper_id, shipper_name) values (63, 'Ugene');
insert into shipper(shipper_id, shipper_name) values (14, 'Euclid');

insert into orders(order_id, company_id, order_date) values (1, 103, '2021-05-17');
insert into orders(order_id, company_id, order_date) values (16, 105, '2021-06-23');
insert into orders(order_id, company_id, order_date) values (28, 105, '2021-02-06');
insert into orders(order_id, company_id, order_date) values (47, 103, '2021-10-12');
insert into orders(order_id, company_id, order_date) values (18, 89, '2021-03-08');
insert into orders(order_id, company_id, order_date) values (15, 13, '2021-07-15');
insert into orders(order_id, company_id, order_date) values (17, 103, '2021-05-08');

insert into location(location_id, order_id, country, city) values (27, 1, 'USA', 'New York');
insert into location(location_id, order_id, country, city) values (25, 16, 'India', 'New Deli');
insert into location(location_id, order_id, country, city) values (14, 28, 'Marocco', 'Rabat');
insert into location(location_id, order_id, country, city) values (36, 47, 'UAE', 'Abu Dabi');
insert into location(location_id, order_id, country, city) values (96, 18, 'Turkey', 'Ankara');
insert into location(location_id, order_id, country, city) values (12, 15, 'China', 'Pekin');
insert into location(location_id, order_id, country, city) values (34, 17, 'China', 'Uhan');

insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (1, 1, 1, 1, 27, '2021-05-26');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (2, 2, 2, 2, 25, '2021-07-01');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (3, 3, 3, 3, 14, '2021-02-17');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (4, 4, 4, 1, 36, '2021-10-27');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (5, 5, 5, 1, 96, '2021-03-19');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (6, 5, 6, 4, 12, '2021-07-30');
insert into tracking(tracking_id, warehouse_id, plane_id, truck_id, location_id, cur_date) values (7, 5, 7, 4, 34, '2021-05-24');

insert into warehouse(warehouse_id, capacity) values (1, 2000);
insert into warehouse(warehouse_id, capacity) values (2, 2200);
insert into warehouse(warehouse_id, capacity) values (3, 3000);
insert into warehouse(warehouse_id, capacity) values (4, 2700);
insert into warehouse(warehouse_id, capacity) values (5, 2000);

insert into truck(truck_id, licence_id) values (1, 1);
insert into truck(truck_id, licence_id) values (2, 2);
insert into truck(truck_id, licence_id) values (3, 3);
insert into truck(truck_id, licence_id) values (4, 4);
insert into truck(truck_id, licence_id) values (5, 5);
insert into truck(truck_id, licence_id) values (6, 6);
insert into truck(truck_id, licence_id) values (7, 7);

insert into plane(plane_id, flight_id) values (1, 223);
insert into plane(plane_id, flight_id) values (2, 4879);
insert into plane(plane_id, flight_id) values (3, 456);
insert into plane(plane_id, flight_id) values (4, 135);
insert into plane(plane_id, flight_id) values (5, 7474);
insert into plane(plane_id, flight_id) values (6, 424);
insert into plane(plane_id, flight_id) values (7, 753);

insert into shipment(shipment_id, tracking_id, package_id) values (1, 1, 16);
insert into shipment(shipment_id, tracking_id, package_id) values (2, 2, 12);
insert into shipment(shipment_id, tracking_id, package_id) values (3, 3, 2);
insert into shipment(shipment_id, tracking_id, package_id) values (4, 4, 56);
insert into shipment(shipment_id, tracking_id, package_id) values (5, 5, 100);
insert into shipment(shipment_id, tracking_id, package_id) values (6, 6, 152);
insert into shipment(shipment_id, tracking_id, package_id) values (7, 7, 31);

insert into declaration(declaration_id, shipment_id, shipper_id) values (1, 1, 23);
insert into declaration(declaration_id, shipment_id, shipper_id) values (2, 2, 23);
insert into declaration(declaration_id, shipment_id, shipper_id) values (3, 3, 15);
insert into declaration(declaration_id, shipment_id, shipper_id) values (4, 4, 63);
insert into declaration(declaration_id, shipment_id, shipper_id) values (5, 5, 14);
insert into declaration(declaration_id, shipment_id, shipper_id) values (6, 6, 14);
insert into declaration(declaration_id, shipment_id, shipper_id) values (7, 7, 15);

insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (1, 'monthly', 1, 500, '2021-05-26', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (2, 'card', 2, 1200, '2021-07-01', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (3, 'monthly', 4, 1600, '2021-02-17', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (4, 'monthly', 6, 700, '2021-10-27', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (5, 'card', 7, 200, '2021-03-19', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (6, 'card', 8, 900, '2021-07-30', false, false);
insert into payment(payment_id, method, customer_id, price, payment_date, payment_status, return_money) values (7, 'monthly', 10, 100, '2021-05-24', false, false);

SELECT c.customer_id, c.customer_name, count(p.package_id) cnt
FROM package p INNER JOIN orders o on p.order_id = o.order_id INNER JOIN customer c on o.order_id = c.order_id
GROUP BY customer_id ORDER BY cnt DESC LIMIT 1;

SELECT c.customer_id ,c.customer_name, sum(p.price) total FROM payment p INNER JOIN  customer c on p.customer_id = c.customer_id
GROUP BY c.customer_id ORDER BY total DESC LIMIT 1;

SELECT c.customer_address, count(c.customer_id) cnt FROM customer c
GROUP BY c.customer_address ORDER BY cnt DESC LIMIT 1;

