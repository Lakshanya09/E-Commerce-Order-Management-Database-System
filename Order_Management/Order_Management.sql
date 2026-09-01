
-- =========================================================
-- WEEK 4 : ORDER MANAGEMENT SYSTEM
-- =========================================================

USE inventory_db;

-- =========================================================
-- 1. REMOVE OLD ORDER TABLES
-- =========================================================

DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;


-- =========================================================
-- 2. CREATE ORDERS TABLE
-- =========================================================

CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Order_Date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Total_Amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Order_Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled')
        NOT NULL DEFAULT 'Pending',

    CONSTRAINT pk_orders PRIMARY KEY (Order_ID),

    CONSTRAINT chk_total_amount
        CHECK (Total_Amount >= 0.00),

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
ENGINE = InnoDB;


-- =========================================================
-- 3. CREATE ORDER_DETAILS TABLE
-- =========================================================

CREATE TABLE Order_Details (
    Order_Detail_ID INT AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_order_details
        PRIMARY KEY (Order_Detail_ID),

    CONSTRAINT chk_detail_quantity
        CHECK (Quantity > 0),

    CONSTRAINT chk_detail_price
        CHECK (Price >= 0.00),

    CONSTRAINT fk_details_order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_details_product
        FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
ENGINE = InnoDB;


-- =========================================================
-- 4. INSERT ORDERS
-- =========================================================

INSERT INTO Orders
    (Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Status)
VALUES
    (1, 1, '2026-08-20 10:30:00', 0.00, 'Delivered'),
    (2, 2, '2026-08-21 11:15:00', 0.00, 'Shipped'),
    (3, 3, '2026-08-21 14:20:00', 0.00, 'Delivered'),
    (4, 1, '2026-08-22 09:45:00', 0.00, 'Pending'),
    (5, 4, '2026-08-23 16:10:00', 0.00, 'Delivered'),
    (6, 5, '2026-08-24 12:00:00', 0.00, 'Shipped');


-- =========================================================
-- 5. INSERT ORDER DETAILS
-- =========================================================

INSERT INTO Order_Details
    (Order_ID, Product_ID, Quantity, Price)
VALUES
    (1, 1, 2, 1000.00),
    (1, 2, 1, 500.00),

    (2, 3, 2, 900.00),

    (3, 1, 1, 1600.00),
    (3, 4, 2, 800.00),

    (4, 2, 3, 500.00),

    (5, 5, 2, 1500.00),

    (6, 1, 1, 2200.00);


-- =========================================================
-- 6. CALCULATE TOTAL ORDER AMOUNT
-- =========================================================

UPDATE Orders o
JOIN (
    SELECT
        Order_ID,
        SUM(Quantity * Price) AS Calculated_Total
    FROM Order_Details
    GROUP BY Order_ID
) od
    ON o.Order_ID = od.Order_ID
SET o.Total_Amount = od.Calculated_Total
WHERE o.Order_ID IN (
    SELECT Order_ID
    FROM Order_Details
);


-- =========================================================
-- 7. UPDATE OPERATIONS
-- =========================================================

-- Change order status from Pending to Delivered

UPDATE Orders
SET Order_Status = 'Delivered'
WHERE Order_ID = 4;


-- Update product quantity

UPDATE Order_Details
SET Quantity = 4
WHERE Order_Detail_ID = 6;


-- Recalculate Order 4 total after quantity change

UPDATE Orders o
JOIN (
    SELECT
        Order_ID,
        SUM(Quantity * Price) AS Calculated_Total
    FROM Order_Details
    WHERE Order_ID = 4
    GROUP BY Order_ID
) od
    ON o.Order_ID = od.Order_ID
SET o.Total_Amount = od.Calculated_Total
WHERE o.Order_ID = 4;


-- =========================================================
-- 8. DELETE OPERATION
-- =========================================================

-- Mark Order 6 as cancelled

UPDATE Orders
SET Order_Status = 'Cancelled'
WHERE Order_ID = 6;


-- Delete cancelled order

DELETE FROM Orders
WHERE Order_ID = 6
  AND Order_Status = 'Cancelled';


-- =========================================================
-- REPORT 1 : CUSTOMER ORDER HISTORY
-- =========================================================

SELECT
    c.Customer_Name AS Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status AS Status
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
ORDER BY o.Order_Date;


-- =========================================================
-- REPORT 2 : PRODUCT-WISE ORDER REPORT
-- =========================================================

SELECT
    p.Product_Name,
    COUNT(DISTINCT od.Order_ID) AS Times_Ordered,
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Products p
JOIN Order_Details od
    ON p.Product_ID = od.Product_ID
GROUP BY
    p.Product_ID,
    p.Product_Name
ORDER BY Total_Quantity_Sold DESC;


-- =========================================================
-- REPORT 3 : CUSTOMER PURCHASE ANALYSIS
-- =========================================================

SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    ROUND(AVG(o.Total_Amount), 2) AS Average_Order_Value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY
    Total_Orders DESC,
    Total_Spending DESC;