select 2*2;
select 8-5;
select 11+45;
select 13/5;
select 13%5;
select 13.0/5;
select cast (13 as numeric(3,1))/5;
select  2^5;
select |/34;
select sqrt(34);
select ||/34;
select factorial(4);
SELECT 7 + 8 * 9;
SELECT (7 + 8) * 9;
SELECT 3 ^ 3 - 1;
SELECT 3 ^ (3 - 1);

SELECT geo_name,
 state_us_abbreviation AS "st",
 p0010001 AS "Total Population",
 p0010003 AS "White Alone",
 p0010004 AS "Black or African American Alone",
 p0010005 AS "Am Indian/Alaska Native Alone",
 p0010006 AS "Asian Alone",
 p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
 p0010008 AS "Some Other Race Alone",
 p0010009 AS "Two or More Races"
FROM us_counties_2010;

SELECT geo_name,
 state_us_abbreviation AS "st",
 p0010003 AS "White Alone",
 p0010004 AS "Black Alone",
 p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;

SELECT geo_name,
 state_us_abbreviation AS "st",
 p0010001 AS "Total",
 p0010003 + p0010004 + p0010005 + p0010006 + p0010007
 + p0010008 + p0010009 AS "All Races",
 (p0010003 + p0010004 + p0010005 + p0010006 + p0010007
 + p0010008 + p0010009) - p0010001 AS "Difference"
FROM us_counties_2010
ORDER BY "Difference" DESC;

select geo_name, state_us_abbreviation,
(cast (p0010006 as numeric(8,1))/p0010001)*100 as "pt asian"
from us_counties_2010 uc 
order by "pt asian" desc;

CREATE TABLE percent_change (
 department varchar(20),
 spend_2014 numeric(10,2),
 spend_2017 numeric(10,2)
);

insert into percent_change
values 
 ('Building', 250000, 289000),
 ('Assessor', 178556, 179500),
 ('Library', 87777, 90001),
 ('Clerk', 451980, 650000),
 ('Police', 250000, 223000),
 ('Recreation', 199000, 195000);

select * from percent_change;

select
spend_2014,
spend_2017,
round(
(spend_2017-spend_2014)/spend_2014 * 100,1) as "pct_change"
from percent_change
order by "pct_change" desc;

--Aggregate Functions

select SUM(p0010001) as "Total county",
round( avg(p0010001),0) as "AVG county"
from us_counties_2010 uc ;

create table per_test
(Values_col integer);

insert into per_test
values 	
(1), (2), (3), (4), (5), (6);

select * from per_test;

SELECT
 percentile_cont(.5)
 WITHIN GROUP (ORDER BY Values_col),
 percentile_disc(.5)
 WITHIN GROUP (ORDER BY Values_col)
FROM per_test;

select sum(p0010001),
round(avg(p0010001),1) as "county average",
PERCENTILE_CONT(.5)
within group (order by p0010001) as "county median"
from us_counties_2010 uc ;

select PERCENTILE_CONT(array[.25,.5,.75])
within group (order by p0010001)
from us_counties_2010;

select mode() within group (order by p0010001) from us_counties_2010;

