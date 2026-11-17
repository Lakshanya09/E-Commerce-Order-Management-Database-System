# WEEK 14 – BUSINESS INTELLIGENCE AND AI DATA PREPARATION

## 1. SQL Analytical Queries
Generated three analytical reports:
- **Sales Performance:** Total sales, number of orders, average order value and monthly revenue.
- **Customer Analysis:** Customer name, total purchases, number of orders and last purchase date.
- **Product Performance:** Product name, quantity sold, revenue generated and product ranking.

## 2. Window Functions
Implemented:
- `RANK()` – Ranks products and customers based on sales and spending.
- `DENSE_RANK()` – Ranks products without skipping rank numbers.
- `ROW_NUMBER()` – Generates the latest order sequence for each customer.

## 3. Customer Segmentation
Classified customers into:
- Premium / High Value
- Regular
- Low Value

Segmentation is based on total spending and purchase frequency.

## 4. AI-Ready Dataset Preparation
Prepared a customer-level dataset by combining multiple tables.

**Selected Features:**
- Customer ID
- Total Purchases
- Total Spending
- Average Order Value
- Total Quantity Ordered
- Unique Products Bought
- Encoded Price Category
- Last Purchase Date, Year, Month and Day

**Data Preparation:**
- Combined tables using JOIN operations.
- Used GROUP BY to generate customer-level records.
- Applied COALESCE() to handle missing numerical values.
- Used CASE statements for numerical category encoding.
- Extracted date-based features.

## 5. Feature Extraction
Extracted meaningful customer, product and time-based features, including:
- Purchase count, total spending and average order value.
- Product quantity and revenue.
- Unique products purchased.
- Last purchase year, month and day.

## 6. Business Intelligence Reports

### Report 1: Customer Segmentation Report

<img width="496" height="56" alt="image" src="https://github.com/user-attachments/assets/df5b9004-3479-436c-82d9-4adbb536785e" />

Displays customer category, purchase frequency and total spending.

### Report 2: Sales Ranking Report

<img width="356" height="59" alt="image" src="https://github.com/user-attachments/assets/51897dbf-d619-4e80-8fa3-9c32b2a774ae" />

Displays product name, total sales and sales rank using RANK().

### Report 3: AI Dataset Report

<img width="1025" height="42" alt="image" src="https://github.com/user-attachments/assets/ff9d9319-699b-4094-8157-db5231e752a3" />

Documents selected features, data cleaning and preparation steps, and final dataset structure.

## Conclusion
Successfully implemented advanced SQL analytics, window functions, customer segmentation, feature extraction and AI-ready dataset preparation to support business decision-making and future Machine Learning applications.

