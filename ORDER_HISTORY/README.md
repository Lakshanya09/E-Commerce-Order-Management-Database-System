# Customer Order History

This report provides a detailed view of customers’ past orders, including the customer name, order ID, order date, total amount, and order status. It helps track and review customer purchase history easily.
Functions / SQL Concepts Used:
* **SELECT** – Retrieves the required customer and order details.
* **JOIN** – Connects the `Customers` and `Orders` tables using `Customer_ID`.
* **AS** – Renames `Order_Status` as `Status`.
* **ORDER BY** – Sorts the orders by order date.

## Report 1: Customer Order History
<img width="514" height="167" alt="image" src="https://github.com/user-attachments/assets/d512cdd9-0180-432f-a9ef-f0b9977e0946" />


Displays each customer’s order details, including customer name, order ID, order date, total amount, and order status.

## Report 2: Product-wise Order Report
<img width="499" height="135" alt="image" src="https://github.com/user-attachments/assets/4bf5c54d-f8f8-45e7-8049-ac7a3573cd3a" />


Shows how many times each product was ordered and the total quantity of each product sold.

## Report 3: Customer Purchase Analysis
<img width="523" height="130" alt="image" src="https://github.com/user-attachments/assets/b8563354-b7a3-4551-ab7d-94583db199b5" />


Analyzes customer purchasing activity by showing total orders, total spending, and average order value for each customer. It also helps identify the customer with the maximum number of orders.

## Total Sales

Calculates the overall sales revenue by adding the total amount of all orders.
