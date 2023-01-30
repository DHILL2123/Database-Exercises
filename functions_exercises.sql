
-- Functions Exercise--
/*Copy the order by exercise and save it as functions_exercises.sql.

Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() 
to combine their first and last name together as a single column named full_name.

Convert the names produced in your last query to all uppercase.

Find all employees hired in the 90s and born on Christmas. Use datediff() 
function to find how many days they have been working at the company 
(Hint: You will also need to use NOW() or CURDATE()),

Find the smallest and largest current salary from the salaries table.

Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
*/

use employees;
describe employees;

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%e';

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees;

select last_name, upper(last_name)
from employees;

select lower(concat(first_name, last_name)) as user_name;

select * from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
AND birth_date like '%-12-25';

SELECT DATEDIFF(NOW(), hire_date) as days_at_company
FROM employees;

describe salaries;

select min(salary), max(salary)
from salaries
where to_date = '9999-01-1';

select min(salary)
from salaries;

select max(salary)
from salaries;


SELECT Concat(lower(left(first_name, 1)),lower(left(last_name, 4)),('_'),substr(birth_date,3,2), substr(birth_date, 6,2))'UserName', first_name, last_name
FROM employees;


-- class example --
select lower(Concat(
substr(first_name, 1,1),
substr(last_name, 1,4),
'_',
lpad(month(birth_date), 2, 0),
substr(birth_date, 3,2)))
as username
from employees;

