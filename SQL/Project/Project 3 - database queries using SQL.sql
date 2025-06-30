CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

CREATE TABLE IF NOT EXISTS employees (
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

-- A. Basic Metrics

-- 1) Total number of employees
SELECT COUNT(*) AS Total_Employees FROM employees;

-- 2) Total salary expense of the company
SELECT SUM(salary) AS Total_Salary_Expense FROM employees;

-- 3) Average salary across all employees
SELECT ROUND(AVG(salary), 2) AS Average_Salary FROM employees;

-- 4) Gender distribution in the company
SELECT gender, COUNT(*) AS Total FROM employees GROUP BY gender;

-- Insight: Check if gender diversity is balanced

-- 5) Number of employees by department
SELECT department, COUNT(*) AS Total_Employees FROM employees GROUP BY department;

-- B. Departmental Insights

-- 6) Average salary and experience per department
SELECT department, 
       ROUND(AVG(salary), 2) AS Avg_Salary,
       ROUND(AVG(experience), 2) AS Avg_Experience
FROM employees
GROUP BY department;

-- Insight: To compare performance and compensation across departments

-- 7) Highest and lowest salaries per department
SELECT department,
       MAX(salary) AS Max_Salary,
       MIN(salary) AS Min_Salary
FROM employees
GROUP BY department;

-- 8) Departments with average salary above company average
SELECT department, ROUND(AVG(salary), 2) AS Avg_Dept_Salary
FROM employees
GROUP BY department
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- C. Advanced Analysis

-- 9) Top 5 highest-paid employees
SELECT distinct name, department, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;

-- 10) Most experienced employee(s)
SELECT distinct * 
FROM employees
WHERE experience = (SELECT MAX(experience) FROM employees);

-- 11) Employees earning above their department average
SELECT distinct e.name, e.department, e.salary
FROM employees e
JOIN (
    SELECT department, AVG(salary) AS avg_dept_salary
    FROM employees
    GROUP BY department
) d ON e.department = d.department
WHERE e.salary > d.avg_dept_salary;

-- Insight: These are top earners in their respective departments

-- 12) Employees eligible for promotion (e.g., >5 years experience AND above avg salary)
SELECT distinct name, department, experience, salary
FROM employees
WHERE experience > 5
  AND salary > (SELECT AVG(salary) FROM employees);

-- D. Location-based Insights

-- 13) Number of employees by location
SELECT location, COUNT(*) AS Total_Employees
FROM employees
GROUP BY location;

-- 14) Average salary by location
SELECT location, ROUND(AVG(salary), 2) AS Avg_Salary
FROM employees
GROUP BY location;

-- Insight: Helps identify cost of labor across locations

-- 15) Employees in New York earning above 70,000
SELECT distinct * 
FROM employees 
WHERE location = 'New York' AND salary > 70000;

-- 16) Salary range buckets
SELECT 
    CASE 
        WHEN salary < 40000 THEN 'Low'
        WHEN salary BETWEEN 40000 AND 70000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryRange,
    COUNT(*) AS Total_Employees
FROM employees
GROUP BY SalaryRange;

-- Insight: Salary distribution for organizational planning

-- 17) Experience quartile
SELECT distinct name, department, salary, experience,
       NTILE(4) OVER (ORDER BY experience DESC) AS Experience_Quartile
FROM employees;

-- Insight: Identifies top 25% most experienced employees

-- 18) Department-wise gender ratio
SELECT department, gender, COUNT(*) AS Total
FROM employees
GROUP BY department, gender
ORDER BY department;