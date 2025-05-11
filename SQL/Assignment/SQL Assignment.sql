use hr;
create table Company(
CompanyID int,
CompanyName varchar(45),
Street varchar(45),
City varchar(45),
State varchar(45),
Zip varchar(45));
insert into Company values
(1,'Toll Brothers','GH-04','Gandhinagar','Gujarat',345678),
(2,'EY','Prahladnagar','Ahmedabad','Gujarat',356788),
(3,'KPMG','Vesu','surat','Gujarat',567848),
(4,'Mangalam','Iskon Circle','Ahmedabad','Gujarat',789569),
(5,'Urban Outfitters, Inc.','Baleshwar square','Ahmedabad','Gujarat',456789);
select * from Company;

-- 1) Statement to create the Contact table
create table Contact(
ContactID int,
CompanyID int,
FirstName varchar(45),
LastName varchar(45),
Street varchar(45),
City varchar(45),
State varchar(20),
Zip varchar(10),
IsMain boolean,
Email varchar(45),
Phone varchar(12));
insert into Contact values
(21,1,'Priya','Shah','GH-04','Gandhinagar','Gujarat',345678,true,'priya1@gmail.com',1234567890),
(22,2,'Dianne','Connor','Prahladnagar','Ahmedabad','Gujarat',356788,true,'gami2@gmail.com',2345678901),
(23,3,'Rutvi','Dave','Vesu','surat','Gujarat',567848,true,'rutvi3@gmail.com',3456789012),
(24,4,'Manan','Saluja','Iskon Circle','Ahmedabad','Gujarat',789569,true,'mansal14@gmail.com',4567890123),
(25,5,'Lesley','Bland','Baleshwar square','Ahmedabad','Gujarat',456789,true,'birju5@gmail.com',5678901234);
select * from Contact;

-- 2) Statement to create the Employee table
create table Employee(
EmployeeID int,
FirstName varchar(45),
LastName varchar(45),
Salary decimal(10.2),
HireDate date,
JobTitle varchar(25),
Email varchar(45),
phone varchar(12));
insert into Employee values
(41,'Priya','Shah',10000,'2011-04-14','Data Scientist','priya1@gmail.com',1234567890),
(42,'Dianne','Connor',20000,'2013-07-22','Software Engineer','gami2@gmail.com',2345678901),
(43,'Rutvi','Dave',30000,'2012-02-28','Web developer','rutvi3@gmail.com',3456789012),
(44,'Manan','Saluja',40000,'2014-12-03','Data Analyst','mansal14@gmail.com',4567890123),
(45,'Lesley','Bland',50000,'2016-10-16','System Engineer','birju5@gmail.com',5678901234);
select*from Employee;

-- 3) Statement to create the ContactEmployee table.
create table ContactEmployee(
ContactEmployeeID int,
ContactID int,
EmployeeID int,
ContactDate date,
Description varchar(100));
insert into ContactEmployee values
(31,21,41,'2011-01-01','Data Scientist'),
(32,22,42,'2013-01-01','Software Engineer'),
(33,23,43,'2012-01-01','Web developer'),
(34,24,44,'2014-01-01','Data Analyst'),
(35,25,45,'2016-01-01','System Engineer');
select*from Contactemployee;

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800
UPDATE employee
SET phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” .
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyName = 'Urban Outfitters, Inc.';

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
DELETE FROM Contactemployee
WHERE ContactID = (
    SELECT ContactID FROM Contact
    WHERE FirstName = 'Dianne' AND LastName = 'Connor'
)
AND EmployeeID = (
    SELECT EmployeeID FROM Employee
    WHERE FirstName = 'Jack' AND LastName = 'Lee'
);

-- 7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL SELECT query in MySQL Workbench. Copy the results below as well.
SELECT DISTINCT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';

-- 8) What is the significance of “%” and “_” operators in the LIKE statement?
-- % (Percent Sign) :  Matches zero, one, or multiple characters.
--  _ (Underscore): Matches exactly one single character.
-- Example:
-- LIKE 'M%n' → matches Manan, Moon, Mohan
-- LIKE 'J_n' → matches Jan, Jen, Jon

-- 9) Explain normalization in the context of databases.
-- Normalization is the process of organizing data to reduce redundancy and improve data integrity. 
-- It involves dividing a database into smaller, related tables and defining relationships between them.

-- 10) What does a join in MySQL mean?
-- In MySQL, a Join is used to combine rows from two or more tables based on a related column between them, usually a foreign key. 
-- It allows you to retrieve data that is spread across multiple tables as if it were in a single table.

-- 11) What do you understand about DDL, DCL, and DML in MySQL?
-- DDL (Data Definition Language):
-- Used to define or change the structure of database objects like tables, schemas, etc.
-- Commands: CREATE, ALTER, DROP, TRUNCATE
-- DML (Data Manipulation Language):
-- Used to manipulate data stored in tables.
-- Commands: SELECT, INSERT, UPDATE, DELETE
-- DCL (Data Control Language):
-- Used to control access/permissions to the database.
-- Commands: GRANT, REVOKE

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?
-- JOINs are used to retrieve data from multiple tables based on a logical relationship. 
-- Below are the types of Joins:
-- INNER JOIN – returns matching rows
-- LEFT JOIN – all rows from left table + matching from right
-- RIGHT JOIN – all from right + matching from left
-- FULL JOIN – all rows when there is a match in either table