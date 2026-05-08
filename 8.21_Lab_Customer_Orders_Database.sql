/*
8.21 | Lab – Customer Orders & Salesperson Database System
MS SQL Server Script
This file contains all DDL and DML statements:
- Database creation
- Tables in 3NF
- Primary keys and foreign keys
- At least 25 INSERT records for each table
- Views
- Function to convert USD to Euro
- Stored procedure to insert a new salesperson
*/

/* =========================================================
   1. CREATE DATABASE
   ========================================================= */

IF DB_ID('CustomerOrdersSalesDB') IS NOT NULL
BEGIN
    ALTER DATABASE CustomerOrdersSalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CustomerOrdersSalesDB;
END;
GO

CREATE DATABASE CustomerOrdersSalesDB;
GO

USE CustomerOrdersSalesDB;
GO

/* =========================================================
   2. CREATE TABLES - 3NF DESIGN
   ========================================================= */

CREATE TABLE SalesPersons (
    SalesPersonID INT NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Customers (
    CustomerID INT NOT NULL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    CustomerState VARCHAR(50) NOT NULL,
    SalesPersonID INT NOT NULL,
    CONSTRAINT FK_Customers_SalesPersons
        FOREIGN KEY (SalesPersonID) REFERENCES SalesPersons(SalesPersonID)
);
GO

CREATE TABLE Orders (
    OrderID INT NOT NULL PRIMARY KEY,
    OrderNumber VARCHAR(20) NOT NULL UNIQUE,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE Items (
    ItemID INT NOT NULL PRIMARY KEY,
    ItemName VARCHAR(100) NOT NULL,
    ItemPriceUSD DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE OrderDetails (
    OrderDetailID INT NOT NULL PRIMARY KEY,
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Items
        FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
);
GO

/* =========================================================
   3. INSERT DATA - AT LEAST 25 RECORDS IN EACH TABLE
   ========================================================= */

INSERT INTO SalesPersons (SalesPersonID, FirstName, LastName) VALUES
(1, 'James', 'Wilson'),
(2, 'Mary', 'Johnson'),
(3, 'Robert', 'Brown'),
(4, 'Linda', 'Davis'),
(5, 'Michael', 'Miller'),
(6, 'Patricia', 'Garcia'),
(7, 'William', 'Martinez'),
(8, 'Barbara', 'Anderson'),
(9, 'David', 'Thomas'),
(10, 'Elizabeth', 'Taylor'),
(11, 'Richard', 'Moore'),
(12, 'Susan', 'Jackson'),
(13, 'Joseph', 'Martin'),
(14, 'Karen', 'Lee'),
(15, 'Thomas', 'Perez'),
(16, 'Nancy', 'Thompson'),
(17, 'Charles', 'White'),
(18, 'Lisa', 'Harris'),
(19, 'Daniel', 'Sanchez'),
(20, 'Betty', 'Clark'),
(21, 'Matthew', 'Ramirez'),
(22, 'Sandra', 'Lewis'),
(23, 'Anthony', 'Robinson'),
(24, 'Ashley', 'Walker'),
(25, 'Mark', 'Young');
GO

INSERT INTO Customers (CustomerID, CustomerName, CustomerState, SalesPersonID) VALUES
(1, 'Green Valley Stores', 'Missouri', 1),
(2, 'Sunrise Market', 'Illinois', 2),
(3, 'Blue Ridge Supplies', 'Texas', 3),
(4, 'River City Retail', 'Missouri', 4),
(5, 'Golden Gate Traders', 'California', 5),
(6, 'Lakeview Grocers', 'Florida', 6),
(7, 'Hilltop Electronics', 'Georgia', 7),
(8, 'Metro Office Mart', 'New York', 8),
(9, 'Oakwood Home Goods', 'Ohio', 9),
(10, 'Prairie Farm Supply', 'Kansas', 10),
(11, 'Capital City Books', 'Virginia', 11),
(12, 'Desert Star Retail', 'Arizona', 12),
(13, 'Evergreen Supplies', 'Washington', 13),
(14, 'Coastal Tech Store', 'California', 14),
(15, 'Maple Street Market', 'Michigan', 15),
(16, 'Pinecrest Outfitters', 'Colorado', 16),
(17, 'Bright Future Academy', 'Missouri', 17),
(18, 'Northside Pharmacy', 'Illinois', 18),
(19, 'Eastwood Furniture', 'Texas', 19),
(20, 'West End Stationers', 'Florida', 20),
(21, 'Central Fitness Shop', 'Georgia', 21),
(22, 'Silverline Clothing', 'New York', 22),
(23, 'Harmony Music Store', 'Ohio', 23),
(24, 'QuickServe Restaurant', 'Kansas', 24),
(25, 'Urban Style Boutique', 'Virginia', 25);
GO

INSERT INTO Orders (OrderID, OrderNumber, OrderDate, CustomerID) VALUES
(1, 'ORD-1001', '2026-01-05', 1),
(2, 'ORD-1002', '2026-01-07', 2),
(3, 'ORD-1003', '2026-01-10', 3),
(4, 'ORD-1004', '2026-01-12', 4),
(5, 'ORD-1005', '2026-01-15', 5),
(6, 'ORD-1006', '2026-01-17', 6),
(7, 'ORD-1007', '2026-01-20', 7),
(8, 'ORD-1008', '2026-01-22', 8),
(9, 'ORD-1009', '2026-01-25', 9),
(10, 'ORD-1010', '2026-01-27', 10),
(11, 'ORD-1011', '2026-02-01', 11),
(12, 'ORD-1012', '2026-02-03', 12),
(13, 'ORD-1013', '2026-02-06', 13),
(14, 'ORD-1014', '2026-02-08', 14),
(15, 'ORD-1015', '2026-02-10', 15),
(16, 'ORD-1016', '2026-02-12', 16),
(17, 'ORD-1017', '2026-02-15', 17),
(18, 'ORD-1018', '2026-02-17', 18),
(19, 'ORD-1019', '2026-02-20', 19),
(20, 'ORD-1020', '2026-02-22', 20),
(21, 'ORD-1021', '2026-02-25', 21),
(22, 'ORD-1022', '2026-02-27', 22),
(23, 'ORD-1023', '2026-03-01', 23),
(24, 'ORD-1024', '2026-03-03', 24),
(25, 'ORD-1025', '2026-03-05', 25);
GO

INSERT INTO Items (ItemID, ItemName, ItemPriceUSD) VALUES
(1, 'Laptop Computer', 850.00),
(2, 'Wireless Mouse', 25.50),
(3, 'Office Chair', 145.00),
(4, 'Desk Lamp', 38.75),
(5, 'Printer', 220.00),
(6, 'Notebook Pack', 12.99),
(7, 'Water Bottle', 18.50),
(8, 'Bluetooth Speaker', 75.00),
(9, 'Backpack', 49.99),
(10, 'External Hard Drive', 110.00),
(11, 'Smartphone Stand', 15.25),
(12, 'Monitor', 199.99),
(13, 'Keyboard', 45.00),
(14, 'USB-C Cable', 9.99),
(15, 'Webcam', 65.00),
(16, 'Desk Organizer', 22.40),
(17, 'Tablet Device', 320.00),
(18, 'Fitness Tracker', 89.95),
(19, 'Coffee Maker', 58.00),
(20, 'Electric Kettle', 35.00),
(21, 'Headphones', 120.00),
(22, 'Projector', 475.00),
(23, 'Whiteboard', 95.00),
(24, 'Calculator', 19.99),
(25, 'File Cabinet', 180.00);
GO

INSERT INTO OrderDetails (OrderDetailID, OrderID, ItemID, Quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 3),
(3, 3, 3, 2),
(4, 4, 4, 4),
(5, 5, 5, 1),
(6, 6, 6, 10),
(7, 7, 7, 5),
(8, 8, 8, 2),
(9, 9, 9, 3),
(10, 10, 10, 1),
(11, 11, 11, 6),
(12, 12, 12, 2),
(13, 13, 13, 4),
(14, 14, 14, 8),
(15, 15, 15, 2),
(16, 16, 16, 5),
(17, 17, 17, 1),
(18, 18, 18, 3),
(19, 19, 19, 2),
(20, 20, 20, 4),
(21, 21, 21, 2),
(22, 22, 22, 1),
(23, 23, 23, 2),
(24, 24, 24, 7),
(25, 25, 25, 2);
GO

/* =========================================================
   4. CREATE VIEWS
   ========================================================= */

-- View 1: List of Customers and their salesperson
CREATE VIEW vw_CustomersAndSalesPersons AS
SELECT
    c.CustomerID,
    c.CustomerName,
    c.CustomerState,
    sp.SalesPersonID,
    sp.FirstName AS SalesPersonFirstName,
    sp.LastName AS SalesPersonLastName
FROM Customers c
INNER JOIN SalesPersons sp
    ON c.SalesPersonID = sp.SalesPersonID;
GO

-- View 2: Most expensive item purchased by each customer
CREATE VIEW vw_MostExpensiveItemByCustomer AS
WITH RankedItems AS (
    SELECT
        c.CustomerID,
        c.CustomerName,
        i.ItemName,
        i.ItemPriceUSD,
        od.Quantity,
        (i.ItemPriceUSD * od.Quantity) AS TotalLineAmount,
        ROW_NUMBER() OVER (
            PARTITION BY c.CustomerID
            ORDER BY i.ItemPriceUSD DESC
        ) AS RowNum
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Items i ON od.ItemID = i.ItemID
)
SELECT
    CustomerID,
    CustomerName,
    ItemName,
    ItemPriceUSD,
    Quantity,
    TotalLineAmount
FROM RankedItems
WHERE RowNum = 1;
GO

-- View 3: Most expensive item sold by each salesperson
CREATE VIEW vw_MostExpensiveItemBySalesPerson AS
WITH RankedItems AS (
    SELECT
        sp.SalesPersonID,
        sp.FirstName,
        sp.LastName,
        i.ItemName,
        i.ItemPriceUSD,
        od.Quantity,
        (i.ItemPriceUSD * od.Quantity) AS TotalLineAmount,
        ROW_NUMBER() OVER (
            PARTITION BY sp.SalesPersonID
            ORDER BY i.ItemPriceUSD DESC
        ) AS RowNum
    FROM SalesPersons sp
    INNER JOIN Customers c ON sp.SalesPersonID = c.SalesPersonID
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Items i ON od.ItemID = i.ItemID
)
SELECT
    SalesPersonID,
    FirstName AS SalesPersonFirstName,
    LastName AS SalesPersonLastName,
    ItemName,
    ItemPriceUSD,
    Quantity,
    TotalLineAmount
FROM RankedItems
WHERE RowNum = 1;
GO

-- View 4: Total purchase amount of every item for all orders by each customer
CREATE VIEW vw_TotalPurchaseAmountByCustomerItem AS
SELECT
    c.CustomerID,
    c.CustomerName,
    i.ItemID,
    i.ItemName,
    SUM(od.Quantity) AS TotalQuantityPurchased,
    i.ItemPriceUSD,
    SUM(od.Quantity * i.ItemPriceUSD) AS TotalPurchaseAmountUSD
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Items i ON od.ItemID = i.ItemID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    i.ItemID,
    i.ItemName,
    i.ItemPriceUSD;
GO

/* =========================================================
   5. CREATE FUNCTION - CONVERT USD TO EURO
   ========================================================= */

CREATE FUNCTION dbo.fn_ConvertUSDToEuro
(
    @PriceUSD DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @ExchangeRate DECIMAL(10,4);
    DECLARE @PriceEuro DECIMAL(10,2);

    -- Example fixed rate: 1 USD = 0.92 Euro
    SET @ExchangeRate = 0.9200;
    SET @PriceEuro = @PriceUSD * @ExchangeRate;

    RETURN @PriceEuro;
END;
GO

/* Example function test */
SELECT
    ItemID,
    ItemName,
    ItemPriceUSD,
    dbo.fn_ConvertUSDToEuro(ItemPriceUSD) AS ItemPriceEuro
FROM Items;
GO

/* =========================================================
   6. CREATE STORED PROCEDURE - INSERT NEW SALESPERSON
   ========================================================= */

CREATE PROCEDURE dbo.sp_InsertSalesPerson
    @SalesPersonID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SalesPersons (SalesPersonID, FirstName, LastName)
    VALUES (@SalesPersonID, @FirstName, @LastName);
END;
GO

/* Example stored procedure test */
EXEC dbo.sp_InsertSalesPerson
    @SalesPersonID = 26,
    @FirstName = 'Grace',
    @LastName = 'Adams';
GO

SELECT * FROM SalesPersons ORDER BY SalesPersonID;
GO

/* =========================================================
   7. TEST THE VIEWS
   ========================================================= */

SELECT * FROM vw_CustomersAndSalesPersons;
GO

SELECT * FROM vw_MostExpensiveItemByCustomer;
GO

SELECT * FROM vw_MostExpensiveItemBySalesPerson;
GO

SELECT * FROM vw_TotalPurchaseAmountByCustomerItem;
GO



SELECT COUNT(*) FROM SalesPersons;

SELECT COUNT(*) FROM Customers;

SELECT COUNT(*) FROM Orders;

SELECT COUNT(*) FROM Items;

SELECT COUNT(*) FROM OrderDetails;




SELECT TOP 5 * FROM Customers;
SELECT TOP 5 * FROM Orders;
SELECT TOP 5 * FROM OrderDetails;



SELECT COUNT(*) AS TotalCustomers FROM Customers;
SELECT COUNT(*) AS TotalOrders FROM Orders;
SELECT COUNT(*) AS TotalItems FROM Items;
SELECT COUNT(*) AS TotalOrderDetails FROM OrderDetails;

