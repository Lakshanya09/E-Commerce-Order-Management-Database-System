-- ===========================================
-- CREATE DATABASE
-- ===========================================
DROP DATABASE IF EXISTS inventory_db;

CREATE DATABASE inventory_db;
USE inventory_db;

-- ===========================================
-- CREATE CATEGORIES TABLE
-- ===========================================
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- CREATE PRODUCTS TABLE
-- ===========================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_products_categories
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===========================================
-- INSERT CATEGORIES
-- ===========================================
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Mobile phones, laptops and electronic accessories'),
('Home Appliances', 'Kitchen and home appliances'),
('Books & Stationery', 'Books and office supplies'),
('Apparel', 'Clothing and fashion accessories'),
('Sports & Fitness', 'Sports equipment and fitness accessories');

-- ===========================================
-- INSERT PRODUCTS (25 PRODUCTS)
-- ===========================================

INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES

-- Electronics (1-5)
('Wireless Bluetooth Headphones',1,59.99,120),
('Gaming Laptop 16GB RAM',1,1199.50,15),
('Smart Watch',1,199.99,40),
('Wireless Mouse',1,25.99,90),
('Bluetooth Speaker',1,79.99,60),

-- Home Appliances (6-10)
('Microwave Oven 20L',2,85.00,45),
('Air Fryer',2,110.00,35),
('Electric Kettle',2,30.50,70),
('Mixer Grinder',2,95.00,28),
('Rice Cooker',2,65.99,50),

-- Books & Stationery (11-15)
('SQL Database Design Guide',3,29.99,200),
('A4 Notebook',3,3.99,400),
('Ball Pen Pack',3,5.99,300),
('Scientific Calculator',3,24.99,60),
('Drawing Book',3,6.99,120),

-- Apparel (16-20)
('Cotton Graphic T-Shirt',4,19.99,150),
('Sports Shoes',4,69.99,55),
('Denim Jeans',4,45.99,80),
('Hoodie',4,39.99,65),
('Leather Belt',4,18.99,90),

-- Sports & Fitness (21-25)
('Football',5,24.99,60),
('Yoga Mat',5,18.99,120),
('Dumbbell Set',5,75.00,22),
('Cricket Bat',5,89.99,18),
('Skipping Rope',5,12.99,150);

-- ===========================================
-- UPDATE QUERIES
-- ===========================================

UPDATE products
SET price = 54.99,
    stock_quantity = 140
WHERE product_id = 1;

UPDATE products
SET price = price * 1.10
WHERE category_id = 1;

UPDATE products
SET stock_quantity = stock_quantity + 20
WHERE category_id = 3;

-- ===========================================
-- DELETE QUERIES
-- ===========================================

-- Delete a single product
DELETE FROM products
WHERE product_id = 25;

-- Delete Sports & Fitness category
-- (Deletes remaining products 21-24 because of ON DELETE CASCADE)
DELETE FROM categories
WHERE category_id = 5;

-- ===========================================
-- REPORT 1
-- ===========================================

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity,
    (p.price * p.stock_quantity) AS total_inventory_value
FROM products p
JOIN categories c
ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

-- ===========================================
-- REPORT 2
-- ===========================================

SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS total_products,
    ROUND(AVG(p.price),2) AS average_price,
    SUM(p.stock_quantity) AS total_stock_count,
    SUM(p.price * p.stock_quantity) AS total_category_value
FROM categories c
LEFT JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_category_value DESC;

-- ===========================================
-- REPORT 3
-- ===========================================

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.stock_quantity
FROM products p
JOIN categories c
ON p.category_id = c.category_id
WHERE p.stock_quantity < 25
ORDER BY p.stock_quantity ASC;