CREATE DATABASE BookStore;
USE BookStore;

CREATE TABLE Book(
    BookID VARCHAR(50),
    BookTitle VARCHAR(200),
    ISBN VARCHAR(20),
    Price DECIMAL(12,2),  -- Changed to DECIMAL for precise currency
    Author VARCHAR(128),
    Type VARCHAR(128),
    Image VARCHAR(128),
    PRIMARY KEY (BookID)
);

CREATE TABLE Users(
    UserID INT NOT NULL AUTO_INCREMENT,
    UserName VARCHAR(128),
    Password VARCHAR(255),  -- Increased length for hashed passwords
    PRIMARY KEY (UserID)
);

CREATE TABLE Customer (
    CustomerID INT NOT NULL AUTO_INCREMENT,
    CustomerName VARCHAR(128),
    CustomerPhone VARCHAR(20),  -- Increased length for international numbers
    CustomerIC VARCHAR(14),
    CustomerEmail VARCHAR(200),
    CustomerAddress VARCHAR(200),
    CustomerGender VARCHAR(10),
    UserID INT,
    PRIMARY KEY (CustomerID),
    FOREIGN KEY (UserID) 
        REFERENCES Users(UserID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

-- Split "Order" into two tables: Orders and OrderDetails
CREATE TABLE Orders(
    OrderID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT,
    DatePurchase DATETIME,
    TotalPrice DECIMAL(12,2),  -- Total for the entire order
    Status VARCHAR(1),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) 
        REFERENCES Customer(CustomerID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

CREATE TABLE OrderDetails(
    OrderDetailID INT NOT NULL AUTO_INCREMENT,
    OrderID INT,
    BookID VARCHAR(50),
    Quantity INT,
    Price DECIMAL(12,2),  -- Price at time of purchase
    PRIMARY KEY (OrderDetailID),
    FOREIGN KEY (OrderID) 
        REFERENCES Orders(OrderID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (BookID) 
        REFERENCES Book(BookID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

CREATE TABLE Cart(
    CartID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT,
    BookID VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (CartID),
    FOREIGN KEY (BookID) 
        REFERENCES Book(BookID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    FOREIGN KEY (CustomerID) 
        REFERENCES Customer(CustomerID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Insert sample data (unchanged)
INSERT INTO Book(BookID, BookTitle, ISBN, Price, Author, Type, Image) 
VALUES 
    ('B-001','Lonely Planet Australia (Travel Guide)','123-456-789-1',136.00,'Lonely Planet','Travel','image/travel.jpg'),
    ('B-002','Crew Resource Management, Second Edition','123-456-789-2',599.00,'Barbara Kanki','Technical','image/technical.jpg'),
    ('B-003','CCNA Routing and Switching 200-125 Official Cert Guide Library','123-456-789-3',329.00,'Cisco Press','Technology','image/technology.jpg'),
    ('B-004','Easy Vegetarian Slow Cooker Cookbook','123-456-789-4',75.90,'Rockridge Press','Food','image/food.jpg');
