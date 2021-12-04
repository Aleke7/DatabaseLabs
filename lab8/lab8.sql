-- 1
-- a
CREATE FUNCTION incr(inout n int)
    AS $$
    BEGIN
        n = n + 1;
    END; $$
LANGUAGE plpgsql;

SELECT incr(5);

-- b
CREATE FUNCTION sum2(in a int, in b int, out sm int)
    AS $$
    BEGIN
        sm = a + b;
    END; $$
LANGUAGE plpgsql;

SELECT sum2(2, 3);

-- c
CREATE FUNCTION isdiv2(n int)
    RETURNS bool
    AS $$
    BEGIN
        if(n % 2 = 0) then return true;
        else return false;
        end if;
    END; $$
LANGUAGE plpgsql;

SELECT isdiv2(10);

-- d
CREATE FUNCTION check_password(s varchar)
    RETURNS bool
    AS $$
    BEGIN
        if(s SIMILAR TO '[A-Za-z0-9]+[\.]*[A-Za-z0-9]+' AND length(s) >= 8) then return true;
        else return false;
        end if;
    END; $$
LANGUAGE plpgsql;

SELECT check_password('abcd.1234')

-- e
CREATE FUNCTION func_e(in r numeric, out area numeric, out length numeric)
    AS $$
    BEGIN
        area = 3.14 * r * r;
        length = 2 * 3.14 * r;
    END; $$
LANGUAGE plpgsql;

-- 2
-- a
CREATE TABLE games(
    id SERIAL PRIMARY KEY ,
    title VARCHAR(50) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    changed timestamp
);

CREATE FUNCTION changes()
    RETURNS TRIGGER
    AS $$
    BEGIN
    new.changed= now();
    RETURN new;
    END; $$
LANGUAGE plpgsql;

CREATE TRIGGER game_changed
    BEFORE INSERT OR UPDATE on games
    FOR EACH ROW EXECUTE PROCEDURE changes();

INSERT INTO games(title, genre) values ('Warcraft', 'RPG');
INSERT INTO games(title, genre) values ('CSGO', 'FPS');
INSERT INTO games(title, genre) values ('Outlast', 'Horror');

SELECT * FROM games;

-- b
CREATE TABLE people(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birth_date date,
    age int
);

CREATE FUNCTION def_age()
    RETURNS TRIGGER
    AS $$
    BEGIN
        new.age = extract(year FROM current_date) - extract(year FROM new.birth_date);
        RETURN new;
    END; $$
LANGUAGE plpgsql;

CREATE TRIGGER comp_age
    BEFORE INSERT OR UPDATE on people
    FOR EACH ROW EXECUTE PROCEDURE def_age();

SELECT * FROM people;

INSERT INTO people(name, birth_date) VALUES ('Almat', '2002-03-23');
INSERT INTO people(name, birth_date) VALUES ('Manat', '1997-05-29');

-- c
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    initial_price NUMERIC,
    eventual_price NUMERIC
);

CREATE FUNCTION tax()
    RETURNS TRIGGER
    AS $$
    BEGIN
        new.eventual_price = new.initial_price * 1.12;
        RETURN new;
    END; $$
LANGUAGE plpgsql;

CREATE TRIGGER final_price
    BEFORE INSERT OR UPDATE on products
    FOR EACH ROW EXECUTE PROCEDURE tax();

INSERT INTO products(name, initial_price) VALUES ('ASUS TUF', 1000);
INSERT INTO products(name, initial_price) VALUES ('Macbook', 2500);
INSERT INTO products(name, initial_price) VALUES ('Lenovo Thinkbook', 600);

SELECT * FROM products;

-- d
CREATE FUNCTION proh_del()
    RETURNS TRIGGER
    AS $$
    BEGIN
        RAISE EXCEPTION 'You are unable to delete data from this table';
    END; $$
LANGUAGE plpgsql;

CREATE TRIGGER no_del
    BEFORE DELETE on products
    FOR EACH ROW EXECUTE PROCEDURE proh_del();

DELETE FROM products
WHERE id = 1;

-- e
CREATE TABLE passwords_val(
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    isval bool
);
CREATE FUNCTION check_passwords()
    RETURNS TRIGGER
    AS $$
    BEGIN
        if(new.password SIMILAR TO '[A-Za-z0-9]+[\.]*[A-Za-z0-9]+' AND length(new.password) >= 8) then new.isval = true;
        else return new.isval = false;
        end if;
        RETURN new;
    END; $$
LANGUAGE plpgsql;

CREATE TRIGGER password_trigger
    BEFORE INSERT OR UPDATE on passwords_val
    FOR EACH ROW EXECUTE PROCEDURE check_passwords();

INSERT INTO passwords_val(user_name, password) VALUES ('user1', '12345abcd');
SELECT * FROM passwords_val;

-- 3
-- Procedure
-- Procedures will not return the value
-- Procedures always executes as PL SQL statement
-- It does not contain return clause in header section
-- We can pass the values using IN OUT IN OUT parameters
-- Procedures can not be executed in Select statement
-- Procedures cannot be called from a Function

-- Function
-- Functions must return the value. When you are writing functions make sure that you can write the return statement
-- Functions executes as part of expression
-- It must contain return clause in header
-- Function must return a single value
-- Functions can execute or call using select statement but it must not contain Out or IN OUT parameters
-- Functions can be called from Procedure

-- 4
CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    date_of_birth date,
    age int,
    salary int,
    work_exp int,
    discount numeric
);

INSERT INTO employees(name, date_of_birth, age, salary, work_exp, discount) VALUES ('Michael', '1987-07-09' , 34, 2000, 9, 0);
INSERT INTO employees(name, date_of_birth, age, salary, work_exp, discount) VALUES ('Alex', '1989-07-09' , 32, 1700, 7, 1);

-- a
CREATE PROCEDURE incr1()
      AS $$
      BEGIN
          UPDATE employees SET salary = salary * 1.1
            WHERE work_exp >= 2;
          UPDATE employees SET discount = discount * 1.1
            WHERE work_exp >= 2;
          UPDATE employees SET discount = discount * 1.01
            WHERE work_exp >= 5;
      END; $$
LANGUAGE plpgsql;

call incr1();

SELECT * FROM employees;

-- b
CREATE PROCEDURE incr2()
      AS $$
      BEGIN
          UPDATE employees SET salary = salary * 1.15
            WHERE age >= 40;
          UPDATE employees SET salary = salary * 1.15
            WHERE work_exp >= 8;
          UPDATE employees SET discount = discount * 1.20
            WHERE work_exp >= 8;
      END; $$
LANGUAGE plpgsql;

call incr2();

SELECT * FROM employees;

-- 5
CREATE TABLE members(
    memid int,
    surname VARCHAR(200),
    firstname VARCHAR(200),
    address VARCHAR(300),
    zipcode int,
    telephone VARCHAR(20),
    recommendedby int,
    joindate timestamp
);

CREATE TABLE bookings(
    facid int,
    memid int,
    starttime timestamp,
    slots int
);

CREATE TABLE facilities(
    facid int,
    name VARCHAR(100),
    membercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric
);

INSERT INTO members(memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) VALUES
(0, 'Luke', 'Brown', '2696 Stonepot Road', '90210', '123-123', NULL, '2008-01-31'),
(1, 'Penny', 'Davis', '983 Church Street', '78234', '718-455', NULL, '2021-08-20'),
(2, 'Karen', 'McCall','1305 Raver Croft Drive', '34589', '765-789', '1', '2021-10-04'),
(3, 'Levi', 'Miller', '4456 Vineyard Drive', '23098', '084-465', NULL,'2021-12-07'),
(4, 'Daisy', 'Stewart', '2710 Farland Street', '09823', '773-924', '2', '2021-12-08'),
(5, 'Brandon', 'Mitchell', '5017 Burnside Avenue', '34512', '435-631', '2', '2021-12-21'),
(6, 'Valerie', 'Smith', '5018 Burnside Avenue','67432', '435-690', NULL, '2021-11-29' ),
(7, 'Melanie', 'Powell', '4036 Edsel Road', '90211', '267-480', '1', '2021-12-06'),
(8, 'Sonya', 'Baker', '940 Irish Lane', '90220', '234-900', '3', '2021-09-10'),
(9, 'Richard', 'Bell', '4701 Laurel Lane', '90230', '901-902', '1', '2021-09-08'),
(10, 'Mike', 'Power', '1879 August Lane', '90100', '318-376', NULL, '2021-07-26'),
(11, 'Chester', 'Woodbury', '2821 Trouser Leg Road', '09834', '245-098', NULL, '2021-07-20'),
(12, 'Bruce', 'Johnson', '3124 Valley View Drive', '87600', '617-744', '1', '2021-08-06'),
(13, 'Karen', 'Duffy', '335 Webster Street', '09867', '345-009', '2', '2021-09-14'),
(14, 'Jonathan', 'Gay', '3427 Finwood Road', '90434', '732-514', '3', '2021-09-27'),
(15, 'Kenneth', 'Duffy', '3376 Willow Greene Drive', '90834', '334-303', NULL, '2021-10-20'),
(16, 'Heather', 'Pauli', '1533 Drummond Street', '98710', '973-226', '2', '2021-12-21'),
(17, 'Kristie', 'McCombs', '3310 Palmer Road', '00000', '972-225', '1', '2021-12-06'),
(18, 'Kenneth', 'Jhonsen', '504 Thorn Street', '09834', '307-567', NULL, '2021-12-21'),
(19, 'Scott', 'Upton', '711 Hamill Avenue', '09800', '317-565','1', '2021-08-19'),
(20, 'Karen', 'Lowa', '100 Stratford Court', '09812', '345-098', '4', '2021-10-12'),
(21, 'Constance', 'Morris', '4594 Lightning Point Drive', '02345', NULL, '3', '2021-10-20'),
(22, 'Edward', 'Cooper', '4529 Callison Lane', '45601', '445-001', '2', '2021-09-07');

WITH RECURSIVE recommenders(recommender, member) AS
    (SELECT recommendedby, memid FROM members UNION ALL
    SELECT m.recommendedby, r.member FROM recommenders r INNER JOIN members m on m.memid = r.recommender)
SELECT r.member, r.recommender, m.firstname, m.surname FROM recommenders r INNER JOIN members m on r.recommender = m.memid
    WHERE r.member in (12, 22)
    ORDER BY r.member ASC, r.recommender DESC;