# WEEK 15 – INDUSTRY CAPSTONE PROJECT: E-COMMERCE INTELLIGENCE PLATFORM

## 1. Project Overview
Developed a unified E-Commerce Intelligence Platform using MySQL to manage customers, products, sellers, inventory, orders, payments and reviews while generating business insights.

## 2. Database Design and Normalization
- Created nine main entities with primary and foreign keys.
- Established relationships between all modules.
- Applied 1NF, 2NF and 3NF normalization.
- Maintained data integrity using constraints.

## 3. Business Data Insertion
Inserted realistic sample records:
- Customers – 50
- Products – 100
- Sellers – 20
- Orders – 100
- Payments – 100
- Reviews – 50
- Inventory records for products

## 4. SQL Query Implementation
Implemented:
- Basic queries: SELECT, WHERE, ORDER BY, DISTINCT, LIKE and BETWEEN.
- Intermediate queries: JOIN, aggregate functions, GROUP BY and HAVING.
- Advanced queries: Subqueries, nested queries and window functions.

## 5. Database Objects and Automation

**Views:**
- Customer Order History
- Sales Report
- Product Performance

**Stored Procedures:**
- Order Placement
- Stock Update
- Sales Calculation

**Functions:**
- Total Customer Spending
- Product Revenue Calculation

**Triggers:**
- Automatic stock reduction after order placement.
- Order status update after payment.
- Audit log maintenance.

## 6. Performance Optimization
- Created indexes for product search, customer lookup and order retrieval.
- Used EXPLAIN to analyse query execution plans.
- Added indexes for order details and payment status.

## 7. Business Intelligence Reports

**Sales Intelligence Report**

<img width="821" height="257" alt="image" src="https://github.com/user-attachments/assets/f8a94647-25a2-4039-861e-4f06d400747c" />

Displays total revenue, average order value, monthly sales trends, best-selling products, and top revenue-generating categories.

**Customer Intelligence Report**

<img width="734" height="242" alt="image" src="https://github.com/user-attachments/assets/941c3404-f308-44f7-adb1-05bed2114faf" />

Highlights high-value customers, their purchase frequency, and customer segmentation.

**Inventory Intelligence Report**

<img width="835" height="118" alt="image" src="https://github.com/user-attachments/assets/258b9bd5-8c47-4f33-9244-9fc541455f5e" />

Identifies low-stock, fast-moving, and overstocked products.

**Product Intelligence Report**

<img width="1010" height="278" alt="image" src="https://github.com/user-attachments/assets/0bacc678-ce67-4834-8bb9-8791bbe00913" />

Displays the highest-rated products, product ratings and review counts, and customer feedback trends.

## 8. Conclusion
Successfully developed an integrated E-Commerce Intelligence Platform demonstrating database design, normalization, SQL programming, automation, performance optimization and Business Intelligence reporting to support business decision-making.



