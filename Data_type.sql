create table Char_Data_Types
(Character_varying_type varchar(10),
Character_type char(10),
text_type text);

insert into Char_Data_Types 
values
('abc','abc','abc'),
('abcghi','abcghi','abcghi');

copy Char_Data_Types to 'D:\Sql_Practice\Char_Data_Types.txt'
with (Format csv, header, delimiter '|');

create table number_data_type
(numeric_col numeric (20,5),
real_col real,
double_precision double precision
);

insert into number_data_type
values 
(.6,.6,.6),
(3.1556875123215,3.1556875123215,3.1556875123215);

select * from number_data_type;


create table Date_Types
(Timestamp_col timestamp with time zone,
interval_col interval); 

insert into Date_Types
values 
('5-24-2025 4:00 Est', '3 days'),
('5-24-2025 4:00 -8', '2 month'),
('5-24-2025 4:00 Asia/Dhaka', '8 decade');

select * from date_types;

SELECT
 timestamp_col,
 interval_col,
 timestamp_col + interval_col AS new_date
FROM date_types;

select timestamp_col, cast(timestamp_col as varchar(10))
from date_types;

select Numeric_col, 
cast(Numeric_col as integer),
cast (Numeric_col as varchar(10))
from number_data_type ndt ;

select timestamp_col, timestamp_col::varchar(10) from date_types dt ;



