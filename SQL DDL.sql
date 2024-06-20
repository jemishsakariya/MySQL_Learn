CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY NOT NULL UNIQUE,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT, # Auto-increment allows a unique number to be generated automatically when a new record is inserted into a table.
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50) DEFAULT "INDIA",
    Age INT CHECK (Age >= 0 AND Age <= 99),
    Phone INT,
    CONSTRAINT mob_num_must_be_length_of_10 CHECK (LENGTH(Phone) = 10) # it is called named constrained is use for desc error that occur from this check
);

DESC customer;

# check constains
SELECT CONSTRAINT_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = "employee";

# Date And Time in table.
CREATE TABLE dateandtime(
	id INT PRIMARY KEY,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);
SELECT * FROM dateandtime;
INSERT INTO dateandtime(id) VALUES (1);
UPDATE dateandtime SET id = 2 WHERE id = 1;

# Important Points About SQL CREATE TABLE Statement
-- The DESC table_name; command can be used to display the structure of the created table.
-- We can also add constraint to table like "NOT NULL, UNIQUE, CHECK, and DEFAULT, AUTO_INCREMENT."
-- If you try to create a table that already exists, MySQL will throw an error. To avoid this, you can use the CREATE TABLE IF NOT EXISTS syntax.

-- foreign key constrains, FOREIGN KEY (ID) REFERENCES Customers(ID).

-- To let the AUTO_INCREMENT sequence start with another value, use the following SQL statement:
ALTER TABLE Customer AUTO_INCREMENT=100;

INSERT INTO Customer (CustomerID, CustomerName, LastName, Country, Age, Phone)
VALUES (1, 'Shubham', 'Thakur', 'India','23',1234567890),
       (2, 'Aman ', 'Chopra', 'Australia','21',1234567890),
       (3, 'Naveen', 'Tulasi', 'Sri lanka','24',1234567890),
       (4, 'Aditya', 'Arpan', 'Austria','21',1234567890),
       (5, 'Nishant. Salchichas S.A.', 'Jain', 'Spain','22',1234567890);
       
       
# SQL DROP Statement
-- Completely removes a table or database from the database, including the data and structure.
-- Is a permanent operation and cannot be rolled back.
-- Removes integrity constraints and indexes associated with the table.
-- Is slower compared to the TRUNCATE statement.

# SQL TRUNCATE Statement
-- Removes all the rows or data from a table, but preserves the table structure and columns.
-- Is a faster operation compared to the DROP statement.
-- Resets the identity column (if any) back to its seed value.
-- Does not remove integrity constraints associated with the table.
-- Can be rolled back, unlike the DROP statement.

show tables;
select * from customer;
drop table Employee; # it delete whole table
drop table customer;
truncate table customer; # it delete table all tupels.(table structure is remains)

-- DROP TABLE table_name;
-- DROP DATABASE database_name;
-- TRUNCATE TABLE table_name;


# SQL ALTER TABLE command can add, delete, or modify columns of an existing table.
-- The ALTER TABLE statement is also used to add and remove various constraints on existing tables.

-- ADD – To add a "new column" to the table:
ALTER TABLE customer ADD (abc int,xyz varchar(10));

-- MODIFY/ALTER – To change the data type of an existing column:
ALTER TABLE customer MODIFY xyz varchar(50);

-- RENAME COLUMN – To rename an existing column:
ALTER TABLE customer RENAME COLUMN xyz TO abcxyz;

-- RENAME TO – To rename the table itself:
ALTER TABLE customer RENAME TO customerInfo;

-- DROP – To delete an existing column from the table:
ALTER TABLE customer DROP COLUMN abc;
ALTER TABLE customer DROP COLUMN abcxyz;

-- ------------------------------------------------------------------------
# CASCADE

CREATE TABLE Course (
    cno INT PRIMARY KEY,
    cname VARCHAR(20)
);

INSERT INTO Course(cno, cname) 
 VALUES(101,'c'),
       (102,'c++'),
       (103,'DBMS');
       
SELECT * FROM Course;

CREATE TABLE Enroll (
    cno INT,
    jdate DATE,
    FOREIGN KEY (cno)
        REFERENCES Course (cno)
        ON DELETE SET NULL
);

INSERT INTO Enroll(cno,jdate) 
 VALUES(101, '2008-11-11'),
       (102, '2008-11-12'),
       (103, '2008-11-13');
       
SELECT * FROM Enroll;

DELETE FROM Course WHERE cno = 101;

drop table Course;
drop table Enroll;

-- ----------------------------------------------------------------------
## indexes

# Creating prefix indexes
-- To create a prefix index in MySQL, you have to specify the prefix length you want to index. 
-- Suppose we have a worker table with a string column for the first name, and we want to index the first five characters only:

ALTER TABLE worker ADD INDEX (first_name(5));

SHOW INDEXES FROM worker;

DROP INDEX first_name ON worker; 

# Composite indexes / Multi Columns indexes
-- Rules for composite indexes
-- 1. Left-to-right, no skipping: MySQL can only access the index in order, starting from the leftmost column and moving to the right. It can't skip columns in the index.
-- 2. Stops at the first range: MySQL stops using the index after the first range condition encountered.

ALTER TABLE worker ADD INDEX multikey_index (first_name,last_name,salary);

SHOW INDEXES FROM worker;

EXPLAIN SELECT * FROM worker WHERE first_name = 'Vishal' AND last_name = 'Singhal'; -- key_len = 202
EXPLAIN SELECT * FROM worker WHERE first_name = 'Vishal' AND last_name = 'Singhal' AND salary = 300000; -- key_len = 207
-- IF The key length remains 202 bytes, meaning MySQL doesn't use the salary part of the index.

# Covering indexes
-- index covers the entire set of requirements for a single query.

EXPLAIN analyze SELECT first_name,last_name,salary from worker;

# Functional indexes
-- Function-based indexes are used in cases where you need to create an index on a function rather than a column.

ALTER TABLE worker ADD INDEX idx_month_joining ((MONTH(JOINING_DATE)));

EXPLAIN ANALYZE SELECT * FROM worker WHERE MONTH(JOINING_DATE) = 6;

# Indexing for wildcard searches
-- wildcards use index when it is at the end like "a%".

ALTER TABLE worker ADD INDEX (first_name);

EXPLAIN SELECT * FROM worker WHERE first_name LIKE 'v%';

# Fulltext indexes
-- it uses text search on created index

ALTER TABLE products ADD FULLTEXT INDEX fulltextindex (productname);

EXPLAIN ANALYZE SELECT * FROM products WHERE MATCH(productname) AGAINST("chef"); -- Natural language mode

SELECT * FROM products WHERE MATCH(productname) AGAINST("+chef -mix" IN BOOLEAN MODE);

SELECT productname, MATCH(productname) AGAINST("+chef -mix" IN BOOLEAN MODE) FROM products; -- it gives Score of search

SELECT * FROM products WHERE MATCH(productname) AGAINST('"Chef Anton\'s Gumbo Mix"'); -- "" for exact match

# Invisible indexes
-- it will stop using index.

ALTER TABLE worker ALTER INDEX FIRST_NAME INVISIBLE;

SHOW INDEX FROM worker;

ALTER TABLE worker ALTER INDEX FIRST_NAME VISIBLE;

# Hints
-- Force index to use specific index
EXPLAIN ANALYZE SELECT first_name FROM worker; -- it uses FIRST_NAME index
EXPLAIN ANALYZE SELECT first_name FROM worker USE INDEX(multikey_index); -- it uses multikey_index

EXPLAIN ANALYZE SELECT first_name FROM worker IGNORE INDEX(FIRST_NAME,multikey_index); -- it will ignore both index

# UNIQUE index
-- it created on unique values only.
ALTER TABLE products ADD UNIQUE INDEX price(price);
explain analyze select * from products where price between 19 and 25;