/*Create a new SQL script named limit_exercises.sql.

MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
For example, to find all the unique titles within the company, we could run the following query:


SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order.
'Zykh'
'Zyda'
'Zwicker'
'Zweizig'
'Zumaque'
'Zultner'
'Zucker'
'Zuberek'
'Zschoche'
'Zongker'

Find all previous or current employees hired in the 90s and born on Christmas. 
-362
Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to 
the first 5 records. Write a comment in your code that lists the five names of the employees returned.
'1990-01-01','1953-01-24','Aiman','Hainaut'
'1990-01-01','1964-10-24','Lillian','Stiles'
'1990-01-01','1953-02-25','Teruyuki','Sridhar'
'1990-01-01','1961-03-05','Sashi','Demeyer'
'1990-01-01','1961-01-08','Tomofumi','Rattan'

Try to think of your results as batches, sets, or pages. The first five results are your 
first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
'1990-01-01','1956-02-05','Yongdong','Msuda'
'1990-01-01','1954-03-07','Dipayan','Frolund'
'1990-01-01','1955-09-08','Rosine','Encarnacion'
'1990-01-01','1961-03-05','Sashi','Demeyer'
'1990-01-01','1957-10-11','Rafols','Melski'

LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship 
between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-limit allows you to limit the rows and offset allows you to set the sequence of the limited rows, and the page number 
corrisponds to the set limit/offset. limit 5(page 1) offset 1(page 2) 

*/

use employees;
describe employees;

/*SELECT
hire_date, birth_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';*/

  

Select 
hire_date, birth_date, first_name, last_name
from employees
where hire_date between '1990-01-01' and '1999-12-31' 
Order by hire_date asc
limit 5 Offset 45;
