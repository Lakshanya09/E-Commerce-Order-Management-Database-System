# Product Category Database

The Product Category Database is a MySQL-based project developed to manage products and their categories efficiently. It demonstrates SQL operations such as CREATE, INSERT, UPDATE, DELETE, JOIN, and report generation, while maintaining data integrity using Primary Keys, Foreign Keys, and ON DELETE CASCADE.


### Report 1 – Product Inventory:

<img width="750" height="454" alt="image" src="https://github.com/user-attachments/assets/0aba31ff-e542-4aa2-bc3e-06731343760e" />


"This report displays all available products with their category, price, stock quantity, and total inventory value. The total inventory value is calculated by multiplying the price by the stock quantity. After the delete operations, the inventory contains 20 products."


### Report 2 – Category Summary

<img width="745" height="115" alt="image" src="https://github.com/user-attachments/assets/fd8cefec-b016-456b-9b0a-905353f4632b" />


"This report provides a category-wise summary showing the total number of products, average price, total stock, and total inventory value. Each remaining category has 5 products, making it easy to compare inventory performance across categories."


### Report 3 – Low Stock Report

<img width="512" height="71" alt="Screenshot 2026-08-06 205558" src="https://github.com/user-attachments/assets/9dd2a77c-76fa-4a31-98a5-9e0f97bbf5ef" />


"This report lists products with a stock quantity below 25. Currently, only the Gaming Laptop 16GB RAM has low stock, with 15 units, indicating that it should be restocked."

### Conclusion

The Product Category Database was successfully designed and implemented using MySQL to manage product and category information efficiently. An Entity-Relationship (ER) Diagram was created to model the relationship between the Categories and Products entities, ensuring a clear and well-structured database design through the use of Primary Keys and Foreign Keys.

The project demonstrates essential SQL concepts, including database creation, data manipulation (INSERT, UPDATE, DELETE), table relationships, and report generation. The implementation of the ON DELETE CASCADE constraint maintains referential integrity by automatically removing related products when a category is deleted. Overall, this project provides a simple, organized, and efficient solution for inventory management while reinforcing fundamental relational database concep
