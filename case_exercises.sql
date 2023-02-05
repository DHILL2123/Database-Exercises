--------- Exercises Case Statements --------
/*Write a query that returns all employees, their department number, 
their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not. */
use employees;
select 
de.emp_no,
de.dept_no,
de.from_date as start_date,
de.to_date as end_date,
de.to_date > now() as is_current_employee
from dept_emp as de
order by emp_no
;
-----------------
select distinct e.emp_no, d.dept_no, de.from_date, de.to_date, 
de.to_date > now() as is_current_employee
from employees as e
  inner join dept_emp as de
  on  e.emp_no = de.emp_no
  inner join departments as d
  on de.dept_no = d.dept_no;
  
  --- using if statement ---
  select dept_emp.emp_no,
	   dept_no,
       hire_date as start_date,
	   to_date,
       if(to_date = '9999-1-1', true, false) as is_current_employee
from dept_emp
join employees using (emp_no);

/*Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending 
on the first letter of their last name.*/

use employees;
select first_name, last_name,
case last_name
when last_name between 'A%' and 'H%' then 'A-H'
when last_name between 'I%' and 'Q%' then 'I-Q'
when last_name between 'R%' and 'Z%' then 'R-Z'
else 'Why doesnt your name start with a letter bro'
-- all other cases give me this 
end as alpha_group
from employees;

/*How many employees (current or previous) were born in each decade?*/
select 
count(case when birth_date between '1950-01-01' and '1959-12-31' then birth_date else null end) as '50s',
count(case when birth_date between '1960-01-01' and '1969-12-31' then birth_date else null end) as '60s'
from employees;


/*What is the current average salary for each of the following department groups: 
R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */

select 
case
when d.dept_name in ('Research', 'Development') then 'R&D'
when d.dept_name in ('Sales', 'Marketing') then 'Sales and Marketing'
when d.dept_name in ('Production', 'Quality Management') then 'Prod & QM'
when d.dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
else d.dept_name
end as dept_group,
avg(s.salary) as avg_salary
from departments d
join dept_emp de using (dept_no)
join salaries s using (emp_no)
where s.to_date > now() and de.to_date > now()
group by dept_group;

----- question #1 but more complicated ----
select 
e.emp_no, 
de.dept_no,
e.start_date,
if(e.end_date > now(), null, e.end_date),
e.is_current_employee
from dept_emp de
join
(
select 
e.emp_no as emp_no,
e.hire_date as start_date,
max(de.to_date) as end_date,
max(de.to_date) > now() as is_current_employee
from employees e
join dept_emp de using (emp_no)
group by e.emp_no
)
e on de.emp_no = e.emp_no and de.to_date = e.end_date;













----- Case statements lecture material -----
-- use the chipotle database
use chipotle;
-- grab a preview of the only table here
select * 
from orders
limit 10;
describe orders;

select item_name
from orders 
limit 5;
-- grabe true values for any instance in the item_names
-- where that specific instance is a chicken time 


select item_name 
from orders 
where item_name 
like '%chicken%';

select item_name,
if (item_name like '%chicken%', 1,0) as chicken_type;
-- if (<truth condition>

-- change the output of that IF statement:
select if (
item_name like '%steak%',
-- first condition => if this value inside of item_name
-- has something in it that looks like the string value steak
-- if steeak is there , et make a new condition to see 
-- if its a steak bowl or just another steak item


if (item_name like '%bowl%', 
'steak bowl', 'other steak item'
), 
-- if it didn't have steak in it at all we ar just going 
-- to go directly to not_Steak an and no even mess with the 
-- nested condition 
'not_steak' ) as steak_col
from orders;

-- usa a case statement if we want to throw in some extra 
-- conditions in the mix
-- case statements are like IF statements
-- but they are stuctured a little different
-- case statements allow for multiple logic checks in a row

-- structure of a case statement:
-- lets build out our first case:

select item_name, quantity,
case item_name
when 'chicken bowl ' then 'bowl'
-- when its a chcken bowl, give me bowl
when 'chicken burrito' then 'burrito'
-- when its a chicken burrito give me a burrito
else 'not chicken that i care about'
-- all other cases give me this 
end as chicken_bowls 
from orders;

-- limitations of what I just did
-- it can only check for direct equivalence!!
/* select item_name,
case item_name
when like '%chicken%' then 'chickney'
else 'not chicken' 
end as chicken_type_beat
from orders; */

select item_name,
case 
when item_name like '%chicken%' then 'chicken type'
when item_name like '%steak%' then 'steak type'
else 'other thing'
end as 'meat check'
from orders;

use join_example_db;
select * 
from users;

select role_id,
case 
when role_id > 2    then 'high roller'
when role_id = 1    then 'some role'
when role_id is null then 'idk'
else 'will you see this?'
end as 'rollers'
from users;

------ Case Statements Learning Materials ------
/*We can create a pivot table using the COUNT function with CASE statements. 
For example, if I wanted to view the number of employee titles by department, 
I can do that by combining these two SQL powerhouses.*/

-- Here, I'm building up my columns and values before I group by departments and 
-- use an aggregate function to get a count of values in each column.

SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;


-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;

----------
SELECT
    dept_name,
    IF(dept_name = 'Research', True, False) AS is_research
FROM departments;

----------
SELECT
    dept_name,
    dept_name = 'Research' AS is_research
FROM departments;
----------
SELECT
    dept_name,
    CASE
        WHEN dept_name IN ('Marketing', 'Sales') THEN 'Money Makers'
        WHEN dept_name LIKE '%research%' OR dept_name LIKE '%resources%' THEN 'People People'
        ELSE 'Others'
    END AS department_categories
FROM departments;
------------
SELECT
    dept_name,
    CASE dept_name
        WHEN 'Research' THEN 1
        ELSE 0
    END AS is_research
FROM departments;
-------------
SELECT
    dept_name,
    IF(dept_name = 'Research', True, False) AS is_research
FROM employees.departments;
----------
USE employees;
SELECT dept_name,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       ELSE dept_name
   END AS dept_group
FROM departments;
----------
USE employees;

SELECT
    dept_name,
    CASE dept_name
        WHEN 'research' THEN 'Development'
        WHEN 'marketing' THEN 'Sales'
        ELSE dept_name
    END AS dept_group
FROM departments;



