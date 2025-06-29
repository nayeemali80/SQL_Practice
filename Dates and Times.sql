SELECT
 date_part('year', '2019-12-01 18:37:12 EST'::timestamptz) AS "year",
 date_part('month', '2019-12-01 18:37:12 EST'::timestamptz) AS "month",
 date_part('day', '2019-12-01 18:37:12 EST'::timestamptz) AS "day",
 date_part('hour', '2019-12-01 18:37:12 EST'::timestamptz) AS "hour",
 date_part('minute', '2019-12-01 18:37:12 EST'::timestamptz) AS "minute",
 date_part('seconds', '2019-12-01 18:37:12 EST'::timestamptz) AS "seconds",
 date_part('timezone_hour', '2019-12-01 18:37:12 EST'::timestamptz) AS "tz",
 date_part('week', '2019-12-01 18:37:12 EST'::timestamptz) AS "week",
 date_part('quarter', '2019-12-01 18:37:12 EST'::timestamptz) AS "quarter",
 date_part('epoch', '2019-12-01 18:37:12 EST'::timestamptz) AS "epoch";

select
make_date(2025, 03, 12);

SELECT make_date(2018, 2, 22);
SELECT make_time(18, 4, 30.3);
SELECT make_timestamptz(2018, 2, 22, 18, 4, 30.3, 'Europe/Lisbon');


CREATE TABLE current_time_example (
 time_id bigserial,
 current_timestamp_col timestamp with time zone,
 clock_timestamp_col timestamp with time zone
);

INSERT INTO current_time_example (current_timestamp_col, clock_timestamp_col)
 (SELECT current_timestamp,
 clock_timestamp()
 FROM generate_series(1,1000));

SELECT * FROM current_time_example;


SHOW timezone;

SELECT * FROM pg_timezone_abbrevs;
SELECT * FROM pg_timezone_names;

SELECT * FROM pg_timezone_names
WHERE name LIKE 'Asia%';

set timezone to 'Asia/Dhaka';

create table time_zone_test (
test_date timestamp with time zone
);

insert into time_zone_test values ('2010-02-23 4:00');

select * from time_zone_test;

set timezone to 'Asia/Karachi';

select * from pg_timezone_names
where name ilike 'asia%';

show time zone;

select test_date from time_zone_test;

select test_date at time zone 'Asia/Seoul' from time_zone_test;

select ('2025-06-29'::date - '1997-09-25')/365::numeric;

select '2025-06-29'::date + '28 years'::interval;

 CREATE TABLE nyc_yellow_taxi_trips_2016_06_01 (
 trip_id bigserial PRIMARY KEY,
 vendor_id varchar(1) NOT NULL,
 tpep_pickup_datetime timestamp with time zone NOT NULL,
 tpep_dropoff_datetime timestamp with time zone NOT NULL,
 passenger_count integer NOT NULL,
 trip_distance numeric(8,2) NOT NULL,
 pickup_longitude numeric(18,15) NOT NULL,
 pickup_latitude numeric(18,15) NOT NULL,
 rate_code_id varchar(2) NOT NULL,
 store_and_fwd_flag varchar(1) NOT NULL,
 dropoff_longitude numeric(18,15) NOT NULL,
 dropoff_latitude numeric(18,15) NOT NULL,
 payment_type varchar(1) NOT NULL,
 fare_amount numeric(9,2) NOT NULL,
 extra numeric(9,2) NOT NULL,
 mta_tax numeric(5,2) NOT NULL,
 tip_amount numeric(9,2) NOT NULL,
 tolls_amount numeric(9,2) NOT NULL,
 improvement_surcharge numeric(9,2) NOT NULL,
 total_amount numeric(9,2) NOT NULL
);

COPY nyc_yellow_taxi_trips_2016_06_01 (
 vendor_id,
 tpep_pickup_datetime,
 tpep_dropoff_datetime,
 passenger_count,
 trip_distance,
 pickup_longitude,
 pickup_latitude,
 rate_code_id,
 store_and_fwd_flag,
 dropoff_longitude,
 dropoff_latitude,
 payment_type,
 fare_amount,
 extra,
 mta_tax,
 tip_amount,
 tolls_amount,
 improvement_surcharge,
 total_amount
 )
FROM 'D:\Sql_Practice\yellow_tripdata_2016_06_01.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

select * from nyc_yellow_taxi_trips_2016_06_01;

CREATE INDEX tpep_pickup_idx
ON nyc_yellow_taxi_trips_2016_06_01 (tpep_pickup_datetime);

select count (*) from nyc_yellow_taxi_trips_2016_06_01;

set timezone to 'Asia/Dhaka';

show time zone;

 copy 
 (select 
date_part('hour',tpep_pickup_datetime) as trip_hour,
count(*)
from nyc_yellow_taxi_trips_2016_06_01
group by trip_hour
order by trip_hour)
to 'D:/Sql_practice/Trip_hour_data.csv'
with (format csv, header);

select date_part('hour',tpep_pickup_datetime) as trip_hour,
PERCENTILE_CONT(.5) within group (order by tpep_dropoff_datetime - tpep_pickup_datetime) as median_trip
FROM nyc_yellow_taxi_trips_2016_06_01
GROUP BY trip_hour
ORDER BY trip_hour









