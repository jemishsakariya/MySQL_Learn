# CONCAT(first_col,sec_col,...) or CONCAT(first_word,sec_word,....)
-- Note: If any of the expressions is a NULL value, it returns NULL.

SELECT CONCAT("SQL ", "Tutorial ", "is ", "fun!") AS ConcatenatedString;

SELECT EmployeeID, CONCAT(FirstName, " ",LastName) AS FullName FROM employee;

SELECT EmployeeID, CONCAT(FirstName, " ",LastName, NULL) AS FullName FROM employee; # Here because of null it returns null.
-- ---------------------------------------------------------------------------
# CONCAT_WS(separator, expression1, expression2, expression3,...)
-- separator - Required. The separator to add between each of the expressions. If separator is NULL, this function returns NULL.
-- expressions- Required. The expressions to add together. An expression with a NULL value will be skipped.

SELECT CONCAT_WS("-", FirstName, LastName, null) FROM employee;

-- ---------------------------------------------------------------------------
# SUBSTRING(string, start, length)
# OR:
# SUBSTRING(string FROM start FOR length)
-- start - Required. The start position Can be both a positive or negative number. If it is a positive number, this function extracts from the beginning of the string.
-- If it is a negative number, this function extracts from the end of the string. 
-- The position of the first character in the string is 1 and the position of the last character in the string is -1.
-- length - Optional. The number of characters to extract. If omitted, the whole string will be returned (from the start position)

SELECT SUBSTRING(FirstName, -2, 2) FROM employee;

-- ---------------------------------------------------------------------------
# REPLACE(string, from_string, new_string)
SELECT REPLACE ("Hi","H","B");

SELECT REPLACE (EmployeeID,1,100) FROM employee;

-- ---------------------------------------------------------------------------
# REVERSE(string)
SELECT REVERSE("Hello");

SELECT REVERSE(FirstName) FROM employee;

-- ---------------------------------------------------------------------------
# UPPER(text) AND LOWER(text) OR UCASE() AND LCASE()
SELECT UPPER("hello"); 
SELECT LOWER("HELLO");

SELECT UPPER(FirstName) FROM employee;
SELECT LOWER(LastName) FROM employee;

-- ---------------------------------------------------------------------------
# CHAR_LENGTH(string) || LENGTH();
SELECT CHAR_LENGTH("abcd");

SELECT FirstName, CHAR_LENGTH(firstname) AS NameLength FROM employee;

SELECT * FROM employee WHERE CHAR_LENGTH(firstname) = 6;

SELECT LENGTH("abcd");
-- ---------------------------------------------------------------------------
# INSERT(string, position, number, string2)
SELECT INSERT('Hello Everyone', 6, 3, 'add');

SELECT INSERT(FirstName, 1, 1, 'A') FROM employee;

-- ---------------------------------------------------------------------------
# LEFT(string, number_of_chars) AND RIGHT(string, number_of_chars)
SELECT LEFT('abcdefg', 3);
SELECT RIGHT('abcdefg', 3);

-- ---------------------------------------------------------------------------
# REPEAT(string, number)
-- SELECT REPEAT('a', 5);

-- ---------------------------------------------------------------------------
# TRIM(string)
SELECT TRIM("  asdas ");

# EXERCISE
SELECT CONCAT_WS(':', employeeID, CONCAT(firstname, " ", lastname)) FROM employee;