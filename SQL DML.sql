CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50) DEFAULT 'INDIA',
    Age INT CHECK (Age >= 0 AND Age <= 99),
    Phone DECIMAL(10)
);

select * from customer;
drop table customer;
truncate table customer;

-- ------------------------------------------------------------------------
-- INSERT INTO
INSERT INTO customer (CustomerID, CustomerName, LastName, Age) 
VALUES (1, 'Shubham', 'Thakur','23'),
		(2, "Jemish", "Sakariya", 22 ),
		(3, "Vivek", "Menapara", 23);
        
-- SQL INSERT INTO SELECT
-- INSERT INTO SELECT statement is used to copy data from one table and insert it into another table
-- INSERT INTO first_table SELECT * FROM second_table;

INSERT INTO employee SELECT * FROM customer; # in this both table must have same number of attributes.
INSERT INTO employee (EmployeeID,FirstName,LastName) SELECT CustomerID, CustomerName, LastName FROM customer;

SELECT * FROM employee;
-- ------------------------------------------------------------------------

-- ------------------------------------------------------------------------
-- UPDATE
-- SQL UPDATE Statement is used to update data in an existing table in the database.
-- The UPDATE statement can update single or multiple columns using the SET clause.
-- The WHERE clause is used to specify the condition for selecting the rows to be updated.
-- If we have not used the WHERE clause then the columns in all the rows will be updated. 

UPDATE customer SET Country="USA" WHERE CustomerID = 1;

-- Updating Multiple Columns 
UPDATE customer SET CustomerName="Jay", Country="AUS" WHERE CustomerID=3;
-- ------------------------------------------------------------------------

-- ------------------------------------------------------------------------
-- DELETE FOROM
-- DELETE is a DML (Data Manipulation Language) command hence operation performed by DELETE can be rolled back or undone.

DELETE FROM customer WHERE CustomerID = 1;
DELETE FROM customer; # removes all the data in table, behaves like truncate.

-- ------------------------------------------------------------------------
# VIEW
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- Note: A view always shows up-to-date data! The database engine recreates the view, every time a user queries it.

CREATE VIEW view_table AS (SELECT FIRST_NAME,SALARY,DEPARTMENT FROM worker);

SELECT * FROM view_table;

DROP VIEW view_table;

-- ------------------------------------------------------------------------
# TRIGGER
-- it can use with insert,update,delete.
-- before/after.
-- https://dev.mysql.com/doc/refman/8.4/en/trigger-syntax.html

CREATE TABLE bank_customer (
    acc_no INTEGER PRIMARY KEY,
    cust_name VARCHAR(20),
    avail_balance DECIMAL
);

CREATE TABLE mini_statement (
    acc_no INTEGER,
    avail_balance DECIMAL,
    FOREIGN KEY (acc_no)
        REFERENCES bank_customer (acc_no)
        ON DELETE CASCADE
); 

insert into bank_customer values (1000, "Fanny", 7000),(1001, "Peter", 12000);

DELIMITER //

CREATE TRIGGER update_bank_cus
BEFORE UPDATE ON bank_customer
FOR EACH ROW
BEGIN
INSERT INTO mini_statement VALUES (OLD.acc_no,OLD.avail_balance);
END;
//

DELIMITER ;

/*
BEGIN
   IF NEW.amount < 0 THEN
	   SET NEW.amount = 0;
   ELSEIF NEW.amount > 100 THEN
	   SET NEW.amount = 100;
   END IF;
END;
*/

/*
CREATE TRIGGER testref BEFORE INSERT ON test1
  FOR EACH ROW
  BEGIN
    INSERT INTO test2 SET a2 = NEW.a1;
    DELETE FROM test3 WHERE a3 = NEW.a1;
    UPDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
  END;
*/

UPDATE bank_customer SET avail_balance = avail_balance + 3000 WHERE acc_no = 1000;

SELECT * FROM bank_customer;
SELECT * FROM mini_statement;

SHOW TRIGGERS;

DROP TRIGGER update_bank_cus;

-- ------------------------------------------------------------------------
# STORE Routine
-- An SQL statement or set of SQL statement that can be stored on database server which can be CALL no. of times.

# STORE PROCEDURE
-- These are routines that contains series of sql statements and procedural logic.
-- often use to perform action like data modification, transaction control, and executing sequence of statemets.
-- https://www.freecodecamp.org/news/how-to-simplify-database-operations-using-mysql-stored-procedures/

-- Exception Handling:-
-- https://dev.mysql.com/doc/refman/8.4/en/declare-handler.html
-- https://www.tutorialspoint.com/mysql/mysql_declare_handler_statement.htm
-- https://www.youtube.com/watch?v=CA4DfaVxMO8&ab_channel=FreeLecturesofCSECourses
/* Syntax
DECLARE handler_action HANDLER
   FOR condition_value
   statement
   
   -- handler_action = CONTINUE || EXIT
*/

# if PROCEDURE Exists
DROP PROCEDURE IF EXISTS worker_name;

-- Without Argument
DELIMITER //

CREATE PROCEDURE worker_name()
BEGIN
SELECT * FROM worker ORDER BY Salary;
END //

DELIMITER ;

call learnmysql.worker_name();

-- With Argument
DELIMITER //

CREATE PROCEDURE get_worker(IN f_name VARCHAR(25))
BEGIN
SELECT * FROM worker WHERE first_name LIKE f_name;
END //

DELIMITER ;

call learnmysql.get_worker("v%");

-- Return output in variable
DELIMITER //

CREATE PROCEDURE get_sum_salary_HR_dep(OUT sum_salary INT)
BEGIN
SELECT SUM(Salary) INTO sum_salary FROM worker GROUP BY DEPARTMENT HAVING DEPARTMENT = "HR";
END //

DELIMITER ;

set @sum_salary = 0;
call learnmysql.get_sum_salary_HR_dep(@sum_salary);
select @sum_salary;

DROP PROCEDURE IF EXISTS get_sum_salary_HR_dep;

-- ------------------------------------------------------------------------
# User Defined Functions
DELIMITER //

CREATE FUNCTION name_of_worker_max_salary() RETURNS VARCHAR(50)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
	DECLARE max_salary VARCHAR(50);
    DECLARE emp_name VARCHAR(50);
    
    SELECT MAX(Salary) INTO max_salary FROM worker;
    SELECT FIRST_NAME INTO emp_name FROM worker WHERE Salary = max_salary;
    
    RETURN emp_name;
END //

DELIMITER ;

SELECT learnmysql.name_of_worker_max_salary();

-- ------------------------------------------------------------------------
# Window Functions
-- It is also knows as analytic functions allow you to perform calculations across a set of rows related to the current row.
-- Defined by OVER() Clouse

-- it gives sum salary with new added column and also give other information.
SELECT *, SUM(salary) OVER() AS sum_salary FROM worker;

SELECT *, SUM(salary) OVER(ORDER BY SALARY) AS sum_salary FROM worker;

-- PARTITION BY works like GROUP BY, But it allow you to see all other details.
SELECT *, MAX(salary) OVER(PARTITION BY DEPARTMENT) AS max_salary FROM worker;

-- ROW_NUMBER() it add each row number
SELECT *, ROW_NUMBER() OVER() FROM worker;

-- RANK() it will give rank to each record based on OVER() condition
SELECT *, RANK() OVER(ORDER BY salary DESC) FROM worker;

-- DENSE_RANK()
SELECT *, RANK() OVER(ORDER BY DEPARTMENT) FROM worker; -- in this case it will skip rank num if same rank occures
SELECT *, DENSE_RANK() OVER(ORDER BY DEPARTMENT) FROM worker;

-- LAG() -- it means one behind
SELECT *, LAG(DEPARTMENT) OVER() FROM worker;

-- LEAD() -- it means one ahead
SELECT *, LEAD(DEPARTMENT) OVER() FROM worker;