SELECT * FROM Orders;

-- DATA FOR REPORT 1
INSERT INTO Orders (CUSTOMER_ID, ORDER_DATE, TOTAL_AMOUNT, ORDER_STATUS)
VALUES
(1, '2026-08-20', 2500.00, 'Delivered'),
(2, '2026-08-21', 1800.00, 'Shipped'),
(3, '2026-08-21', 3200.00, 'Delivered'),
(1, '2026-08-22', 1500.00, 'Pending'),
(4, '2026-08-23', 4500.00, 'Delivered'),
(5, '2026-08-24', 2200.00, 'Shipped'); 


-- DATA FOR REPORT2
INSERT INTO Order_Details (ORDER_ID, PRODUCT_ID, QUANTITY, PRICE)
VALUES
(19, 1, 2, 1000.00),
(19, 2, 1, 500.00),
(20, 3, 2, 900.00),
(21, 1, 1, 1600.00),
(21, 4, 2, 800.00),
(22, 2, 3, 500.00),
(23, 5, 2, 1500.00);

-- REPORT 1: Customer Order History

SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status AS Status
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
ORDER BY o.Order_Date;


-- REPORT 2: Product-wise Order Report

SELECT
    p.Product_Name,
    COUNT(od.Order_ID) AS Times_Ordered,
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Products p
JOIN Order_Details od
    ON p.Product_ID = od.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Quantity_Sold DESC;


-- REPORT 3: Customer Purchase Analysis

SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Total_Amount) AS Total_Spending,
    ROUND(AVG(o.Total_Amount), 2) AS Average_Order_Value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Orders DESC;