create database TASK;

USE TASK;

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
 (004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
 (005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
 (006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
 (007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
 (008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
 
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker (WORKER_ID)
        ON DELETE CASCADE
-- ON DELETE CASCADE :- If we do not add this then it will no able to delete record from it parent tabel due to reference, 
-- But with this if we delete parent record then it will automatically delete it child reference record
);

# Both of them are used with foreign key
# when delete/update perform in parent it delete/update in child.
-- ON DELETE CASCADE || ON UPDATE CASCADE

# when delete/update perform in parent it SET NULL in child.
-- ON DELETE SET NULL || ON UPDATE SET NULL

INSERT INTO Bonus
 (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
 (001, 5000, '16-02-20'),
 (002, 3000, '16-06-11'),
 (003, 4000, '16-02-20'),
 (001, 4500, '16-02-20'),
 (002, 3500, '16-06-11');

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker (WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
 (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');
 
SELECT * FROM bonus;
SELECT * FROM worker;
SELECT * FROM title;
drop table bonus;
drop table worker;
drop table title;

-- ------------------------------------------------------------------------------
# Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME AS WORKER_NAME FROM worker;

# Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UCASE(FIRST_NAME) FROM worker;

# Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT(department) FROM worker;

# Q-4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.
SELECT LEFT(FIRST_NAME,3) FROM worker; 

# Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
SELECT POSITION("a" IN FIRST_NAME) FROM worker WHERE FIRST_NAME = "Amitabh";
SELECT LOCATE("a",FIRST_NAME) FROM worker WHERE FIRST_NAME = "Amitabh";

# Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM worker;

# Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(DEPARTMENT) FROM worker;

# Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT(DEPARTMENT), CHAR_LENGTH(DEPARTMENT) FROM worker;

# Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME,"a","A") FROM worker;

# Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.
SELECT CONCAT(FIRST_NAME," ", LAST_NAME) AS COMPLETE_NAME FROM worker;

# Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker ORDER BY FIRST_NAME;

# Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker ORDER BY FIRST_NAME DESC;

# Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE FIRST_NAME = "Vipul" OR FIRST_NAME = "Satish";

# Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE FIRST_NAME != "Vipul" AND FIRST_NAME != "Satish";

# Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
SELECT * FROM worker WHERE DEPARTMENT = "Admin";

# Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM worker WHERE FIRST_NAME LIKE "%a%";

# Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM worker WHERE FIRST_NAME LIKE "%a";

# Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE FIRST_NAME LIKE "_____h";

# Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM worker WHERE SALARY BETWEEN 100000 AND 500000;

# Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM worker WHERE MONTH(JOINING_DATE) = 2 AND YEAR(JOINING_DATE) = 2014;

# Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT COUNT(*) FROM worker WHERE DEPARTMENT = "Admin";

# Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
SELECT FIRST_NAME FROM worker WHERE SALARY >= 50000 AND SALARY <= 100000;

# Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT DEPARTMENT, COUNT(*) FROM worker GROUP BY DEPARTMENT ORDER BY COUNT(*) DESC;

# Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM worker INNER JOIN title ON worker.worker_ID = title.worker_ref_id WHERE worker_title = "Manager";

# Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
-- SELECT DEPARTMENT FROM worker GROUP BY DEPARTMENT;

# Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM worker WHERE worker_id % 2 != 0;

# Q-27. Write an SQL query to show only even rows from a table.
SELECT * FROM worker WHERE worker_id % 2 = 0;

# Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE new_worker AS SELECT * FROM worker; # it clone with all rows.

CREATE TABLE new_worker LIKE worker; # it create structure of table.
INSERT INTO new_worker SELECT * FROM worker; # so, for copy all row need to use this.

drop table new_worker;
DESC new_worker;

# Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT * FROM worker INNER JOIN title ON worker.worker_id = title.worker_ref_id;

# Q-30. Write an SQL query to show records from one table that another table does not have.
SELECT * FROM worker WHERE worker_id NOT IN(SELECT worker_ref_id FROM title);

# Q-31. Write an SQL query to show the current date and time.
SELECT LOCALTIME(); 
SELECT CURRENT_TIMESTAMP();
SELECT NOW();

# Q-32. Write an SQL query to show the top n (say 3) records of a table.
SELECT * FROM worker LIMIT 3;

# Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 4,1;

# Q-34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.
WITH temp_worker AS (SELECT SALARY, ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS "rownum" FROM worker) SELECT SALARY FROM temp_worker WHERE rownum = 5;
SELECT *, RANK() OVER(ORDER BY Salary DESC) FROM worker LIMIT 4,1;

# Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT w1.* FROM worker AS w1 INNER JOIN worker AS w2 ON w1.salary = w2.salary AND w1.worker_id != w2.worker_id;

# Q-36. Write an SQL query to show the second highest salary from a table.
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 1,1;

# Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM worker UNION ALL SELECT * FROM worker;

# Q-39. Write an SQL query to fetch the first 50% records from a table.
WITH new_worker AS (SELECT *,ROW_NUMBER() OVER() AS "rownum" FROM worker) SELECT * FROM new_worker WHERE rownum <= (SELECT COUNT(rownum)/2 FROM worker);

# Q-40. Write an SQL query to fetch the departments that have less than five people in it.
SELECT DEPARTMENT,COUNT(*) FROM worker GROUP BY DEPARTMENT HAVING COUNT(*) < 5;

# Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT,COUNT(*) FROM worker GROUP BY DEPARTMENT;

# Q-42. Write an SQL query to show the last record from a table.
WITH new_worker AS (SELECT *, ROW_NUMBER() OVER() AS "rownum" FROM worker) SELECT * FROM new_worker WHERE rownum = (SELECT MAX(rownum) FROM new_worker);
SELECT *, ROW_NUMBER() OVER() AS "rownum" FROM worker ORDER BY rownum DESC LIMIT 1;

# Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM worker LIMIT 1;

# Q-44. Write an SQL query to fetch the last five records from a table.
WITH new_worker AS (SELECT *, ROW_NUMBER() OVER() AS "rownum" FROM worker) SELECT * FROM new_worker WHERE rownum > (SELECT COUNT(rownum) FROM new_worker) - 5;
SELECT *, ROW_NUMBER() OVER() AS "rownum" FROM worker ORDER BY rownum DESC LIMIT 0,5;
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 5;

# Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT FIRST_NAME FROM worker WHERE SALARY = ANY (SELECT MAX(SALARY) FROM worker GROUP BY DEPARTMENT);

# Q-46. Write an SQL query to fetch three max salaries from a table.
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 3;

# Q-47. Write an SQL query to fetch three min salaries from a table.
SELECT * FROM worker ORDER BY SALARY LIMIT 3;

# Q-48. Write an SQL query to fetch nth max salaries from a table.
SELECT * FROM worker ORDER BY SALARY DESC LIMIT 4,1;

# Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT,SUM(SALARY) FROM worker GROUP BY DEPARTMENT;

# Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME FROM worker ORDER BY SALARY DESC LIMIT 1;