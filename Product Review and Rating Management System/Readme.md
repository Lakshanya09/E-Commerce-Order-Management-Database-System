# ⭐ Product Review & Rating Management – SQL Project
## 📌 Project Overview

This project focuses on creating and analyzing a Product Review and Rating Management System using MySQL. The Review table is connected with the Customers and Products tables through foreign key relationships, allowing customer feedback and product ratings to be stored and analyzed.

## 🎯 Objectives
Create a structured Review table.

Establish Customer–Review and Product–Review relationships using foreign keys.

Store product ratings, customer comments, and review dates.

Validate ratings using a CHECK constraint (1–5).

Analyze product ratings and customer feedback.

Identify highly rated and low-rated products.

## 🗄️ Review Table Design

The Review table stores customer feedback such as Customer ID, Product ID, Rating, Review Text, and Review Date. It uses Primary Key, Foreign Key, NOT NULL, Auto Increment, Default, and CHECK constraints for proper data management.

## ER Relationship

The Review table is connected to the Customers and Products tables using foreign key relationships:

Customers (1) ─────── (Many) Review

Products (1) ─────── (Many) Review

One customer can write multiple reviews, while each review belongs to one customer. Similarly, one product can have multiple reviews, while each review belongs to one product.

<img width="840" height="808" alt="Screenshot 2026-09-09 142606" src="https://github.com/user-attachments/assets/7e8dde44-a2ce-4f81-be0f-4c45fdbca98e" />


## 📊 Product Review Analysis Reports

### Report 1 - Product Rating Analysis
<img width="518" height="450" alt="Screenshot 2026-09-09 142447" src="https://github.com/user-attachments/assets/00371a21-b6e8-48ab-b6ee-cfaa44df96a9" />

Shows the product name, number of reviews, and average rating to evaluate overall product performance.

### Report 2 - Customer Feedback Analysis
<img width="674" height="449" alt="Screenshot 2026-09-09 142516" src="https://github.com/user-attachments/assets/52a3945f-e1ba-487b-87ae-827bf46674bf" />

Shows the number of reviews, average rating, and product performance, helping identify most reviewed, highly rated, and products requiring improvement.

### Report 3 – Rating Distribution
<img width="304" height="84" alt="Screenshot 2026-09-09 142530" src="https://github.com/user-attachments/assets/dd74a470-a1ef-4c54-a4ef-12a3ac58d00a" />

Shows the distribution of 5-star, 4-star, and low ratings, providing an overview of customer satisfaction.

## 🛠️ Technologies Used
MySQL

MySQL Workbench

SQL

## ✅ Conclusion

The Product Review and Rating Management System provides a structured way to store and analyze customer feedback. The SQL queries help identify highly rated products, customer satisfaction levels, review counts, and products requiring improvement.

