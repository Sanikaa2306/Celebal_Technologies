-- *************** Stored Procedure *******************
--Create Product table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY,
	ProductName VARCHAR(100),
	UnitPrice MONEY,
	UnitsInStock INT,
	ReorderLevel INT
);

--Create OrderDetails Table
CREATE TABLE OrderDetails (
	OrderID INT,
	ProductID INT,
	UnitPrice MONEY,
	Quantity INT,
	Discount FLOAT,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--Insert sample Products
INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitsInStock, ReorderLevel)
VALUES 
(1, 'Keyboard', 500.00, 50, 10),       
(2, 'Mouse', 300.00, 20, 15),          
(3, 'Monitor', 7000.00, 10, 5),       
(4, 'Printer', 12000.00, 5, 3),       
(5, 'USB Cable', 150.00, 100, 10),     
(6, 'Webcam', 2500.00, 0, 2),          
(7, 'Headphones', 2000.00, 3, 5);      

-- TASK 1 --
--Create the stored procedure
CREATE PROCEDURE InsertOrderDetails
	@OrderID INT,
	@ProductID INT,
	@UnitPrice MONEY = NULL,
	@Quantity INT,
	@Discount FLOAT = 0

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Stock INT;
	DECLARE @ReorderLevel INT;

	--Get UnitPrice if not provided
	IF @UnitPrice IS NULL
	BEGIN
		SELECT @UnitPrice = UnitPrice
		FROM Products
		WHERE ProductID = @ProductID;
	END

	--Fetch stock and reoder level
	SELECT
		@Stock = UnitsInStock,
		@ReorderLevel = ReorderLevel
	FROM Products
	WHERE ProductID = @ProductID;

	--Validate stock
	IF @Stock IS NULL
	BEGIN
		PRINT 'INVALID ProductID';
		Return;
	END

	IF @Stock < @Quantity
	BEGIN
		PRINT 'Insufficient Stock. Order aborded';
		RETURN;
	END

	--INSERT ORDER
	INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
	VALUES(@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount);

	--CHEACK INSERTION SUCCESS
	IF @@ROWCOUNT = 0
	BEGIN
		PRINT 'Failed to place the order. Please try again.';
		RETURN;
	END

	--UPDATE PRODUCTS
	UPDATE Products
	SET UnitsInStock = UnitsInStock - @Quantity
	WHERE ProductID = @ProductID;

	--Alerts if stock falls below reorder level
	SELECT @Stock = UnitsInStock
	FROM Products
	WHERE ProductID = @ProductID;

	IF @Stock < @ReorderLevel
	BEGIN 
		PRINT 'Warning : Product stock has fallen below its reorder level.';
	END

	PRINT 'Order placed successfully.';
END;


EXEC InsertOrderDetails
    @OrderID = 101,
    @ProductID = 1,
    @Quantity = 5;
-- Should use default UnitPrice from Products table and Discount = 0

EXEC InsertOrderDetails
    @OrderID = 102,
    @ProductID = 2,
    @UnitPrice = 290,
    @Quantity = 4,
    @Discount = 0.05;

EXEC InsertOrderDetails
    @OrderID = 103,
    @ProductID = 3,
    @Quantity = 100;
-- Should print: 'Insufficient stock. Order aborted.'

SELECT * FROM OrderDetails;
SELECT * FROM Products;

-- TASK 2 --
CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT = NULL,
    @Discount FLOAT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Declare variables to hold original values
    DECLARE @OldUnitPrice MONEY, @OldQuantity INT, @OldDiscount FLOAT;
    DECLARE @NewUnitPrice MONEY, @NewQuantity INT, @NewDiscount FLOAT;
    DECLARE @CurrentStock INT, @UpdatedStock INT, @QuantityDiff INT;

    -- Step 2: Fetch original order details
    SELECT @OldUnitPrice = UnitPrice,
           @OldQuantity = Quantity,
           @OldDiscount = Discount
    FROM OrderDetails
    WHERE OrderID = @OrderID AND ProductID = @ProductID;

    IF @OldQuantity IS NULL
    BEGIN
        PRINT 'No such order found.';
        RETURN;
    END

    -- Step 3: Get new values (use ISNULL to fallback to old)
    SET @NewUnitPrice = ISNULL(@UnitPrice, @OldUnitPrice);
    SET @NewQuantity  = ISNULL(@Quantity, @OldQuantity);
    SET @NewDiscount  = ISNULL(@Discount, @OldDiscount);

    -- Step 4: Calculate quantity difference (new - old)
    SET @QuantityDiff = @NewQuantity - @OldQuantity;

    -- Step 5: Check if stock is available if increasing quantity
    IF @QuantityDiff > 0
    BEGIN
        SELECT @CurrentStock = UnitsInStock FROM Products WHERE ProductID = @ProductID;

        IF @CurrentStock < @QuantityDiff
        BEGIN
            PRINT 'Not enough stock to update quantity.';
            RETURN;
        END
    END

    -- Step 6: Update OrderDetails with new values
    UPDATE OrderDetails
    SET UnitPrice = @NewUnitPrice,
        Quantity = @NewQuantity,
        Discount = @NewDiscount
    WHERE OrderID = @OrderID AND ProductID = @ProductID;

    -- Step 7: Adjust inventory
    UPDATE Products
    SET UnitsInStock = UnitsInStock - @QuantityDiff
    WHERE ProductID = @ProductID;

    PRINT 'Order updated successfully.';
END;

EXEC UpdateOrderDetails @OrderID = 101, @ProductID = 1, @Quantity = 8;

EXEC UpdateOrderDetails @OrderID = 102, @ProductID = 2, @Discount = 0.1;

EXEC UpdateOrderDetails @OrderID = 101, @ProductID = 1, @Quantity = 1000;

EXEC UpdateOrderDetails @OrderID = 102, @ProductID = 2, @UnitPrice = 310.00, @Quantity = 2;

SELECT * FROM OrderDetails;
SELECT * FROM Products;

--TASK 3--
CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if records exist
    IF NOT EXISTS (
        SELECT 1 FROM OrderDetails WHERE OrderID = @OrderID
    )
    BEGIN
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR) + ' does not exist';
        RETURN 1;
    END

    -- If records found, display them
    SELECT * 
    FROM OrderDetails
    WHERE OrderID = @OrderID;
END;

EXEC GetOrderDetails @OrderID = 102;

EXEC GetOrderDetails @OrderID = 999;

--TASK 4 --
CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Validate OrderID + ProductID combination
    IF NOT EXISTS (
        SELECT 1
        FROM OrderDetails
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    )
    BEGIN
        PRINT 'Invalid parameters: OrderID or ProductID not found in combination.';
        RETURN -1;
    END

    -- Step 2: Delete the order detail
    DELETE FROM OrderDetails
    WHERE OrderID = @OrderID AND ProductID = @ProductID;

    PRINT 'Order detail deleted successfully.';
END;

EXEC DeleteOrderDetails @OrderID = 102, @ProductID = 2;

EXEC DeleteOrderDetails @OrderID = 101, @ProductID = 5;

DECLARE @status INT;

EXEC @status = DeleteOrderDetails @OrderID = 102, @ProductID = 2;

SELECT 'Return Code' = @status;

-- ************ Functions **************
-- TASK1
CREATE FUNCTION FormatDate_MMDDYYYY (@InputDate DATETIME)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN CONVERT(VARCHAR(10), @InputDate, 101);
END;

SELECT dbo.FormatDate_MMDDYYYY('2006-11-21 23:34:05.920') AS Result;

-- TASK2
CREATE FUNCTION FormatDate_YYYYMMDD (
    @InputDate DATETIME
)
RETURNS VARCHAR(8)
AS
BEGIN
    RETURN CONVERT(VARCHAR(8), @InputDate, 112);
END;

SELECT dbo.FormatDate_YYYYMMDD('2006-11-21 23:34:05.920') AS Result;

-- ************** VIEWS **********************
-- Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100)
);

INSERT INTO Customers VALUES
(1, 'Microsoft'),
(2, 'Google');

-- Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders VALUES
(101, 1, GETDATE() - 1), -- Yesterday
(102, 2, GETDATE());     -- Today

-- TASK 1
CREATE VIEW vwCustomerOrders AS
SELECT 
    c.CompanyName,
    o.OrderID,
    o.OrderDate,
    p.ProductID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

SELECT * FROM vwCustomerOrders;

-- TASK 2
CREATE VIEW vwCustomerOrders_Yesterday AS
SELECT 
    c.CompanyName,
    o.OrderID,
    o.OrderDate,
    p.ProductID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE CAST(o.OrderDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE);

select * from vwCustomerOrders_Yesterday;
-- TASK 3
-- Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    CompanyName VARCHAR(100)
);

INSERT INTO Suppliers VALUES
(10, 'HP'),
(11, 'Dell');

-- Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

INSERT INTO Categories VALUES
(100, 'Accessories'),
(101, 'Peripherals');

SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('OrderDetails');

ALTER TABLE OrderDetails
DROP CONSTRAINT FK__OrderDeta__Produ__3D7E1B63;

DROP TABLE Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    QuantityPerUnit VARCHAR(50),
    UnitPrice MONEY,
    SupplierID INT,
    CategoryID INT,
    Discontinued BIT
);

INSERT INTO Products VALUES
(1, 'Keyboard', '1 pc', 500, 10, 100, 0),
(2, 'Mouse', '1 pc', 300, 11, 101, 1), -- Discontinued
(3, 'Monitor', '1 pc', 7000, 10, 100, 0);

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Products
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

CREATE VIEW MyProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.QuantityPerUnit,
    p.UnitPrice,
    s.CompanyName AS SupplierName,
    c.CategoryName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.Discontinued = 0;

select * from MyProducts;

-- TRIGGERS 
-- TASK1 
CREATE TRIGGER trg_DeleteOrder
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Delete matching order details
    DELETE FROM OrderDetails
    WHERE OrderID IN (SELECT OrderID FROM DELETED);

    -- Step 2: Delete the order itself
    DELETE FROM Orders
    WHERE OrderID IN (SELECT OrderID FROM DELETED);

    PRINT 'Order and related order details deleted successfully.';
END;

DELETE FROM Orders WHERE OrderID = 101;

-- TASK 2
CREATE TRIGGER trg_StockCheck
ON OrderDetails
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProductID INT, @Quantity INT, @Stock INT;

    SELECT TOP 1
        @ProductID = ProductID,
        @Quantity = Quantity
    FROM INSERTED;

    SELECT @Stock = UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID;

    -- If not enough stock
    IF @Stock IS NULL OR @Stock < @Quantity
    BEGIN
        RAISERROR('Insufficient stock. Order cannot be placed.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- If stock is enough, reduce stock
    UPDATE Products
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductID;

    PRINT 'Order placed and stock updated.';
END;

-- Assume ProductID 1 has 45 units in stock
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (105, 1, 5, 500);

-- ProductID 3 has only 10 units
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (106, 3, 999, 7000);

















