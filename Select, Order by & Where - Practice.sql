SELECT * FROM teachers;
SELECT last_name, first_name, salary FROM teachers;
select distinct school from teachers t;
select distinct first_name, Salary from teachers;

select first_name, last_name,salary from teachers
order by salary desc;

select first_name, last_name, salary from teachers t
order by salary asc;

select first_name, last_name, salary, hire_date from teachers t 
order by salary, hire_date desc;


select first_name, last_name, salary, hire_date from teachers t 
order by hire_date,salary desc;

select first_name, last_name, school, salary from teachers t 
where school = 'F.D. Roosevelt HS';

select first_name, last_name, school, salary from teachers t 
where school != 'F.D. Roosevelt HS';

select first_name, salary from teachers t 
where salary >38000;

select first_name, salary from teachers t 
where salary <=38000;

select first_name, last_name, salary, hire_date from teachers t 
where hire_date>'2000-01-01';

select first_name, last_name
from teachers t 
where first_name ilike '%ntha%';

select first_name, last_name from teachers t 
where first_name like '%a_ee%';

select first_name, last_name, salary from teachers t 
where school = 'Myers Middle School' and salary >38000;

select first_name, last_name, salary from teachers t 
where salary >38000 and school = 'Myers Middle School';

select first_name, last_name, salary from teachers t 
where salary >38000 and first_name ilike 'sam%';

select first_name, salary from teachers t 
where salary >37500
order by salary desc;

select first_name, last_name, salary from teachers t 
where last_name = 'Diaz' or last_name = 'Cole';

select first_name, last_name, salary from teachers t 
where school = 'Myers Middle School' and (salary >42000 or salary < 38000)
order by salary desc;



