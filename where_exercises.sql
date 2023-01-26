/*Create a file named where_exercises.sql. Make sure to use the employees database.

Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
--709
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
--441, 
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
--241 only returned the first true in the OR statement didnt reconize any other parameters after.
Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
--1000
Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
--1000 starts with E 1000 ends with E
Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
--899, 1000
Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
--1000
Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
--789
Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
--362
Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
--1873
Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
--547
*/
use employees;
describe employees;
SELECT hire_date



   