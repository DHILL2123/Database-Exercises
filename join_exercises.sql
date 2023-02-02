show databases;
use join_example_db;
-- join aka inner join 
select users.name as user_name, roles.name as role_name
from users
join roles on users.role_id = roles.id;

-- left join
select users.name as user_name, roles.name as role_name
from users
left join roles on users.role_id = roles.id;

-- right join 
select users.name as user_name, roles.name as role_name
from users
right join roles on users.role_id = roles.id;

-- above right join rewritten as left join
select users.name as user_name, roles.name as role_name 
from roles 
left join users on users.role_id = roles.id;

-- Join Example Database
-- Use the join_example_db. Select all the records from both the users and roles tables.
show tables;
describe roles;
select users.name as user_name, roles.name as role_name
from users
left join roles on users.role_id = roles.id;

-- joined to show the users with roles 
select users.name as user_name, roles.name as role_name
from users 
join roles on users.role_id = roles.id;

-- left joined to show all users and the role name for each user
select users.name as user_name, roles.name as role_name
from users 
left join roles on users.role_id = roles.id;

-- right joined to show only users with roles  came back and all roles are listed. 
select users.name as user_name, roles.name as role_name
from users 
right join roles on users.role_id = roles.id;

-- using count(), group by, with joins to show number of users with each roll
select  count(users.name) as user_name, roles.name as role_name
from users
left join roles on users.role_id = roles.id
group by roles.id;

describe roles;


-- Employees Database 
use employees;
select concat(e.first_name, ' ', e.last_name) as full_name, d.dept_name
from employees as e
join dept_emp as de 
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where de.to_date = '9999-01-01' and e.emp_no = 10001;

-- Show each department along wtih name of the current manager for that department.
describe departments;
describe dept_manager;
SELECT distinct CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager, d.dept_name as Department_Name
FROM employees AS e
JOIN dept_emp AS de 
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date > now() AND e.emp_no  like '1%';

/* 'Aamer Garrabrants','Sales'
'Aamer Glowinski','Development'
'Aamer Lambe','Development'
'Aamer Loncour','Development'
'Aamer Luga','Sales'
'Aamer Peha','Development'
'Aamer Slutz','Human Resources'. */


-- Find the name of all departments currently managed by women.
select distinct CONCAT(e.first_name, ' ', e.last_name) as Manager_Name , d.dept_name as Department_Name, Gender as Gender
from employees as e 
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where de.to_date > now() and e.emp_no like '1%'and gender like 'F%';

/*'Aamer Glowinski','Development','F'
'Aamer Lambe','Development','F'
'Aamer Luga','Sales','F'
'Aamer Peha','Development','F'
'Aamer Slutz','Human Resources','F'
'Aamer Warwick','Production','F'
'Aamod Debuse','Sales','F'
'Aamod Domenig','Development','F' */


-- Find the current titles of employees currently working in the Customer Service department.
show columns from departments;
select distinct title, count(*)
from titles
join dept_emp 
on titles.emp_no = dept_emp.emp_no
join departments 
on departments.dept_no = dept_emp.dept_no
where dept_emp.to_date > now()
and titles.to_date > now()
and dept_name = 'customer service'
group by title;

--  Title          Count
/* 'Senior Staff','11268'
   'Staff','3574'
   'Senior Engineer','1790'
   'Engineer','627'
   'Technique Leader','241'
   'Assistant Engineer','68'
   'Manager','1' */

-- Find the current salary of all current managers.

select distinct concat(first_name, last_name) as Full_Name,  salary
from dept_manager as department_manager
join salaries as salaries
using (emp_no)
join employees
using (emp_no)
where department_manager.to_date > now()
and salaries.to_date > now();

/*
'VishwaniMinakawa', '106491'
'IsamuLegleitner', '83457'
'KarstenSigstam', '65400'
'OscarGhazalie', '56654'
'LeonDasSarma', '74510'
'DungPesch', '72876'
'HaukeZhang', '101987'
'HilaryKambil', '79393'
'YuchangWeedman', '58745'
*/


-- Find the number of current employees in each department.
select dept_no, dept_name, count(*) as num_employees
from employees 
join dept_emp as de
using (emp_no)
join departments 
using (dept_no)
where de.to_date > now()
group by dept_name;

/*
'd005', 'Development', '61386'
'd007', 'Sales', '37701'
'd004', 'Production', '53304'
'd003', 'Human Resources', '12898'
'd008', 'Research', '15441'
'd006', 'Quality Management', '14546'
'd001', 'Marketing', '14842'
'd009', 'Customer Service', '17569'
'd002', 'Finance', '12437' */

-- Which department has the highest average salary? Hint: Use current not historic information

select dept_name, avg(salary) as avg_salary
from salaries as s 
join dept_emp as de 
using (emp_no)
join departments 
using (dept_no) 
where de.to_date > now()
and s.to_date > now()
group by dept_name
order by avg_salary desc;

/*'Sales', '88852.9695' */

-- Who is the highest paid employee in the Marketing department?
select first_name, last_name, salary, dept_name
from employees e 
join dept_emp de 
using (emp_no)
join departments d 
using (dept_no)
join salaries s
using (emp_no)
where dept_name = 'marketing'
and de.to_date > now()
and s.to_date > now()
order by salary;

/* 'Akemi', 'Warwick', '145128', 'Marketing' */

-- Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from dept_manager dm
join employees
using (emp_no)
join salaries s
using (emp_no)
join departments
using (dept_no)
where dm.to_date > now()
and s.to_date > now()
order by salary;

/* 'Vishwani', 'Minakawa', '106491', 'Marketing' */


-- Determine the average salary for each department. Use all salary information and round your results.
select dept_name, round(avg(salary), 0) as avg_salary
from salaries
join dept_emp
using (emp_no)
join departments
using (dept_no)
group by dept_name;



