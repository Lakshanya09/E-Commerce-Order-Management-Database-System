# Order Management System

## Overview

This project implements an Order Management System for managing customer orders, products, quantities, prices, and order status.

## Tables Created

* `Orders`
* `Order_Details`

The tables are connected with the existing `Customers` and `Products` tables using primary keys and foreign keys.

## Operations Performed

* Created Orders and Order_Details tables
* Inserted orders and order details
* Calculated total order amount
* Updated order status and product quantity
* Deleted cancelled order
* Generated 3 required reports
  
## Customer Order History

This report provides a detailed view of customers’ past orders, including the customer name, order ID, order date, total amount, and order status. It helps track and review customer purchase history easily.
Functions / SQL Concepts Used:
* **SELECT** – Retrieves the required customer and order details.
* **JOIN** – Connects the `Customers` and `Orders` tables using `Customer_ID`.
* **AS** – Renames `Order_Status` as `Status`.
* **ORDER BY** – Sorts the orders by order date.

## Reports

### 1. Customer Order History

Shows customer name, order ID, order date, total amount, and order status.

**Output:**

<img width="565" height="134" alt="Screenshot 2026-09-01 112502" src="https://github.com/user-attachments/assets/e9a0c46f-6948-4316-8aff-f14f44f5556b" />


### 2. Product-wise Order Report

Shows the number of times each product was ordered and the total quantity sold.

**Output:**

<img width="503" height="128" alt="Screenshot 2026-09-01 112733" src="https://github.com/user-attachments/assets/ec0dc814-24c3-4e34-a1ec-f71e07576877" />

### 3. Customer Purchase Analysis

Shows total orders, total spending, and average order value for each customer.

**Output:**

<img width="524" height="112" alt="Screenshot 2026-09-01 112759" src="https://github.com/user-attachments/assets/66bd0d34-7e9f-4051-9ce4-2ecc6801dd37" />




