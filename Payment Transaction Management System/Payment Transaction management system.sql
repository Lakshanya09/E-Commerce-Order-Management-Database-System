CREATE TABLE Payment(
Payment_ID int auto_increment,
Order_ID int NOT NULL,
Payment_Date timestamp default current_timestamp,
Payment_Mode varchar(100) NOT NULL,
Payment_Status varchar(100),
Transaction_Amount decimal(10,2),


constraint pk_key primary key (Payment_ID),
constraint chk_amt CHECK(TRANSACTION_AMOUNT>0),
constraint fk_key foreign key (Order_ID) references orders(Order_ID)
);

SELECT * FROM ORDERS;

INSERT INTO payment(Order_ID, Payment_Mode, Payment_Status, Transaction_Amount) 
VALUES 
(1, "CASH ON DELIVERY", "SUCCESSFUL", 2500.00),
(2, "UPI", "PENDING", 1800.00),
(3, "CREDIT CARD", "FAILED", 3200.00),
(4, "UPI", "SUCCESSFUL", 2000.00),
(5, "COD", "SUCCESSFUL", 3000.00);

SELECT * FROM payment;
select * FROM Payment;

-- Display all successful payment.

select * FROM payment where Payment_Status = "SUCCESSFUL";

-- Find the Failed payment.

select * FROM payment where Payment_Status = "Failed";


-- Count total Successfull and Failed payment.

select
count(*) as Number_of_Transcation, Payment_Mode
from payment group by Payment_Mode;

select
count(*) as Number_of_Transcation, Payment_Status
from payment group by Payment_Status;

select * from payment where Payment_Status = "FAILED";

-- Update failed payments after retry

update payment set Payment_Status = "SUCCESSFUL" where Payment_ID = 3;

select * from payment where Payment_Status = "PENDING";


-- REPORT 1: PAYMENT MODE ANALYSIS

SELECT
    SUM(Payment_Mode = 'UPI') AS UPI_Transactions,
    SUM(Payment_Mode = 'CREDIT CARD') AS Card_Payments,
    (
        SELECT Payment_Mode
        FROM Payment
        GROUP BY Payment_Mode
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS Most_Preferred_Payment_Method
FROM Payment;

-- REPORT 2: REVENUE ANALYSIS

SELECT
    SUM(Transaction_Amount) AS Total_Revenue,
    AVG(Transaction_Amount) AS Average_Transaction_Amount,
    SUM(CASE WHEN Payment_Mode = 'UPI'
             THEN Transaction_Amount ELSE 0 END) AS UPI_Revenue,
    SUM(CASE WHEN Payment_Mode = 'CREDIT CARD'
             THEN Transaction_Amount ELSE 0 END) AS Card_Revenue,
    SUM(CASE WHEN Payment_Mode IN ('COD', 'CASH ON DELIVERY')
             THEN Transaction_Amount ELSE 0 END) AS COD_Revenue
FROM Payment
WHERE Payment_Status = 'SUCCESSFUL';

-- REPORT 3: CUSTOMER PAYMENT HISTORY

SELECT
    c.Customer_Name,
    o.Order_ID,
    p.Payment_Mode,
    p.Transaction_Amount AS Amount,
    p.Payment_Status
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Payment p
    ON o.Order_ID = p.Order_ID
ORDER BY c.Customer_Name;