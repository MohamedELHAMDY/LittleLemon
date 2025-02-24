-- Step 1:  the database
CREATE DATABASE LittleLemon;
USE LittleLemon;

-- Step 2:  Customers Table
CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(100),
    Country VARCHAR(50),
    PostalCode VARCHAR(20)
);

-- Step 3:  Orders Table
CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    DeliveryDate DATE,
    CustomerID VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Step 4:  Dishes Table
CREATE TABLE Dishes (
    DishID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CuisineName VARCHAR(50) NOT NULL
);

-- Step 5:  OrderDetails Table (Join Table)
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID VARCHAR(20),
    DishID INT,
    Quantity INT NOT NULL,
    Sales DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (DishID) REFERENCES Dishes(DishID) ON DELETE CASCADE
);

-- Step 6:  stored procedures

-- GetMaxQuantity() Procedure
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS MaxQuantity FROM OrderDetails;
END //

DELIMITER ;

-- ManageBooking() Procedure
DELIMITER //

CREATE PROCEDURE ManageBooking(
    IN bookingID INT,
    IN customerID VARCHAR(20),
    IN action VARCHAR(10) -- 'add', 'update', or 'cancel'
)
BEGIN
    IF action = 'add' THEN
        -- Add booking logic here
        INSERT INTO Bookings (BookingID, CustomerID, BookingDate) 
        VALUES (bookingID, customerID, CURDATE());
    ELSEIF action = 'update' THEN
        -- Update booking logic here
        UPDATE Bookings
        SET BookingDate = CURDATE()
        WHERE BookingID = bookingID;
    ELSEIF action = 'cancel' THEN
        -- Cancel booking logic here
        DELETE FROM Bookings WHERE BookingID = bookingID;
    END IF;
END //

DELIMITER ;

-- UpdateBooking() Procedure
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN bookingID INT,
    IN newDate DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = newDate
    WHERE BookingID = bookingID;
END //

DELIMITER ;

-- AddBooking() Procedure
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN bookingID INT,
    IN customerID VARCHAR(20),
    IN bookingDate DATE
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate)
    VALUES (bookingID, customerID, bookingDate);
END //

DELIMITER ;

-- CancelBooking() Procedure
DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN bookingID INT
)
BEGIN
    DELETE FROM Bookings WHERE BookingID = bookingID;
END //

DELIMITER ;

-- Step 7: Insert Sample Data
-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName, City, Country, PostalCode)
VALUES
('72-055-7985', 'Laney Fadden', 'Daruoyan', 'China', '993-0031'),
('65-353-0657', 'Giacopo Bramich', 'Ongjin', 'North Korea', '216282'),
('90-876-6799', 'Lia Bonar', 'Quince Mil', 'Peru', '663246');

-- Insert Orders
INSERT INTO Orders (OrderID, OrderDate, DeliveryDate, CustomerID)
VALUES
('54-366-6861', '2020-06-15', '2020-03-26', '72-055-7985'),
('63-761-3686', '2020-08-25', '2020-07-17', '65-353-0657'),
('65-351-6434', '2021-08-17', '2020-04-24', '90-876-6799');

-- Insert Dishes
INSERT INTO Dishes (CourseName, CuisineName)
VALUES
('Greek salad', 'Greek'),
('Bean soup', 'Italian'),
('Pizza', 'Italian');

-- Insert OrderDetails
INSERT INTO OrderDetails (OrderID, DishID, Quantity, Sales)
VALUES
('54-366-6861', 1, 2, 187.5),
('63-761-3686', 2, 1, 352.5),
('65-351-6434', 3, 3, 112.5);

