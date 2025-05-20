create database employee_db;

use employee_db;

CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    experience INT,
    gender VARCHAR(10),
    location VARCHAR(30)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 1) How many employees are there in the company?
SELECT COUNT(*) AS TotalEmployees FROM employees;

-- 2) What is the average salary of employees in the IT department?
SELECT AVG(salary) AS AvgITSalary FROM employees WHERE department = 'IT';

-- 3) List all employees with more than 5 years of experience.
SELECT * FROM employees WHERE experience > 5;

-- 4) What is the total number of employees in each department?
SELECT department, COUNT(*) AS Total FROM employees GROUP BY department;

-- 5) Which employees earn more than the average salary of all employees?
SELECT * FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 6) What is the highest salary in the HR department?
SELECT MAX(salary) AS HighestHRSalary FROM employees WHERE department = 'HR';

-- 7) List all female employees.
SELECT * FROM employees WHERE gender = 'Female';

-- 8) How many employees work in each location?
SELECT location, COUNT(*) AS Total FROM employees GROUP BY location;

-- 9) Who is the most experienced employee?
SELECT * FROM employees 
ORDER BY experience DESC 
LIMIT 1;

-- 10) Show the total salary expense of the company.
SELECT SUM(salary) AS TotalSalaryExpense FROM employees;

-- 11) List employees from New York with salary above 70000.
SELECT * FROM employees 
WHERE location = 'New York' AND salary > 70000;

-- 12) What is the average experience by department?
SELECT department, AVG(experience) AS AvgExperience 
FROM employees 
GROUP BY department;

-- 13) Show the name and department of the employee with the lowest salary.
SELECT name, department, salary 
FROM employees 
ORDER BY salary ASC 
LIMIT 1;

-- 14) How many male and female employees are there?
SELECT gender, COUNT(*) AS Total FROM employees GROUP BY gender;

-- 15) List all employees sorted by salary in descending order.
SELECT * FROM employees ORDER BY salary DESC;
