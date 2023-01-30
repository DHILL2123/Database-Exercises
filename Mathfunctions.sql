use fruits_db;
show tables;
SELECT * FROM fruits;
SELECT * FROM fruits limit 5;
use employees;
SELECT * FROM employees limit 10;
SELECT * FROM fruits_db.fruits;
use fruits_db;
SELECT * FROM employees.employees limit 5;
SELECT * FROM fruits;
SELECT * FROM fruits WHERE name ='cantelope';
SELECT quantity FROM fruits WHERE name = 'apple';
SELECT * FROM fruits;
SELECT * FROM fruits WHERE name LIKE  '%fruit';
SELECT * FROM fruits WHERE name LIKE 'fruit%';
SELECT * FROM fruits WHERE name IN ('apple', 'dragonfruit');

SELECT * FROM fruits
WHERE name IN ('apple', 'dragonfruit')
OR name LIKE '%apple';

SELECT * FROM fruits;
describe fruits;
SELECT * FROM fruits WHERE quantity > 5;
SELECT * FROM fruits WHERE quantity >= 5;
SELECT * FROM fruits WHERE quantity <> 5;
SELECT * FROM fruits WHERE quantity != 5;
SELECT * FROM fruits WHERE quantity BETWEEN 1 AND 4;

SELECT * FROM fruits WHERE name IS NOT NULL;
show databases;
