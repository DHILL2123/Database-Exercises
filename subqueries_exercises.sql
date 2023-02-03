/* A Scaler Subquery is a subquery that returns a single value.

Below is an example of a scalar subquery. Notice how we can treat the subquery as 
if it were the single value produced. The scalar subquery (SELECT AVG(salary) 
FROM salaries WHERE to_date > CURDATE()) 
operates with the comparison operator as if we had typed 72012.2359.*/

-- Scalar Subqueries Return a Single Value
SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

-- Column Subqueries
SELECT column_a, column_b, column_c
FROM table_a
WHERE column_a IN (
    SELECT column_a
    FROM table_b
);

-- which employees have higher than average salaries
use employees;
-- inner query 
select avg(salary)
from salaries;

-- outer query
select * 
from salaries;

-- combine queries together
select * 
from salaries
where salary > 
(-- must put subquery in parenthesis 
select avg(salary)
from salaries);

-- 
select first_name, 
last_name,
salary,
(select avg(salary) from salaries) as avg_salary,-- subquery in select statement
'hello' -- single values are repeated in each row
from salaries 
join employees 
using (emp_no)
where salary > -- use any conditional operator
( -- must put subquery in parenthesis 
select avg(salary) 
from salaries);

------------------- Exercises -------------------------
/*
Find all the current employees with the same hire date as employee 
101010 using a subquery. */
-- pulls all emp_no = '101010' from employees table 
select *
from employees
where emp_no = '101010';
-- select all(*) employees from employees table 
select *
from employees
	join dept_emp -- joins the dept_emp (department employees) using the emp_no
		using (emp_no)  
where to_date > now() -- where selects the current to_date > now() (gets all current employees) and hire_date
and hire_date = 
	(-- subquery inserted into where 
    select hire_date
	from employees
	where emp_no = '101010'
	)
;

/*
Find all the titles ever held by 
all current employees with the first name Aamod. */

/*'Senior Staff','60'
'Staff','64'
'Engineer','62'
'Technique Leader','9'
'Senior Engineer','51'
'Assistant Engineer','5' */

-- select emp_no from employees table where first_name = 'Aamod';
select emp_no
from employees
where first_name = 'Aamod';
-- select title, count(*) selected titles as cnt from the dept_emp table
select title, count(*) as cnt
from dept_emp 
	join titles -- join titles using emp_no
		using (emp_no)
where dept_emp.to_date > now() -- joins titles where dept_emp table to_date column linked to the emp_no key
and emp_no in  -- and pulls emp_no column from employees table at first_name colum = to 'Aamod'
	(
	select emp_no
	from employees
	where first_name = 'Aamod'
	)
group by title -- groups by title column
;

/* How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code. */

-- 59,900
-- pulls current emp_no from dept_emp
select emp_no
from dept_emp 
where to_date > now();

-- this is checking that all the employees no longer work there
select emp_no, max(to_date) as max_date -- selects emp_no maximum to_date to get all emp_no from employees table
from employees
	join dept_emp -- joins dept_emp (all departments employees) using emp_no
		using (emp_no)
where emp_no not in -- request all emp_no no longer currently working 
	( -- selects all current emp_no from dept_emp(all departments) / separates the currently working leaves the not current list
    select emp_no
	from dept_emp 
	where to_date > now()
    )
group by emp_no   -- groups the no longer working emp_no
order by max_date desc -- list max_date no in current to_date
;

select count(emp_no) -- counts emp_no from employees table
from employees
where emp_no not in  -- separates the no longer emp_no from the current emp_no
	(
    select emp_no
	from dept_emp 
	where to_date > now()
    )
;

/*
Find all the current department managers that are female. 
List their names in a comment in your code. */

/*'Isamu','Legleitner','F'
'Karsten','Sigstam','F'
'Leon','DasSarma','F'
'Hilary','Kambil','F'
 */
 
-- pulls the current dept_manager by emp_no from the dept_manager table
select emp_no 
from dept_manager
where to_date > now();
-- pulls first_name, last_name, gender from employees table where gender = female
select first_name, last_name, gender
from employees
where gender = 'F'
	and emp_no in -- pulls current dept_manager emp_no from dept_manager table 
		(
        select emp_no
		from dept_manager
		where to_date > now()
        )
;

/*Find all the employees who currently have a higher salary than 
the companies overall, historical average salary. */
--  gets all average salaries 
select avg(salary)
from salaries;
-- pulls all salary and to_date from salaries table
select first_name, last_name, salary, to_date
from salaries
	join employees -- joins employeees table using the emp_no which allows you to pull the first_name & last_name
		using (emp_no)
where to_date > now() -- where to_date > now() pulls the current  employees and salaries
and salary >   -- pulls current salary that is greater than the the avg(salary) from salaries 
	(
    select avg(salary)
	from salaries
    )
order by salary -- orders delivery by salary
;

/*How many current salaries are within 1 standard deviation of the 
current highest salary? (Hint: you can use a built in function to 
calculate the standard deviation.) What percentage of all salaries is this? */
-- 83 returned salaries
-- gets current max salary to_date > now();
select max(salary)
from salaries
where to_date > now();
-- gets standard deviation of current salary
select stddev(salary)
from salaries
where to_date > now();
-- counts number of current salaries
select count(*)
from salaries
where to_date > now()
and salary > 
	(
	( -- max salary
    select max(salary)
	from salaries
	where to_date > now()
    )
    -
    ( -- one standard deviation 
    select stddev(salary)
	from salaries
	where to_date > now()
    )
    )
; 

select 
( -- gets count of all current salaries
select count(*)
from salaries
where to_date > now()
and salary > 
	(
	( -- get current max salary
    select max(salary)
	from salaries
	where to_date > now()
    )
    -
    ( -- current salary within one standard deviation 
    select stddev(salary)
	from salaries
	where to_date > now()
    )
    )
)
/ 
( -- to get what percent of all current salaries are witin one standard deviation 
select count(*) from salaries where to_date > now()
) * 100
;
-- .0346%
/*
Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. 
You will use this number (or the query that produced it) in other, larger queries. */






