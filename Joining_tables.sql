CREATE TABLE departments (
dept_id bigserial,
dept varchar(100),
city varchar(100),
CONSTRAINT dept_key PRIMARY KEY (dept_id),
CONSTRAINT  dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
 emp_id bigserial,
 first_name varchar(100),
 last_name varchar(100),
 salary integer,
 dept_id integer REFERENCES departments (dept_id),
 CONSTRAINT emp_key PRIMARY KEY (emp_id),
 CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

select * from departments;
select * from employees;

insert into departments (dept, city)
values
('Tax', 'Atlanta'),
 ('IT', 'Bost');

select * from departments;

INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
 ('Nancy', 'Jones', 62500, 1),
 ('Lee', 'Smith', 59300, 1),
 ('Soo', 'Nguyen', 83000, 2),
 ('Janet', 'King', 95000, 2);

select *
from employees join departments
on employees.dept_id = departments.dept_id;

copy (select *
from employees join departments
on employees.dept_id = departments.dept_id)
to 'D:/Sql_practice/join_table.csv'
with (format csv, header);

create table school_left (
id integer constraint left_id_key primary key,
left_school varchar(30));

create table school_right (
id integer constraint right_id_key primary key,
right_school varchar(30));

INSERT INTO school_left (id, left_school) VALUES
 (1, 'Oak Street School'),
 (2, 'Roosevelt High School'),
 (5, 'Washington Middle School'),
 (6, 'Jefferson High School');

INSERT INTO school_right (id, right_school) VALUES
 (1, 'Oak Street School'),
 (2, 'Roosevelt High School'),
 (3, 'Morrison Elementary'),
 (4, 'Chase Magnet Academy'),
 (6, 'Jefferson High School');


select *
from school_left sl left join school_right sr
on sl.id=sr.id;

select *
from school_left sl right join school_right sr
on sl.id=sr.id;

select *
from school_left sl full outer join school_right sr
on sl.id=sr.id;

select *
from school_left sl right join school_right sr
on sl.id=sr.id;

select *
from school_left sl cross join school_right sr;n mj

select *
from school_left sl left join school_right sr
on sl.id=sr.id
where sr.id is null;

select sl.left_school,
sr.right_school
from school_left sl left join school_right sr
on sl.id=sr.id;

CREATE TABLE schools_enrollment (
 id integer,
 enrollment integer
);

CREATE TABLE schools_grades (
 id integer,
 grades varchar(10)
);

INSERT INTO schools_enrollment (id, enrollment)
VALUES
 (1, 360),
 (2, 1001),
 (5, 450),
 (6, 927);

INSERT INTO schools_grades (id, grades)
VALUES
 (1, 'K-3'),
 (2, '9-12'),
 (5, '6-8'),
 (6, '9-12');

select lt.id, lt.left_school, en.enrollment, gr.grades
from school_left lt left join schools_enrollment en
on lt.id=en.id
left join schools_grades gr
on lt.id=gr.id;

 CREATE TABLE us_counties_2000 (
 geo_name varchar(90),
 state_us_abbreviation varchar(2),
 state_fips varchar(2),
 county_fips varchar(3),
 p0010001 integer,
 p0010002 integer,
 p0010003 integer,
 p0010004 integer,
 p0010005 integer,
 p0010006 integer,
 p0010007 integer,
 p0010008 integer,
 p0010009 integer,
 p0010010 integer,
 p0020002 integer,
 p0020003 integer
);

COPY us_counties_2000
FROM 'D:\Sql_practice\us_counties_2000.csv'
WITH (FORMAT CSV, HEADER);

select * from us_counties_2000;

select p0010001 from us_counties_2000;

SELECT c2010.geo_name,
 c2010.state_us_abbreviation AS state,
 c2010.p0010001 AS pop_2010,
 c2000.p0010001 AS pop_2000,
 c2010.p0010001 - c2000.p0010001 AS raw_change,
 round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
 / c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
 AND c2010.county_fips = c2000.county_fips
 AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_change desc
limit 10;




