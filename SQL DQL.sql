CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Age DECIMAL(2),
    Phone DECIMAL(10)
);

INSERT INTO Customer (CustomerID, CustomerName, LastName, Country, Age, Phone)
VALUES (1, 'Shubham', 'Thakur', 'India','23',1234567890),
       (2, 'Aman ', 'Chopra', 'Australia','21',1234567890),
       (3, 'Naveen', 'Tulasi', 'Sri lanka','24',1234567890),
       (4, 'Aditya', 'Arpan', 'Austria','21',1234567890),
       (5, 'Nishant. Salchichas S.A.', 'Jain', 'Spain','22',1234567890);

select * from customer;
drop table customer;

# Alias
SELECT customerName AS C_Name FROM customer;

# SELECT
SELECT CustomerID, CustomerName FROM customer;

SELECT CustomerName FROM customer WHERE Age = 22;

# SELECT DISTINCT
SELECT DISTINCT Age from customer;
SELECT DISTINCT Phone, Age from customer;

-- GROUP BY Clause
SELECT Age, COUNT(*) FROM customer GROUP BY Age ORDER BY Age ASC;

-- ------------------------------------------------------------------------------------
# JOINS
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);

INSERT INTO Worker
 (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE,
 DEPARTMENT) VALUES
 (001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
 (002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
 (003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
 (005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
 (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
 (007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
 (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
 
 CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME
);

INSERT INTO Title
 (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (004, 'Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

SELECT * FROM worker;
SELECT * FROM title;
drop table worker;
drop table title;

# self JOIN
SELECT * FROM worker, title;

# CROSS JOIN
-- Note: The CROSS JOIN keyword returns all matching records from both tables whether the other table matches or not. 
-- So, if there are rows in "worker" that do not have matches in "title", or if there are rows in "title" that do not have matches in "worker", 
-- those rows will be listed as well.

SELECT * FROM worker CROSS JOIN title;

# INNER JOIN
-- Note: The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns. 
-- If there are records in the "title" table that do not have matches in "worker", these orders will not be shown!

SELECT * FROM worker INNER JOIN title ON worker.WORKER_ID = title.WORKER_REF_ID;

SELECT DEPARTMENT,SUM(SALARY) FROM worker INNER JOIN title ON worker.WORKER_ID = title.WORKER_REF_ID GROUP BY DEPARTMENT;

# LEFT JOIN
-- Note: The LEFT JOIN keyword returns all records from the left table (worker), even if there are no matches in the right table (title).
SELECT * FROM worker LEFT JOIN title ON worker.WORKER_ID = title.WORKER_REF_ID;

# RIGHT JOIN
-- Note: The LEFT JOIN keyword returns all records from the right table (title), even if there are no matches in the right table (worker).
SELECT * FROM title RIGHT JOIN worker ON worker.WORKER_ID = title.WORKER_REF_ID;

-- ----------------------------------------------------------------------------------------------------------------------------------------
# HAVING
-- It is used like WHERE But with GROUP BY
SELECT DEPARTMENT,SUM(SALARY) FROM worker GROUP BY DEPARTMENT HAVING SUM(SALARY) > 300000;

# WITH ROLLUP 
-- It will add new row of total SUM. it used with GROUP BY.
SELECT IFNULL(DEPARTMENT,"TOTAL"),SUM(SALARY) FROM worker GROUP BY DEPARTMENT WITH ROLLUP;
