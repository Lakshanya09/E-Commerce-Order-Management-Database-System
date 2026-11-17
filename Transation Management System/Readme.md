# TRANSACTION MANAGEMENT SYSTEM USING SQL

## Overview

This project implements Transaction Management in an E-Commerce Database using SQL to ensure reliable order processing, payment handling, and inventory management using COMMIT, ROLLBACK, and ACID properties.

## Tables Used

- `Customer`
- `Orders`
- `Order_Details`
- `Products`
- `Payment`
- `Inventory`

## Operations Performed

- Implemented order placement transactions
- Inserted order and product details
- Updated inventory stock
- Recorded UPI payment details
- Applied COMMIT and ROLLBACK operations
- Verified database consistency

## 1. Successful Order Transaction Execution

- Created a new customer order.
- Inserted ordered product details.
- Reduced inventory stock.
- Recorded successful UPI payment.
- Updated order status to Completed.
- Executed COMMIT to save all changes.

## 2. Failed Transaction with ROLLBACK Demonstration

- Created a temporary order.
- Inserted product details.
- Simulated payment failure.
- Executed ROLLBACK to cancel all transaction changes.
- Verified stock restoration and transaction cancellation.

## 3. ACID Properties

- **Atomicity** – All transaction operations succeed together or are completely cancelled.
- **Consistency** – Maintains database accuracy and prevents negative stock.
- **Isolation** – Prevents concurrent transactions from interfering with each other.
- **Durability** – Ensures committed changes remain permanently stored.

## 4. Transaction Reports

### REPORT 1: Order Transaction Report

<img width="525" height="66" alt="image" src="https://github.com/user-attachments/assets/090486b7-b8e2-46d9-aad9-ac30903fc4fa" />

Displays order ID, customer name, amount, payment status, and order status.

### REPORT 2: Failed Transaction Report

<img width="513" height="53" alt="image" src="https://github.com/user-attachments/assets/b32a0a8b-8931-43a7-9224-ad8a4d57bbf7" />

Displays failed payments, cancelled orders, and stock restoration details.

### REPORT 3: Inventory Update Report

<img width="465" height="45" alt="image" src="https://github.com/user-attachments/assets/ee88f2b1-6dda-42af-a03b-e1e9a4455335" />

Displays product name, previous stock, current stock, and quantity sold.

## SQL Concepts Used

- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`
- `ACID Properties`
- `SELECT FOR UPDATE`
- `INSERT`
- `UPDATE`
- `JOIN`
- `CASE`

This project demonstrates reliable transaction processing in an E-Commerce Database while maintaining data integrity and consistency.
