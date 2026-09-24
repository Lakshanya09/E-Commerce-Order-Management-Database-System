
# DATABASE RELATIONSHIP ANALYSIS

## Overview

This project implements SQL JOIN queries on an E-Commerce Database to combine and analyse customer, order, product, and payment information.

## Tables Used

* `customers`
* `orders`
* `order_details`
* `products`
* `payment`

## Operations Performed

* Combined related tables using `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`
* Retrieved customer and order information
* Retrieved order and payment details
* Retrieved products purchased by customers
* Identified customers without purchases
* Identified products with no sales
* Generated a complete order report
* Analysed customer purchase history
* Generated sales and payment reports
* Analysed customer spending and order activity

## INNER JOIN

Retrieved matching records from customers, orders, products, and payment tables.

**Reports:**

* Customer and order details
<img width="348" height="138" alt="image" src="https://github.com/user-attachments/assets/bdb5d912-56f3-4b4b-a424-970b24fb6fcd" />

* Order and payment information
<img width="721" height="135" alt="image" src="https://github.com/user-attachments/assets/44a437f8-1cb9-4dd1-b48b-8890fd93caa4" />

* Products purchased by customers
<img width="505" height="174" alt="image" src="https://github.com/user-attachments/assets/3741dad5-a8d6-4069-8658-783cc0a71be9" />

## LEFT JOIN

Retrieved all records from the left table, including records without matching data.

**Reports:**
* All customers with their orders
<img width="334" height="151" alt="image" src="https://github.com/user-attachments/assets/627cf1cd-5017-40f1-b693-790c47332a8f" />

* Customers without purchases
<img width="384" height="53" alt="image" src="https://github.com/user-attachments/assets/01559849-da10-4731-80e2-98fb77ad9145" />

* Products including products with no sales
<img width="558" height="493" alt="image" src="https://github.com/user-attachments/assets/d3275226-875a-4e08-ad0e-a98b6f5a4abf" />


## RIGHT JOIN

Retrieved all records from the right table and matching records from the left table.

**Reports:**

* All orders with customer information
<img width="337" height="144" alt="image" src="https://github.com/user-attachments/assets/64fed94f-115f-49e6-98ba-14b2d6ea3284" />

* Orders with missing customer details
<img width="380" height="62" alt="image" src="https://github.com/user-attachments/assets/a91231c6-da85-4e31-94cf-036063f8185d" />

* Payment records with order information
<img width="610" height="131" alt="image" src="https://github.com/user-attachments/assets/5f588219-2b4e-438a-8cf1-64a42052d3a8" />


## Complete Order Report
<img width="810" height="497" alt="image" src="https://github.com/user-attachments/assets/5e10818f-741a-462b-89ea-b044013de743" />


Combined `customers`, `orders`, `order_details`, `products`, and `payment` tables.


**Output Includes:**

* Customer Name
* Product Name
* Quantity
* Order Date
* Total Amount
* Payment Status

## Customer Purchase History

<img width="807" height="105" alt="image" src="https://github.com/user-attachments/assets/8220b4c1-b231-4b58-9bc2-1edeb9c09bde" />


The queries retrieve:

* Products purchased by customers
* Total amount spent by each customer
* Number of orders placed by each customer
* Latest purchase details

## Business Reports

### REPORT 1 Customer Order Report

<img width="482" height="134" alt="image" src="https://github.com/user-attachments/assets/51418e55-8c0f-4069-bb98-38abf65b46c1" />

Displays customer name, order ID, order date, and order status.

### REPORT 2 Sales Report

<img width="457" height="130" alt="image" src="https://github.com/user-attachments/assets/25ef8f01-4555-482c-b638-ac6440f5a2f1" />

Displays product name, quantity sold, and total revenue.

### REPORT 3 Payment Analysis Report

Displays payment mode, number of transactions, and successful payments.

### Customer Purchase Analysis

<img width="803" height="130" alt="image" src="https://github.com/user-attachments/assets/3ed232ad-de1c-43d1-99e9-69aa805def3f" />

Analyses customer spending and number of orders.

## SQL Concepts Used

* **SELECT** – Retrieves required data
* **JOIN** – Combines related tables
* **WHERE** – Filters records
* **GROUP BY** – Groups data for analysis
* **SUM()** – Calculates totals
* **COUNT()** – Counts records
* **MAX()** – Finds the latest purchase
* **CASE** – Performs conditional calculations
* **ORDER BY** – Sorts results
* **IS NULL** – Identifies missing records


This project demonstrates the use of SQL JOINs and aggregate functions to retrieve meaningful information and generate useful business reports from an E-Commerce Database.
