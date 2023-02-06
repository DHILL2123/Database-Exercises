use oneil_2107;
CREATE TEMPORARY TABLE my_numbers
    (
    n INT UNSIGNED NOT NULL,
    named varchar(20) not null
    )
    ;
-- verify data was inserted
    select * from my_numbers;
    
    show tables;
    
    # insert data in my_numbers
    insert into my_numbers (n, named)
    values (1,'a'),(2,6);
    
    -- update values in the temp table
    update my_numbers 
    set named = 'BIG'
    where n >= 4;

------ Exercises ------
/* Using the example from the lesson, create a temporary table called 
employees_with_departments 
that contains first_name, last_name, and dept_name for employees currently 
with that department. Be absolutely sure to create this table on your own 
database. If you see "Access denied for user ...", it means that the query 
was attempting to write a new table to a database that you can only read.

Add a column named full_name to this table. It should be a 
VARCHAR whose length is the sum of the lengths of the first name and 
last name columns.
Update the table so that full name column contains the correct data.
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table? */
------- exercises -------
use oneil_2107;
create temporary table employees_with_departments
(
    Last_Name varchar(100),
    First_Name varchar(100),
    Department_Name varchar(100)

);

alter table employees_with_departments 
add (Full_Name varchar (200));

describe employees_with_departments;

insert into employees_with_departments (Full_Name)
values ('DeAdrien Hill');

alter table employees_with_departments
drop column Last_Name, 
drop column First_Name;

describe employees_with_departments;

-- could drop the table and create a new one with the columns you need --
----- exercise one again -----
select database();
use employees; -- switch to the employees db to make the temp table

create temporary table oneil_2107.employees_with_departments as
select emp_no first_name, last_name, dept_no, dept_name
from employees 
join dept_emp
using (emp_no)
join departments 
using (dept_no)
limit 100;

use oneil_2017;

select * from employees_with_departments;

-- add column named full_name to the table
-- should be a varchar with the sum of the lengths of the first name and last name column

select max(length(concat(first_name, last_name))) + 1
from employees_with_departments;

alter table employees_with_departments
add full_name varchar(21);
-- hardcoded the full_name string varchar length

select * from employees_With_departments; -- verify the column is created

-- update the table so the fullname column contains the correct date
update employees_with_departments
set full_name = concat(first_name, ' ', last_name);

select * from employees_with_departments; -- verify the update

-- remove the first_name and last_name columns form the table
alter table employees_with_departments
drop column first_name,
drop column last_name; -- need separate drop column statements to drop multiple columns

select * from employees_with_departments; -- verify the changes

/* Create a temporary table based on the payment table from the 
sakila database.
Write the SQL necessary to transform the amount column such that it is 
stored as an integer representing the number of cents of the payment. 
For example, 1.99 should become 199.
  */
use sakila; 
show tables;

select * from payment;
drop table if exists oneil_2107.payments; -- only drops the table if it already exists

create temporary table oneil_2107.payments as 
select * from payment;

use oneil_2107; -- switch db
select * from payments; -- verify table creation 

-- write the command to transform the amount column
-- so it is stored as an integer representing the number of cents of payment
-- example, 1,99 should be 199

update payments
set amount = amount * 100; -- this update creates and error 

describe payments; -- datatype only accepts a decimal that is five chars long

alter table payments
modify amount decimal(10,2); -- use modify command to all the decimal datatypes to hold up to 10 chars

describe payments; -- verify the changes

update payments
set amount = amount * 100; -- updated amount value

select * from payments; -- verify the change

--- alternate way to solve the same problem --- 

create temporary table payments_another_way as
select 
payment_id,
customer_id,
staff_id,
rental_id,
(amount * 100) as amount,-- multiply the value before saving it in the temp table
payment_update,
last_update
from sakla.payment;

select * from payments_another_way; -- verify changes

alter table payments_another_way -- now change amount into interger
modify amount int;

select * from payments_another_way; -- verify changes

-- find the current average pay in each department
-- compare to the overall current pay
-- for everyone at the company
-- in order to make the comparison easier you should use the z-score for salaries.
-- in terms of salary, what is the best department right now to work for? the worst?

-- z-score = (x - mean) / standard deviation
-- z-score = (each department average salary - overall average salary) / overall standard deviation of salaries

-- first determine the average salary for each department
use employees;

select dept_name, round(avg(salary), 2) as avg_salary
from departments 
join dept_emp
using (dept_no)
join salaries
using (emp_no)
where salaries.to_date > now()
and dept_emp.to_date > now()
group by dept_name;

drop table if exists oneil_2107.avg_dept_salaries; -- only drops if the table exists

-- create temp table in my db
create temporary table oneil_2107.avg_dept_salaries as
(
select dept_name, round(avg(salary),2) as avg_salary
from departments
join dept_emp
using (dept_no)
join salaries 
using (emp_no)
where salaries.to_date > now()
and dept_emp.to_date > now()
group by dept_name
);

-- verify table creation 
select * from oneil_2107.avg_dept_salaries;

-- reminder:
-- z-score = (each department average salary - overall average salary) / overall standard deviation 

-- get the overall average salary 
select avg(salary) from employees.salaries
where to_date > now();

-- get the overall average standard deviation 
select stddev(salary) from employees.salaries
where to_date > now();

-- save the values into the temp table
-- switch over to my db to to get into the temp table
use oneil_2107;

-- add new column for the overall average salary
-- add new column for overall average standard deviation

alter table avg_dept_salaries
add overall_avg_salary float;

alter table avg_dept_salaries
add overall_std_salary float;

-- verify the columns are created and empty

select * from avg_dept_salaries;

-- add in date to the new created columns
-- use the selection statements from earlier

update avg_dept_salaries
set overall_avg_salary = (select round(avg(salary),2) from employees.salaries where to_date > now());

update avg_dept_salaries
set overall_std_salary = (select round(std(salary),2) from employees.salaries where to_date > now());

 -- verify changes
 
 select * from avg_dept_salaries;
 
 -- reminder to calculate :
 -- z-score = (each department average salary - overall average salary) / overall standard deviation 
 
 -- add new z-score columns
 alter table avg_dept_salaries
 add zscore float;
 
 update avg_dept_salaries
 set zscore = (avg_salary - overall_avg_salary) / overall_std_salary;
 
 -- verify changes
 select * from avg_dept_salaries;
 
 -- order by to get the best and worst departments
 select * 
 from avg_dept_salaries
 order by zscore desc;
 












