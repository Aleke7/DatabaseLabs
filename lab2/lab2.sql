CREATE DATABASE test1;

DROP DATABASE test;

CREATE TABLE customers(
    id int primary key,
    full_name varchar(50) NOT NULL,
    timestamp timestamp NOT NULL,
    delivery_address text NOT NULL
);

CREATE TABLE orders(
    code int primary key,
    customer_id int references customers,
    total_sum double precision NOT NULL CHECK ( total_sum > 0 ),
    is_paid boolean NOT NULL
);

CREATE TABLE products(
    id varchar primary key,
    name varchar NOT NULL UNIQUE,
    description text,
    price double precision NOT NULL CHECK ( price > 0 )
);

CREATE TABLE order_items(
    order_code int references orders,
    product_id varchar references products,
    quantity int NOT NULL CHECK ( quantity > 0 ),
    primary key (order_code, product_id)
);

CREATE TABLE students(
    full_name varchar(50) primary key,
    age int NOT NULL CHECK ( age >= 5 ),
    birth_date date NOT NULL,
    gender varchar(10) NOT NULL,
    average_grade numeric(3, 2) NOT NULL CHECK ( average_grade > 0 AND average_grade <= 4.00 ),
    personal_info text NOT NULL,
    dormitory_need boolean NOT NULL,
    extra_info text
);

CREATE TABLE instructors(
    full_name varchar(50) primary key,
    remote_lessons boolean NOT NULL
);

CREATE TABLE speaking_languages(
    instructor_name varchar(50) NOT NULL references instructors,
    language varchar NOT NULL,
    primary key (instructor_name, language)
);

CREATE TABLE work_experience(
    instructor_name varchar(50) NOT NULL references instructors,
    company_name varchar NOT NULL,
    primary key (instructor_name, company_name)
);

CREATE TABLE lesson_participants(
    lesson_title varchar(50),
    instructor_name varchar(50) references instructors,
    room_number int NOT NULL,
    primary key (lesson_title, instructor_name)
);

CREATE TABLE participating_student(
    full_name varchar(50) references students,
    participated_lesson varchar(50),
    instructor varchar(50),
    primary key (full_name, participated_lesson),
    foreign key (participated_lesson, instructor) references lesson_participants
);