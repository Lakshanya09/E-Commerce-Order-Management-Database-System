# SQL Query Implementation – E-Commerce Database

## Overview

This project implements SQL queries for an E-Commerce Database. It is used to retrieve and analyse information about customers, products, orders, payments, reviews, and product availability.

## Tables Used

- `customers`
- `products`
- `categories`
- `orders`
- `order_details`
- `payment`
- `review`

## Operations Performed

- Retrieved customer, product, order, and payment details
- Filtered products and customers using `WHERE`
- Sorted records using `ORDER BY`
- Retrieved unique values using `DISTINCT`
- Searched products using price range and product name
- Joined customers, orders, order details, products, and categories
- Applied multiple filtering conditions
- Generated basic business reports

## Product Search Report

This report shows products within the selected price range. It helps in finding products based on their price and availability.

**Output:**

<img width="388" height="47" alt="Product Search Report" src="https://github.com/user-attachments/assets/0ebf1ee3-0411-41f4-8887-ac3dce666622" />

## Customer Information Report

This report shows customer order information, including the customer name, order ID, order date, product purchased, quantity, price, and order status.

**Output:**

<img width="832" height="173" alt="Customer Information Report" src="https://github.com/user-attachments/assets/d09734b8-f066-491e-8849-c9e7eaafcaf8" />

## Order Report

This report gives a summary of the total orders along with completed, pending, and cancelled orders.

**Output:**

<img width="510" height="47" alt="Order Report" src="https://github.com/user-attachments/assets/74f109c2-0e5e-4333-8720-fec2a3e6c77a" />

## Product Performance Report

This report shows product price, number of reviews, stock quantity, and availability status. It helps to understand the basic performance and availability of products.

**Output:**

<img width="696" height="454" alt="Product Performance Report" src="https://github.com/user-attachments/assets/90f0af19-5037-42da-88b2-ee7d9acd015a" />

## SQL Concepts Used

- **SELECT** – Retrieves the required data from the tables.
- **WHERE** – Filters records based on specific conditions.
- **JOIN** – Combines data from related tables.
- **ORDER BY** – Sorts the query results.
- **DISTINCT** – Retrieves unique values.
- **GROUP BY** – Groups records for analysis.
- **CASE** – Displays product availability based on stock quantity.

