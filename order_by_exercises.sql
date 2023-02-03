/*Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned 
by first name. In your comments, answer: What was the first and last name in the first row of the results? 
What was the first and last name of the last person in the table?

'Irena', 'Reutenauer'
'Vidya', 'Simmen'


Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned 
by first name and then last name. In your comments, answer: What was the first and last name in the 
first row of the results? What was the first and last name of the last person in the table?

'Vidya', 'Awdeh'
'Maya', 'Melter'



Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned 
by last name and then first name. In your comments, answer: What was the first and last name in the 
first row of the results? What was the first and last name of the last person in the table?

'Vidya', 'Awdeh'
'Maya', 'Melter'


Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their employee number. Enter a comment with the number of employees returned, 
the first employee number and their first and last name, and the last employee number with their first and last name.

899
'10021', 'Ramzi', 'Erde'
'499648',  'Tadahiro', 'Erde', 



Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their hire date, so that the newest employees are listed first. 
Enter a comment with the number of employees returned, the name of the newest employee, 
and the name of the oldest employee.

899
'Teiji', 'Eldridge'
'Sergi', 'Erde'


Find all employees hired in the 90s and born on Christmas. Sort the results so 
that the oldest employee who was hired last is the first result. 
Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
and the name of the youngest employee who was hired first.
362
 '1952-12-25', 'Khun', 'Bernini', 'M', '1999-08-31'
 '1964-12-25', 'Douadi', 'Pettis', 'M', '1990-05-04'

*/

Select first_name, last_name
from employees
where first_name = 'Irena' OR
first_name =  'Vidya'OR 
first_name = 'Maya'
Order by first_name;

/*describe employees;
select * from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
AND birth_date like '%-12-25'
Order by birth_date asc, hire_date desc;*/
