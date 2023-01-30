use chipotle;

select item_name
from orders
where item_name like '%chickens%'
group by quantity, item_name
order by item_name;


-- Aggregrate Functions -- 
-- count
-- how many chicken bowls have been ordered?

select item_name, count(item_name)
from orders
where item_name like '%chicken%'
group by item_name;

select item_name, min(quantity), max(quantity)
from orders
where item_name like '%chicken%'
group by item_name;


select item_name, count(item_name) as count_items
from orders
where item_name like '%chicken%'
group by item_name
having count(item_name) > 100;

/*Create a new file named group_by_exercises.sql

In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.

--129371 --  */
use employees;
describe titles;
select distinct title, from_date, to_date
from titles;

 /*
Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY. */
select distinct last_name
from employees
where last_name like 'E%e'
group by last_name;

-- 5 --

/*Write a query to to find all unique combinations of first and last names of 
all employees whose last names start and end with 'E'. */

select distinct last_name, first_name
from employees 
where last_name like 'E%e';

-- 846 --

/*Write a query to find the unique last names with a 'q' but not 'qu'. 
Include those names in a comment in your sql code. */
-- 'Qiwen''Lindqvist''Chleq'

select distinct count(last_name)
from employees
where not last_name like '%qu%' and  last_name like '%q%';

/*Add a COUNT() to your results (the query above) to find the number of employees with the same last name.*/
-- 547 

/*Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.*/
-- 441 M, 268 F --
Select count(firstname), gender
from employees
where first_name = 'Irena' OR
first_name =  'Vidya' OR
first_name = 'Maya'
group by gender;

/*Using your query that generates a username for all of the employees, generate a count employees for each unique username. */
select distinct count(first_name),  lower(Concat(
substr(first_name, 1,1),
substr(last_name, 1,4),
'_',
lpad(month(birth_date), 2, 0),
substr(birth_date, 3,2)))
as username
from employees
group by username
having count(username) > 1;


/*From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? 
-- 6
Bonus: How many duplicate usernames are there from your previous query? */
-- 13251
-- Group by Exercise Bonus --
use employees;
describe titles;
select distinct title, from_date, to_date
from titles;