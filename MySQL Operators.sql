CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(50),
    Price DECIMAL(10 , 2 )
);

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES
    (1, 'Chais', 1, 1, '10 boxes x 20 bags', 18),
    (2, 'Chang', 1, 1, '24 - 12 oz bottles', 19),
    (3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10),
    (4,	"Chef Anton's Cajun Seasoning", 2, 2, "48 - 6 oz jars",	22),
	(5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35),
    (6, 'Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25),
    (7, 'Uncle Bob''s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30),
    (8, 'Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40),
    (9, 'Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT
);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
    (1, 10248, 11, 12),
    (2, 10248, 42, 10),
    (3, 10248, 72, 5),
    (4, 10249, 14, 9),
    (5, 10249, 51, 40),
    (6, 10250, 41, 10),
    (7, 10250, 51, 35),
    (8, 10250, 65, 15),
    (9, 10251, 22, 6),
    (10, 10251, 57, 15);

select * from Products;
select * from OrderDetails;
drop table Products;
drop table OrderDetails;

-- -----------------------------------------------------------------------------
# ANY and ALL Operators
-- ANY means that the condition will be true if the operation is true for any of the values in the range.
-- ALL means that the condition will be true only if the operation is true for all values in the range.

SELECT ProductName 
FROM Products
WHERE ProductID = ANY (SELECT OrderDetailID FROM OrderDetails WHERE Quantity = 10);

SELECT ProductName 
FROM Products
WHERE ProductID > ALL (SELECT OrderDetailID FROM OrderDetails WHERE Quantity = 10);

-- -----------------------------------------------------------------------------
# NOT
SELECT * FROM orderdetails WHERE NOT OrderID = 10248;

# BETWEEN
SELECT * FROM orderdetails WHERE ProductID BETWEEN 40 AND 50;

# EXISTS
SELECT * FROM Products WHERE EXISTS (SELECT OrderDetailID FROM orderdetails WHERE OrderDetails.OrderDetailID = Products.ProductID AND Quantity = 10);

# IN / NOT IN
-- The IN operator is a shorthand for multiple OR conditions.
SELECT * FROM products WHERE ProductID IN(1,2,3);
SELECT * FROM products WHERE ProductID NOT IN(1,2,3);

SELECT * FROM products WHERE ProductID IN(SELECT OrderdetailID FROM orderdetails WHERE Quantity = 10);

# SOME
-- SOME must match at least one row in the subquery and must be preceded by comparison operators.
SELECT * FROM Products
WHERE Price > SOME (SELECT Price FROM Products WHERE Price > 22);

# LIKE
-- https://www.w3schools.com/mysql/mysql_like.asp
SELECT * FROM products WHERE ProductName LIKE "%x%"; -- x in any position in productName
SELECT * FROM products WHERE ProductName NOT LIKE "%c%";

SELECT * FROM products WHERE ProductName LIKE "a%"; -- starts with a
SELECT * FROM products WHERE ProductName LIKE "%s"; -- ends with s
SELECT * FROM products WHERE ProductName LIKE "_h%"; -- Finds any values that have "h" in the second position
SELECT * FROM products WHERE ProductName LIKE "c_____%"; -- Finds any values that start with "c" and are at least 5 characters in length
SELECT * FROM products WHERE ProductName LIKE "c%g"; -- Finds any values that start with "c" and ends with "g"

-- -----------------------------------------------------------------------------
# LIMIT and OFFSET
SELECT * FROM products LIMIT 3 OFFSET 2; -- 2 skip then limit 3 row.

SELECT * FROM products LIMIT 3, 2; -- want to see third row to 2 row(range of records).

# ORDER BY
-- it use to sort data
SELECT * FROM products ORDER BY Price; -- ASC
SELECT * FROM products ORDER BY Price DESC; -- DESE

-- -----------------------------------------------------------------------------
# COUNT / AVG / SUM / MAX / MIN
SELECT COUNT(*) FROM products;

SELECT AVG(price) FROM products;

SELECT SUM(price) FROM products;

SELECT MIN(Price) AS SmallestPrice FROM Products;

SELECT MAX(Price) AS MaxPrice FROM Products;

-- COUNT Unique OrderID from orderdetails
SELECT COUNT(DISTINCT(OrderID)) FROM orderdetails;

-- COUNT OrderID whose productId is from 40 to 60.
SELECT COUNT(DISTINCT(OrderID)) FROM orderdetails WHERE productID BETWEEN 40 AND 60;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------
# GROUP BY
-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

SELECT OrderID, COUNT(*) FROM orderdetails GROUP BY OrderID;

