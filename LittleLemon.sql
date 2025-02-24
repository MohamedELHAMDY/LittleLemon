-- Step 1: Create the database
CREATE DATABASE LittleLemon;
USE LittleLemon;

-- Step 2: Create Customers Table
CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(100),
    Country VARCHAR(50),
    PostalCode VARCHAR(20)
);

-- Step 3: Create Orders Table
CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    DeliveryDate DATE,
    CustomerID VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Step 4: Create Dishes Table
CREATE TABLE Dishes (
    DishID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CuisineName VARCHAR(50) NOT NULL
);

-- Step 5: Create OrderDetails Table (Join Table)
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID VARCHAR(20),
    DishID INT,
    Quantity INT NOT NULL,
    Sales DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID) ON DELETE CASCADE
);
