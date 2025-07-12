SELECT geo_name,
 state_us_abbreviation,
 p0010001
FROM us_counties_2010
where p0010001 >= (
select PERCENTILE_CONT(.9) within group (order by p0010001) from us_counties_2010)
order by p0010001;

create table us_counties_2010_top10 as 
select * from us_counties_2010;

delete from us_counties_2010_top10
where p0010001 <(
select PERCENTILE_CONT(.9) within group (order by p0010001)
from us_counties_2010);

select round(cals.average,0) as average,
cals.median,
round(cals.average-cals.median,0) as diff
from (
select AVG(p0010001) as average,
PERCENTILE_CONT(.5) within group (order by p0010001)::numeric(10,1) as median
from us_counties_2010) as cals;


select census.state_us_abbreviation AS st,
 census.st_population,
 plants.plant_count,
 round((plants.plant_count/census.st_population::numeric(10,1))*1000000, 1)
 AS plants_per_million 
 from (
 SELECT st,
 count(*) AS plant_count
 FROM meat_poultry_egg_inspect
 GROUP BY st
 )
 AS plants
JOIN
 (
 SELECT state_us_abbreviation,
 sum(p0010001) AS st_population
 FROM us_counties_2010
 GROUP BY state_us_abbreviation
 )
 AS census
ON plants.st = census.state_us_abbreviation
ORDER BY plants_per_million DESC;


--Generating Columns with Subqueries

select geo_name,
state_us_abbreviation as st,
p0010001,
(select PERCENTILE_CONT(.5) within group (order by p0010001) as median from us_counties_2010)
from us_counties_2010;


select geo_name,
state_us_abbreviation as st,
p0010001 AS total_pop,
(SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY p0010001)
from us_counties_2010) as us_median,
p0010001 - (SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY p0010001)
 from us_counties_2010) as diff_from_median
FROM us_counties_2010
WHERE (p0010001 - (SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY p0010001)
 FROM us_counties_2010))
 BETWEEN -1000 AND 1000;


--common table expression

with 
large_counties (geo_name, st, p0010001)
as ( select geo_name, state_us_abbreviation, p0010001 from us_counties_2010 
where p0010001 >= 100000)
select st, count(*)
from large_counties
group by st 
order by count(*) desc;

with counties (st, population)
as (select state_us_abbreviation, sum(population_count_100_percent)
from us_counties_2010
group by state_us_abbreviation),
plants(st, plants) as 
(select st, count(*) as plants
from meat_poultry_egg_inspect
group by st)
select counties.st,
population,
plants,
round((plants/population::numeric(10,1))*1000000,1) as per_million
from counties join plants
on counties.st=plants.st
order by per_million desc;


with us_median as 
(select PERCENTILE_CONT(.5) within group (order by p0010001) from us_counties_2010)
select geo_name,
state_us_abbreviation,
us_median,
(p0010001-us_medan) as diff_from_median
from us_counties_2010 cross join us_median
where  (p0010001 - us_median_pop)
between -1000 and 1000;

create extension tablefunc;

create table ice_cream_survey (
response_id integer primary key,
office varchar(20),
flavor varchar (20));

copy ice_cream_survey
from 'D:\Sql_Practice\ice_cream_survey.csv'
with (format csv, header);

select * from ice_cream_survey;

SELECT *
FROM crosstab('SELECT office,
 flavor,
count(*)
 FROM ice_cream_survey
 GROUP BY office, flavor
 ORDER BY office',
 'SELECT flavor
 FROM ice_cream_survey
 GROUP BY flavor
 ORDER BY flavor')
AS (office varchar(20),
 chocolate bigint,
 strawberry bigint,
 vanilla bigint);

create table temperature_readings (
reading_id bigserial,
station_name varchar(50),
observation_date date,
max_temp integer,
min_temp integer
);

copy temperature_readings (station_name, observation_date, max_temp, min_temp)
from 'D:\Sql_practice\temperature_readings.csv'
with (format csv, header);

select * from temperature_readings;

select * from crosstab
('select station_name, date_part('month', observation_date),
percentile_cont (.5) within group (order by max_temp)
from temperature_readings
group by station_name,
date_part('month', observation_date)',
'select month from generate_series(1,12) as month')
as(station varchar(50),
 jan numeric(3,0),
 feb numeric(3,0),
 mar numeric(3,0),
 apr numeric(3,0),
 may numeric(3,0),
 jun numeric(3,0),
 jul numeric(3,0),
 aug numeric(3,0),
 sep numeric(3,0),
 oct numeric(3,0),
 nov numeric(3,0),
 dec numeric(3,0)
);



SELECT *
FROM crosstab('SELECT
 station_name,
 date_part(''month'', observation_date),
 percentile_cont(.5)
 WITHIN GROUP (ORDER BY max_temp)
 FROM temperature_readings
 GROUP BY station_name,
 date_part(''month'', observation_date)
 ORDER BY station_name',
 'SELECT month
 FROM generate_series(1,12) month')
AS (station varchar(50),
 jan numeric(3,0),
 feb numeric(3,0),
 mar numeric(3,0),
 apr numeric(3,0),
 may numeric(3,0),
 jun numeric(3,0),
 jul numeric(3,0),
 aug numeric(3,0),
 sep numeric(3,0),
 oct numeric(3,0),
 nov numeric(3,0),
 dec numeric(3,0)
);

select max_temp,
case when max_temp>=90 then 'Hot'
when max_temp between 70 and 89 then 'Warm'
when max_temp between 50 and 69 then 'pleasant'
when max_temp between 33 and 49 then 'Cold'
when max_temp between 20 and 32 then 'Freezing'
else 'Inhuman'
end as temperature_group
from temperature_readings;

with temp_collapsed (station_name,temperature_group) as 
(seleCT station_name,
 CASE WHEN max_temp >= 90 THEN 'Hot'
 WHEN max_temp BETWEEN 70 AND 89 THEN 'Warm'
 WHEN max_temp BETWEEN 50 AND 69 THEN 'Pleasant'
 WHEN max_temp BETWEEN 33 AND 49 THEN 'Cold'
 WHEN max_temp BETWEEN 20 AND 32 THEN 'Freezing'
 ELSE 'Inhumane'
 END
 FROM temperature_readings)
 select station_name, temperature_group, count (*)
 from temp_collapsed
group by station_name,temperature_group
order by count(*) desc;





