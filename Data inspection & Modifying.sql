CREATE TABLE meat_poultry_egg_inspect (
 est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
 company varchar(100),
 street varchar(100),
 city varchar(30),
 st varchar(2),
 zip varchar(5),
 phone varchar(14),
 grant_date date,
 activities text,
 dbas text
);

COPY meat_poultry_egg_inspect
FROM 'D:\Sql_practice\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

select * from meat_poultry_egg_inspect;

create index company_idx on meat_poultry_egg_inspect (company);

select count(*) from meat_poultry_egg_inspect;

--Interviewing the Data Set

select company,
street,
city,
st,
count(*) as address_count
from meat_poultry_egg_inspect
group by company ,street , city , st 	
having count(*)>1
order by company, street,city, st;

select st,
count (*)
from meat_poultry_egg_inspect
group by st
order by st;

SELECT est_number,
 company,
 city,
 st,
 zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

select company,
count(*) as "Number of company"
from meat_poultry_egg_inspect
group by company
order by company asc;

select length(zip),
COUNT(*) as zip_length
from meat_poultry_egg_inspect
group by length(zip)
order by length(zip);

select st,
count(*)
from meat_poultry_egg_inspect
where length(zip)<5
group by st
order by st asc;

--Creating Backup Tables
create table meat_poultry_egg_inspect_backup as
select * from meat_poultry_egg_inspect;

select * from meat_poultry_egg_inspect_backup;

select 
(select count(*) from meat_poultry_egg_inspect) as original,
(select count(*) from meat_poultry_egg_inspect_backup) as backup;

--Creating a Column Copy

alter table meat_poultry_egg_inspect add column st_copy varchar(10);

update meat_poultry_egg_inspect mpei 
set st_copy = st;

select st, st_copy from meat_poultry_egg_inspect mpei ;

--Updating Rows Where Values Are Missing

select * from meat_poultry_egg_inspect
where st is null;

update meat_poultry_egg_inspect
set st= 'MN'
where est_number = 'V18677A';

update meat_poultry_egg_inspect
set st= 'AL'
where est_number = 'M45319+P45319';


update meat_poultry_egg_inspect
set st= 'WI'
where est_number = 'M263A+P263A+V263A';

---Restoring Original Values

update meat_poultry_egg_inspect mpei 
set st = st_copy ;

update meat_poultry_egg_inspect  original
set st = backup.st
from meat_poultry_egg_inspect_backup backup
where original.est_number = backup.est_number ;

----Updating Values for Consistency

alter table meat_poultry_egg_inspect add column company_standard varchar(20);
alter table meat_poultry_egg_inspect alter column company_standard set data type varchar (100);

update meat_poultry_egg_inspect mpei 
set company_standard = company;

update meat_poultry_egg_inspect mpei 
set company_standard	='Armour-Eckrich Meats'
where company ilike 'Armour%';


select company, company_standard from meat_poultry_egg_inspect mpei
where company ilike 'Armour%';

---Repairing ZIP Codes Using Concatenation

alter table meat_poultry_egg_inspect add column zip_copy varchar (20);

update meat_poultry_egg_inspect mpei 
set zip_copy =zip;

update meat_poultry_egg_inspect mpei 
set zip = '00'||zip
where st in ('PR','VI') and length(zip)=3;
 
update meat_poultry_egg_inspect mpei 
set zip = '0'||

update meat_poultry_egg_inspect mpei 
set zip ='0'||zip 
where st in ('CT','MA','ME','NH','NJ','RI','VT') and length(zip) =4;

select * from meat_poultry_egg_inspect mpei ;

select length(zip),count(*)
from meat_poultry_egg_inspect
group by length(zip);

--Updating Values Across Tables

create table state_region (
st varchar(2) constraint st_key primary key,
region varchar (30) not null
);

copy state_region (st, region)
from 'D:/Sql_practice/state_regions.csv'
with (format csv, header);

select * from state_region;

alter table meat_poultry_egg_inspect add column inspection_date date;

update meat_poultry_egg_inspect mpei 
set inspection_date = '2019-12-01'
where exists (select state_region.region
from state_region
where state_region.st = mpei.st
and state_region.region = 'New England');

select st, inspection_date
from meat_poultry_egg_inspect
group by st, inspection_date 
order by st;

---Deleting Rows from a Table

delete from meat_poultry_egg_inspect 
where st in ('PR','VI');

--Deleting a Column from a Table

alter table meat_poultry_egg_inspect drop column zip_copy;

drop table meat_poultry_egg_inspect_backup ;

--Using Transaction Blocks to Save or Revert Changes
;

start transaction;

update meat_poultry_egg_inspect mpei 
set company = 'AGRO Merchantss Oakland LLC'
where company = 'AGRO Merchants Oakland, LLC';

select company
from meat_poultry_egg_inspect mpei 
where company ilike 'agro%';

rollback;

create table meat_poultry_egg_inspect_backup as
select *,
'2025-06-05'::date as reviewed_date
from meat_poultry_egg_inspect;

select * from meat_poultry_egg_inspect_backup;








