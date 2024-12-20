/*Problem Statement:
You are the database developer of an international bank. You are responsible for
managing the bank’s database. You want to use the data to answer a few
questions about your customers regarding withdrawal, deposit and so on,
especially about the transaction amount on a particular date across various
regions of the world. Perform SQL queries to get the key insights of a customer.*/

--Dataset:
--The 3 key datasets for this case study are:

--a. Continent: The Continent table has two attributes i.e., region_id and region_name, where region_name consists
--of different continents such as Asia, Europe, Africa etc., assigned with the unique region id.

--b. Customers: The Customers table has four attributes named customer_id, region_id, start_date and end_date 
--which consists of 3500 records.

--c. Transaction: Finally, the Transaction table contains around 5850 records and has four attributes named 
--customer_id, txn_date, txn_type and txn_amount.

-------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE CASESTUDY3;

SELECT * FROM Continent;
SELECT * FROM Customers;
SELECT * FROM Transactions;

--1. Display the count of customers in each region who have done the transaction in the year 2020.

SELECT C.region_id, COUNT(DISTINCT T.customer_id) AS customer_count
FROM Customers C
JOIN Transactions T ON C.customer_id = T.customer_id
WHERE YEAR(T.txn_date) = 2020
GROUP BY C.region_id;

--2. Display the maximum and minimum transaction amount of each transaction type.

SELECT txn_type, MAX(txn_amount) AS MaxTransation, MIN(txn_amount) AS MinTransaction FROM Transactions GROUP BY txn_type;

--3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.

SELECT T.customer_id, C.region_name, T.txn_amount
FROM Transactions T
JOIN Customers CU ON T.customer_id = CU.customer_id
JOIN Continent C ON CU.region_id = C.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount > 2000;

--4. Find duplicate records in the Customer table.

SELECT customer_id, region_id, start_date, end_date, COUNT(*) AS COUNTS
FROM Customers
GROUP BY customer_id, region_id, start_date, end_date
HAVING COUNT(*) > 1;

--5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.

SELECT T.customer_id, C.region_name, T.txn_type, T.txn_amount
FROM Transactions T
JOIN Customers CU ON T.customer_id = CU.customer_id
JOIN Continent C ON CU.region_id = C.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount = 
(SELECT MIN(txn_amount) FROM Transactions WHERE txn_type = 'deposit');

--6. Create a stored procedure to display details of customers in the Transaction table where the transaction 
--   date is greater than Jun 2020.

CREATE PROCEDURE DISPLAY 
AS
SELECT * FROM Transactions WHERE txn_date > '2020-06-30';

EXEC DISPLAY;

--7. Create a stored procedure to insert a record in the Continent table.

CREATE PROCEDURE INSERT_Continent (@region_id INT, @region_name VARCHAR(20))
AS
INSERT INTO Continent VALUES
(@region_id, @region_name);

EXEC INSERT_Continent 

--8. Create a stored procedure to display the details of transactions that happened on a specific day.

CREATE PROCEDURE DISPLAY_T (@DAY DATE)
AS
SELECT * FROM Transactions WHERE txn_date = @DAY;   

EXEC DISPLAY_T '2020-01-25' 

--9. Create a user defined function to add 10% of the transaction amount in a table.

CREATE FUNCTION ADD_10_PERCENT(@AMOUNT DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @AMOUNT * 1.10
END;

--10. Create a user defined function to find the total transaction amount for a given transaction type.

CREATE FUNCTION TOTAL_TXN_AMT(@txn_type VARCHAR(50))
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @TOTAL_AMT DECIMAL(10,2);
SELECT @TOTAL_AMT = SUM(txn_amount) FROM Transactions WHERE txn_type = @txn_type;
RETURN @TOTAL_AMT
END;

--11. Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type , 
--    txn_amount which will retrieve data from the above table.

CREATE FUNCTION RETRIVE_DATA()
RETURNS TABLE
AS
RETURN
(SELECT C.customer_id, CO.region_id, txn_date, txn_type, txn_amount FROM Transactions T
 JOIN Customers C ON C.customer_id = T.customer_id
 JOIN Continent CO ON CO.region_id = CO.region_id);

--12. Create a TRY...CATCH block to print a region id and region name in a single column.

BEGIN TRY
SELECT region_id+region_name FROM Continent
END TRY
BEGIN CATCH
PRINT 'Error fetching region data'
END CATCH;

--13. Create a TRY...CATCH block to insert a value in the Continent table.

BEGIN TRY
INSERT INTO Continent VALUES (5, 'Australia');
END TRY
BEGIN CATCH
PRINT 'Error inserting data into Continent';
END CATCH;

--14. Create a trigger to prevent deleting a table in a database.

CREATE TRIGGER PREVENT_TABLE_DELETE
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
ROLLBACK;
PRINT 'Deletion of tables is not allowed!'
END; 

--15. Create a trigger to audit the data in a table.

CREATE TRIGGER trg_audit_transaction
ON Transactions
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
INSERT INTO AuditTable (customer_id, txn_date, txn_type, txn_amount, operation)
SELECT customer_id, txn_date, txn_type, txn_amount, 'INSERT'
FROM inserted;
END;

--16. Create a trigger to prevent login of the same user id in multiple pages.




--17. Display top n customers on the basis of transaction type.

SELECT TOP n customer_id, SUM(txn_amount) AS total_amount
FROM Transaction
WHERE txn_type = 'desired_type'
GROUP BY customer_id
ORDER BY total_amount DESC;

--18. Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.

SELECT customer_id,
SUM(CASE WHEN txn_type = 'purchase' THEN txn_amount ELSE 0 END) AS total_purchase,
SUM(CASE WHEN txn_type = 'withdrawal' THEN txn_amount ELSE 0 END) AS total_withdrawal,
SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount ELSE 0 END) AS total_deposit
FROM Transaction
GROUP BY customer_id;

-----------------------------------------------------------------------------------------------------------------------------
SELECT * FROM Continent;
SELECT * FROM Customers;
SELECT * FROM Transactions;