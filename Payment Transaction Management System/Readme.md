# 💳 Payment Management & Analysis – SQL Project

## 📌 Project Overview

This project focuses on creating and analyzing a **Payment Management System** using MySQL. The Payment table is connected with the Orders table through a **foreign key relationship**, allowing payment details to be tracked for each order.

---

## 🎯 Objectives

* Create a structured Payment table.
* Establish an **Order–Payment relationship** using a foreign key.
* Store payment mode, status, date, and transaction amount.
* Perform payment status analysis.
* Analyze payment methods and revenue.
* Display customer payment history using table joins.

---

## 🗄️ Payment Table Design

The `Payment` table stores payment details such as Order ID, Payment Date, Payment Mode, Payment Status, and Transaction Amount. It uses **Primary Key, Foreign Key, Auto Increment, Default, and CHECK constraints** for proper data management.


---

## 🔗 ER Relationship

The Payment table is connected to the Orders table using:

**Orders (1) ─────── (Many) Payment**

One order can have payment records associated with it, while each payment belongs to a particular order.

<img width="760" height="812" alt="Screenshot 2026-09-02 102742" src="https://github.com/user-attachments/assets/792ec3e6-699d-488f-ada8-47be10ecab53" />


---


# 📊 Payment Analysis Reports

## Report 1 – Payment Mode Analysis

<img width="511" height="49" alt="image" src="https://github.com/user-attachments/assets/5ab56ae5-fd57-4b8c-9c24-65c4f431f6a8" />

Shows the number of UPI transactions, card payments and the most preferred payment method.

---

## Report 2 – Revenue Analysis

<img width="669" height="50" alt="image" src="https://github.com/user-attachments/assets/5fc0dd41-70d7-4fe7-86bd-ffe62beeae18" />

Shows total revenue, revenue by payment method and average transaction amount.

---

## Report 3 – Customer Payment History

<img width="564" height="130" alt="image" src="https://github.com/user-attachments/assets/d331e0b7-22a7-4054-9f03-cc583b326a02" />

Shows customer name, order ID, payment mode, amount and payment status.
---

## 🛠️ Technologies Used

* **MySQL**
* **MySQL Workbench**
* SQL

---

## ✅ Conclusion

The Payment Management System provides a structured way to store and analyze customer payment information. The SQL queries help identify preferred payment methods, analyze revenue, monitor transaction statuses, and track individual customer payment history.

