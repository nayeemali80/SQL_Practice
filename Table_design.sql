create TABLE natural_key_example (
 license_id varchar(10) CONSTRAINT license_key PRIMARY KEY,
 first_name varchar(50),
 last_name varchar(50)
);

DROP TABLE natural_key_example;

CREATE TABLE natural_key_example (
 license_id varchar(10),
 first_name varchar(50),
 last_name varchar(50),
 CONSTRAINT license_key PRIMARY KEY (license_id)
);

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Sam', 'Tracy');

CREATE TABLE natural_key_composite_example (
 student_id varchar(10),
 school_day date,
 present boolean,
 CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/22/2017', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/23/2017', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '1/23/2017', 'N');

--Creating an Auto-Incrementing Surrogate Key

CREATE TABLE surrogate_key_example (
 order_number bigserial,
 product_name varchar(50),
 order_date date,
 CONSTRAINT order_key PRIMARY KEY (order_number)
);

INSERT INTO surrogate_key_example (product_name, order_date)
VALUES ('Beachball Polish', '2015-03-17'),
 ('Wrinkle De-Atomizer', '2017-05-22'),
 ('Flux Capacitor', '1985-10-26');


SELECT * FROM surrogate_key_example;

--Foreign Keys

create table licenses (
license_id varchar(20),
first_name varchar (20),
last_name varchar (20),
constraint licenses_key primary key (license_id)
);

create table registrations (
registration_id varchar(20),
registration_date date,
license_id varchar (20) references licenses(license_id),
constraint registration_key primary key(registration_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '3/17/2017', 'T229901');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '3/17/2017', 'T000001');

--Automatically Deleting Related Records with CASCADE

CREATE TABLE registrations (
 registration_id varchar(10),
 registration_date date,
 license_id varchar(10) REFERENCES licenses (license_id) ON DELETE CASCADE,
 CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);

create table constraint_check_example
(user_id bigserial,
user_role varchar(20),
salary integer,
constraint user_id_key primary key (user_id),
constraint check_user_role check (user_role in('Admin','Staff')),
constraint check_salry_not_zero check(salary>0)
);

select * from constraint_check_example;

create table unique_constraint_example (
Contact_id bigserial constraint contact_id_key primary key,
first_name varchar(20),
last_name varchar (20),
email varchar (20),
constraint unique_email_key unique(email)
);

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Samantha', 'hasan', 'samhasa@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('shobuj', 'hossen', 'bdiaz@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('fahad', 'babu', 'bdiaz@example.org');


--The NOT NULL Constraint

create table not_null_example (
student_id bigserial,
first_name varchar(50) not null,
last_name varchar(50) not null,
constraint student_id_key primary key(student_id)
);

--Removing Constraints or Adding Them Later

alter table not_null_example drop constraint student_id_key;
alter table not_null_example add constraint student_id_key primary key(student_id);
alter table not_null_example alter column first_name drop not null;
alter table not_null_example alter column first_name set not null;







