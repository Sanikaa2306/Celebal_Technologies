use myDB;

--creating table customer & inserting values to it--

CREATE TABLE Customer1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Age INT CHECK (Age >= 0 AND Age <= 99),
    Phone VARCHAR(15) 
);
INSERT INTO Customer1 VALUES
(1, 'John', 'Doe', 'USA', 28, '1234567890'),
(2, 'Emma', 'Smith', 'UK', 35, '9876543210'),
(3, 'Aarav', 'Patel', 'Berlin', 22, '9123456780'),
(4, 'Wei', 'Chen', 'London', 30, '8612345678'),
(5, 'Liam', 'Johnson', 'Canada', 40, '6471234567'),
(6, 'Olivia', 'Williams', 'Australia', 29, '0412345678'),
(7, 'Noah', 'Brown', 'Berlin', 32, '1234509876'),
(8, 'Sophia', 'Taylor', 'UK', 27, '4471234567'),
(9, 'Mia', 'Singh', 'London', 21, '9876543211'),
(10, 'Lucas', 'Martinez', 'Spain', 33, '612345678'),
(11, 'Amelia', 'Garcia', 'Mexico', 26, '5512345678'),
(12, 'Ethan', 'Lopez', 'Berlin', 45, '7894561230'),
(13, 'Isabella', 'Lee', 'South Korea', 24, '01012345678'),
(14, 'James', 'Nguyen', 'London', 34, '0912345678'),
(15, 'Elijah', 'Kumar', 'India', 38, '9988776655'),
(16, 'Charlotte', 'Verma', 'India', 23, '8899776655'),
(17, 'Benjamin', 'Gupta', 'India', 36, '7788990011'),
(18, 'Ava', 'Bose', 'Berlin', 25, '7788123456'),
(19, 'Logan', 'Das', 'London', 31, '9988997766'),
(20, 'Harper', 'Mishra', 'India', 22, '9090909090'),
(21, 'William', 'Sharma', 'India', 28, '9876543000'),
(22, 'Evelyn', 'Reddy', 'India', 27, '9441234567'),
(23, 'Alexander', 'Khan', 'Pakistan', 37, '3211234567'),
(24, 'Emily', 'Ali', 'Berlin', 29, '3221122334'),
(25, 'Michael', 'Ahmed', 'London', 33, '2012345678'),
(26, 'Abigail', 'Ibrahim', 'Nigeria', 39, '08012345678'),
(27, 'Daniel', 'Okafor', 'Nigeria', 26, '08123456789'),
(28, 'Ella', 'Mwangi', 'Kenya', 31, '0712345678'),
(29, 'Matthew', 'Ouma', 'Kenya', 24, '0723456789'),
(30, 'Chloe', 'Kim', 'South Korea', 23, '01056781234'),
(31, 'Jackson', 'Yamada', 'Japan', 35, '08012345678'),
(32, 'Avery', 'Tanaka', 'Japan', 30, '07098765432'),
(33, 'Sebastian', 'Sato', 'Japan', 34, '09011223344'),
(34, 'Scarlett', 'Li', 'China', 25, '8610987654'),
(35, 'Henry', 'Zhao', 'China', 28, '8612344321'),
(36, 'Grace', 'Huang', 'Taiwan', 29, '0911122233'),
(37, 'David', 'Lin', 'Taiwan', 30, '0933456677'),
(38, 'Victoria', 'Wang', 'Taiwan', 27, '0987654321'),
(39, 'Joseph', 'Rahman', 'Bangladesh', 32, '01712345678'),
(40, 'Lily', 'Hasan', 'Bangladesh', 26, '01898765432'),
(41, 'Samuel', 'Perera', 'Sri Lanka', 35, '0771234567'),
(42, 'Hannah', 'Fernando', 'Sri Lanka', 31, '0719876543'),
(43, 'Owen', 'Rodriguez', 'Argentina', 33, '5412345678'),
(44, 'Aria', 'Gomez', 'Argentina', 28, '5423456789'),
(45, 'Gabriel', 'Silva', 'Brazil', 29, '5512345678'),
(46, 'Zoe', 'Souza', 'Brazil', 25, '5598765432'),
(47, 'Jayden', 'Müller', 'Germany', 36, '491234567890'),
(48, 'Penelope', 'Schmidt', 'Germany', 34, '492345678901'),
(49, 'Levi', 'Dubois', 'France', 27, '33123456789'),
(50, 'Nora', 'Leroy', 'France', 30, '33987654321');


--creating product table--
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitsInStock INT,
    UnitsOnOrder INT,
    Discontinued BIT,
    SupplierID INT
);

--inserting values to product table--
INSERT INTO Product (ProductID, ProductName, Category, UnitsInStock, UnitsOnOrder, Discontinued, SupplierID) VALUES
(1, 'Chai', 'Beverages', 39, 0, 0, 1),
(2, 'Chang', 'Beverages', 17, 40, 0, 1),
(3, 'Aniseed Syrup', 'Condiments', 13, 70, 0, 1),
(4, 'Chef Anton''s Cajun Seasoning', 'Condiments', 53, 0, 0, 2),
(5, 'Chef Anton''s Gumbo Mix', 'Condiments', 0, 0, 1, 2),
(6, 'Grandma''s Boysenberry Spread', 'Condiments', 120, 0, 0, 2),
(7, 'Uncle Bob''s Organic Dried Pears', 'Produce', 15, 10, 0, 3),
(8, 'Northwoods Cranberry Sauce', 'Condiments', 6, 0, 0, 3),
(9, 'Mishi Kobe Niku', 'Meat/Poultry', 29, 0, 1, 4),
(10, 'Ikura', 'Seafood', 31, 0, 0, 4),
(11, 'Queso Cabrales', 'Dairy Products', 22, 30, 0, 5),
(12, 'Queso Manchego La Pastora', 'Dairy Products', 86, 0, 0, 5),
(13, 'Konbu', 'Seafood', 24, 0, 0, 6),
(14, 'Tofu', 'Produce', 35, 0, 0, 6),
(15, 'Genen Shouyu', 'Condiments', 39, 0, 0, 6),
(16, 'Pavlova', 'Confections', 29, 0, 0, 7),
(17, 'Alice Mutton', 'Meat/Poultry', 0, 0, 1, 7),
(18, 'Carnarvon Tigers', 'Seafood', 42, 0, 0, 7),
(19, 'Teatime Chocolate Biscuits', 'Confections', 25, 10, 0, 8),
(20, 'Sir Rodney''s Marmalade', 'Confections', 40, 5, 0, 8),
(21, 'Sir Rodney''s Scones', 'Confections', 3, 0, 0, 8),
(22, 'Nord-Ost Matjeshering', 'Seafood', 10, 0, 0, 9),
(23, 'Gorgonzola Telino', 'Dairy Products', 20, 15, 0, 9),
(24, 'Mascarpone Fabioli', 'Dairy Products', 32, 0, 0, 9),
(25, 'Geitost', 'Dairy Products', 15, 0, 0, 10),
(26, 'Sasquatch Ale', 'Beverages', 125, 0, 0, 10),
(27, 'Steeleye Stout', 'Beverages', 20, 0, 0, 10),
(28, 'Inlagd Sill', 'Seafood', 112, 0, 0, 11),
(29, 'Gravad lax', 'Seafood', 11, 0, 0, 11),
(30, 'Côte de Blaye', 'Beverages', 17, 0, 0, 11);


--creating order table --
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShippedCountry VARCHAR(50),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- inserting values to order--
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ShippedCountry, TotalAmount) VALUES
(1, 10, '1995-01-07', 'Canada', 895.60),
(2, 41, '1998-04-19', 'Germany', 773.16),
(3, 23, '1995-08-31', 'USA', 906.59),
(4, 25, '1999-06-11', 'UK', 638.09),
(5, 32, '2003-11-27', 'France', 816.87),
(6, 36, '1995-04-23', 'UK', 169.75),
(7, 4, '2001-09-29', 'France', 421.24),
(8, 46, '1998-04-16', 'India', 325.61),
(9, 45, '1999-03-20', 'Germany', 706.26),
(10, 43, '2002-08-05', 'UK', 366.35),
(11, 27, '1996-11-15', 'Canada', 544.12),
(12, 18, '1997-07-09', 'USA', 354.95),
(13, 6, '2000-02-18', 'France', 217.80),
(14, 14, '1996-05-12', 'UK', 687.43),
(15, 50, '1995-12-25', 'India', 432.50),
(16, 5, '1998-09-03', 'USA', 502.35),
(17, 9, '1996-01-01', 'Canada', 399.99),
(18, 17, '2004-06-10', 'Germany', 241.00),
(19, 3, '2002-11-28', 'France', 599.75),
(20, 21, '2001-01-14', 'UK', 705.12),
(21, 30, '1996-12-31', 'India', 812.10),
(22, 12, '1997-03-10', 'Canada', 199.99),
(23, 1, '2000-04-22', 'Germany', 129.30),
(24, 2, '2003-05-01', 'France', 710.00),
(25, 15, '1998-08-17', 'UK', 399.95),
(26, 22, '1999-09-30', 'India', 298.20),
(27, 35, '2005-07-07', 'Germany', 650.50),
(28, 8, '1995-10-05', 'Canada', 870.40),
(29, 38, '1997-01-20', 'France', 564.45),
(30, 40, '2001-03-19', 'USA', 987.77);


--creating table orderdetails--
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
    -- You may add a FOREIGN KEY to Product(ProductID) later
);

-- inserting values to orderDetails--
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 6, 58.46),
(2, 3, 7, 4, 75.38),
(3, 22, 8, 3, 66.53),
(4, 3, 2, 6, 23.14),
(5, 30, 7, 7, 50.07),
(6, 4, 9, 1, 86.44),
(7, 13, 5, 1, 62.83),
(8, 14, 3, 7, 52.76),
(9, 24, 5, 8, 70.35),
(10, 25, 4, 1, 58.12),
(11, 2, 6, 2, 64.20),
(12, 5, 2, 5, 45.00),
(13, 11, 10, 3, 99.00),
(14, 6, 3, 9, 27.50),
(15, 9, 1, 1, 88.88),
(16, 7, 5, 6, 72.45),
(17, 18, 6, 4, 61.11),
(18, 19, 2, 2, 30.00),
(19, 8, 7, 3, 56.70),
(20, 10, 3, 7, 60.00),
(21, 12, 8, 6, 79.99),
(22, 20, 4, 2, 25.00),
(23, 15, 10, 3, 42.30),
(24, 16, 9, 5, 55.55),
(25, 17, 1, 8, 39.90),
(26, 23, 2, 1, 21.21),
(27, 26, 4, 6, 67.89),
(28, 27, 6, 4, 48.75),
(29, 28, 8, 3, 59.99),
(30, 29, 3, 5, 71.45),
(31, 30, 5, 2, 35.00),
(32, 21, 7, 4, 90.00),
(33, 14, 3, 2, 27.00),
(34, 13, 6, 1, 55.55),
(35, 19, 10, 6, 92.92),
(36, 20, 9, 3, 64.00),
(37, 12, 1, 2, 49.99),
(38, 11, 5, 7, 88.88),
(39, 28, 2, 1, 35.35),
(40, 22, 3, 4, 73.73);


--creating table Employee--
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    TotalSales int ,
    ReportsTo INT NULL
);

-- inserting values to Employee--
INSERT INTO Employee (EmployeeID, FirstName, LastName, TotalSales, ReportsTo) VALUES
(1, 'Alice', 'Brown', 20000, NULL),
(2, 'Bob', 'Smith', 15000, 1),
(3, 'Carol', 'Johnson', 18000, 1),
(4, 'David', 'Lee', 12000, 1),
(5, 'Eva', 'Martinez', 11000, 1),
(6, 'Frank', 'Clark', 10000, 1),
(7, 'Grace', 'Taylor', 9500, 2),
(8, 'Henry', 'Anderson', 8700, 2),
(9, 'Ivy', 'Thomas', 9100, 2),
(10, 'Jack', 'Moore', 8900, 3),
(11, 'Karen', 'Walker', 7600, 3),
(12, 'Leo', 'Hall', 8400, 3),
(13, 'Mona', 'Allen', 7300, 4),
(14, 'Nate', 'Young', 9500, 4),
(15, 'Olive', 'Hernandez', 10200, 4),
(16, 'Paul', 'King', 8100, 5),
(17, 'Quinn', 'Wright', 7700, 5),
(18, 'Rose', 'Lopez', 9300, 5),
(19, 'Sam', 'Hill', 8800, 6),
(20, 'Tina', 'Scott', 8600, 6),
(21, 'Uma', 'Green', 7900, 6),
(22, 'Victor', 'Adams', 19500, NULL),
(23, 'Wendy', 'Baker', 16200, 22),
(24, 'Xander', 'Nelson', 14200, 22),
(25, 'Yara', 'Carter', 12000, 22),
(26, 'Zane', 'Mitchell', 11000, 22),
(27, 'Aaron', 'Perez', 13000, 22),
(28, 'Bella', 'Roberts', 9800, 23),
(29, 'Chris', 'Turner', 9100, 23),
(30, 'Dana', 'Phillips', 10300, 23);


--creating table supplier--
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100)
);

--inserting values to supplier--
INSERT INTO Supplier (SupplierID, SupplierName) VALUES 
(3, 'FreshFarm Ltd'),
(1, 'Global Foods Co.'),
(7, 'NatureHarvest Inc'),
(5, 'Sunrise Suppliers'),
(9, 'Organic Source Pvt Ltd'),
(2, 'GreenLeaf Traders'),
(11, 'WholeMart Distributors'),
(6, 'FarmFresh India'),
(4, 'EcoSupplies Ltd'),
(10, 'Daily Needs Co.'),
(8, 'Local Roots Wholesale');


--creating table manager --
CREATE TABLE Manager (
    ManagerID INT PRIMARY KEY,
    ManagerName VARCHAR(100),
    Employees_Under INT CHECK (Employees_Under BETWEEN 1 AND 5)
);

-- inserting values to manager table--
INSERT INTO Manager (ManagerID, ManagerName, Employees_Under) VALUES
(1, 'Alex Newton', 5),
(2, 'Brian Clarke', 4),
(3, 'Catherine Ross', 3),
(4, 'Daniela White', 2),
(5, 'Edward Hill', 1),
(6, 'Fiona Brooks', 3),
(7, 'George Stone', 4),
(8, 'Hannah Diaz', 2),
(9, 'Isaac Reed', 5),
(10, 'Julia Grant', 1);






--Queries --
-- 1. List of all customers
SELECT * FROM Customer;

-- 2. Customers where last name ends with 'N'
SELECT * FROM Customer
WHERE LastName LIKE '%N';

-- 3. Customers who live in Berlin or London
SELECT * FROM Customer
WHERE Country IN ('Berlin', 'London');

-- 4. Customers who live in UK or USA
SELECT * FROM Customer
WHERE Country IN ('UK', 'USA');

-- 5. Products sorted by name
SELECT * FROM Product
ORDER BY ProductName;

-- 6. Products starting with 'A'
SELECT * FROM Product
WHERE ProductName LIKE 'A%';

-- 7. Customers who ever placed an order
SELECT DISTINCT C.*
FROM Customer C
JOIN Orders O ON C.CustomerID = O.CustomerID;

-- 8. Customers in London who bought Chai
SELECT DISTINCT C.*
FROM Customer C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Product P ON OD.ProductID = P.ProductID
WHERE C.Country = 'London' AND P.ProductName = 'Chai';

--9 Customers who never placed an order--
SELECT *
FROM Customer
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 10. Customers who ordered Tofu
SELECT DISTINCT C.*
FROM Customer C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Product P ON OD.ProductID = P.ProductID
WHERE P.ProductName = 'Tofu';

-- 11. Details of first order
SELECT TOP 1 * FROM Orders
ORDER BY OrderDate ASC;

-- 12. Most expensive order date
SELECT TOP 1 OrderDate, TotalAmount FROM Orders
ORDER BY TotalAmount DESC;

-- 13. Each order's average quantity
SELECT OrderID, AVG(Quantity) AS AvgQuantity
FROM OrderDetails
GROUP BY OrderID;

-- 14. Each order's min and max quantity
SELECT OrderID, MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM OrderDetails
GROUP BY OrderID;

--15--
SELECT 
    M.ManagerID,
    M.ManagerName,
    COUNT(E.EmployeeID) AS TotalReports
FROM Manager M
JOIN Employee E ON M.ManagerID = E.ReportsTo
GROUP BY M.ManagerID, M.ManagerName;

-- 16. Orders where total quantity > 300
SELECT OrderID, SUM(Quantity) AS TotalQty
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity) > 300;

-- 17. Orders on or after 1996-12-31
SELECT * FROM Orders
WHERE OrderDate >= '1996-12-31';

-- 18. Orders shipped to Canada
SELECT * FROM Orders
WHERE ShippedCountry = 'Canada';

-- 19. Orders with total > 200
SELECT * FROM Orders
WHERE TotalAmount > 200;

-- 20. Countries and sales made in each
SELECT ShippedCountry, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY ShippedCountry;

-- 21. Customer name and number of orders
SELECT C.CustomerName, COUNT(O.OrderID) AS OrderCount
FROM Customer C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- 22. Customers with more than 3 orders
SELECT C.CustomerName
FROM Customer C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING COUNT(O.OrderID) > 3;

-- 23. Discontinued products ordered between dates
SELECT DISTINCT P.*
FROM Product P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE P.Discontinued = 1
  AND O.OrderDate BETWEEN '1997-01-01' AND '1998-01-01';

-- 24. Employees and supervisors--
SELECT 
    E.FirstName AS EmployeeFirstName,
    E.LastName AS EmployeeLastName,
    S.FirstName AS SupervisorFirstName,
    S.LastName AS SupervisorLastName
FROM Employee E
LEFT JOIN Employee S ON E.ReportsTo = S.EmployeeID;

--25 Employee ID and total sales--
SELECT EmployeeID,FirstName,LastName,TotalSales
FROM Employee;

-- 26. Customers whose name contains 'a'
SELECT * FROM Customer
WHERE CustomerName LIKE '%a%';

--27 Managers with more than 4 subordinates--
SELECT 
    E.EmployeeID AS ManagerID,
    E.FirstName + ' ' + E.LastName AS ManagerName,
    COUNT(S.EmployeeID) AS SubordinateCount
FROM Employee E
JOIN Employee S ON E.EmployeeID = S.ReportsTo
GROUP BY E.EmployeeID, E.FirstName, E.LastName
HAVING COUNT(S.EmployeeID) > 4;



-- 28. Orders and Product names
SELECT O.OrderID, P.ProductName
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Product P ON OD.ProductID = P.ProductID;

-- 29. Orders by best customer
SELECT TOP 1 O.*
FROM Orders O
JOIN (
    SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
    ORDER BY TotalSpent DESC
) Best ON O.CustomerID = Best.CustomerID;

--30 Orders by customers without Fax--
SELECT O.*
FROM Orders O
JOIN Customer C ON O.CustomerID = C.CustomerID
WHERE C.Fax IS NULL;

--31 Postal codes where Tofu was shipped--
SELECT DISTINCT C.PostalCode
FROM Customer1 C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Product P ON OD.ProductID = P.ProductID
WHERE P.ProductName = 'Tofu';

-- 32. Product names shipped to France --
SELECT DISTINCT P.ProductName
FROM Product P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE O.ShippedCountry = 'France';

-- 33. Products and categories for supplier --
SELECT ProductName, Category
FROM Product
WHERE SupplierID = (SELECT SupplierID FROM Supplier WHERE SupplierName = 'Specialty Biscuits, Ltd.');

-- 34. Products never ordered --
SELECT * FROM Product
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails);

-- 35. Products with stock < 10 and order = 0 --
SELECT * FROM Product
WHERE UnitsInStock < 10 AND UnitsOnOrder = 0;

-- 36. Top 10 countries by sales --
SELECT TOP 10 ShippedCountry, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY ShippedCountry
ORDER BY TotalSales DESC;

-- 37. Orders per employee for customerID 6-25
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    COUNT(O.OrderID) AS OrderCount
FROM Orders O
JOIN Employee E ON O.EmployeeID = E.EmployeeID
WHERE O.CustomerID BETWEEN 6 AND 25
GROUP BY E.EmployeeID, E.FirstName, E.LastName;


-- 38. Order date of most expensive order
SELECT TOP 1 OrderDate
FROM Orders
ORDER BY TotalAmount DESC;

-- 39. Product name and total revenue
SELECT P.ProductName, SUM(OD.Quantity * OD.Price) AS Revenue
FROM Product P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

-- 40. Supplier and number of products they offer
SELECT SupplierID, COUNT(*) AS ProductCount
FROM Product
GROUP BY SupplierID;

-- 41. Top 10 customers based on business
SELECT TOP 10 C.CustomerName, SUM(O.TotalAmount) AS TotalSpent
FROM Customer1 C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalSpent DESC;

-- 42. Total revenue of the company
SELECT SUM(TotalAmount) AS CompanyRevenue FROM Orders;















