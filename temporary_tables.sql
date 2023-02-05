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

/* Create a temporary table based on the payment table from the 
sakila database.
Write the SQL necessary to transform the amount column such that it is 
stored as an integer representing the number of cents of the payment. 
For example, 1.99 should become 199.
  */
use sakila;
select * 
from payment;
describe payment;

use oneil_2107;
create temporary table temp_payments as
select payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM payment as p
JOIN temp_payments tp
on p.customer_id = tp.customer_id
LIMIT 100;











