-- =============================================================================
-- Week 15: Industry Capstone Project - E-Commerce Intelligence Platform
-- =============================================================================

DROP DATABASE IF EXISTS ecommerce_intelligence_platform;
CREATE DATABASE ecommerce_intelligence_platform;
USE ecommerce_intelligence_platform;

-- -----------------------------------------------------------------------------
-- 1. DDL: NORMALIZED TABLES (1NF, 2NF, 3NF)
-- -----------------------------------------------------------------------------

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(120) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(80) NOT NULL,
    rating DECIMAL(3,2) DEFAULT 4.00 CHECK (rating BETWEEN 1.00 AND 5.00),
    joined_date DATE NOT NULL
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(80) NOT NULL,
    registration_date DATE NOT NULL,
    loyalty_tier ENUM('Bronze', 'Silver', 'Gold', 'Platinum') DEFAULT 'Bronze'
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    seller_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    cost_price DECIMAL(10,2) NOT NULL CHECK (cost_price > 0),
    created_at DATE NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id)
);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL UNIQUE,
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    reorder_level INT NOT NULL DEFAULT 15,
    warehouse_location VARCHAR(60) NOT NULL,
    last_updated DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status ENUM('Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Processing',
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    shipping_city VARCHAR(80) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    payment_date DATE NOT NULL,
    payment_method ENUM('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    amount_paid DECIMAL(12,2) NOT NULL CHECK (amount_paid >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR(500),
    review_date DATE NOT NULL,
    UNIQUE KEY uq_product_customer_review (product_id, customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE Audit_Log (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(60) NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    record_id INT NOT NULL,
    details VARCHAR(255),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- -----------------------------------------------------------------------------
-- 2. DML: REALISTIC BUSINESS DATA INSERTION
-- -----------------------------------------------------------------------------

INSERT INTO Category (category_id, category_name, description) VALUES
(1, 'Electronics', 'Smartphones, laptops, audio gear, and smart accessories'),
(2, 'Fashion & Apparel', 'Men and women clothing, footwear, and seasonal wear'),
(3, 'Home & Kitchen', 'Cookware, home appliances, lighting, and decor'),
(4, 'Books & Stationery', 'Academic textbooks, fiction, notebooks, and office supplies'),
(5, 'Beauty & Personal Care', 'Skincare, haircare, grooming, and wellness essentials'),
(6, 'Sports & Fitness', 'Gym equipment, yoga mats, sportswear, and outdoor gear'),
(7, 'Groceries & Gourmet', 'Organic staples, beverages, dry fruits, and snacks'),
(8, 'Toys & Gaming', 'Board games, educational kits, and gaming peripherals');

INSERT INTO Seller (seller_id, seller_name, email, phone, city, state, rating, joined_date) VALUES
(1, 'Apex Tech Mart', 'apextechmart@sellerhub.in', '+91-9895822412', 'Chennai', 'Tamil Nadu', 4.01, '2024-10-08'),
(2, 'Urban Looms India', 'urbanloomsindia@sellerhub.in', '+91-9842868828', 'Bengaluru', 'Karnataka', 4.12, '2024-04-14'),
(3, 'KitchenCraft Direct', 'kitchencraftdirect@sellerhub.in', '+91-9883197857', 'Mumbai', 'Maharashtra', 3.99, '2025-03-08'),
(4, 'ScholarPress Store', 'scholarpressstore@sellerhub.in', '+91-9814265799', 'Hyderabad', 'Telangana', 3.93, '2024-08-11'),
(5, 'GlowPure Naturals', 'glowpurenaturals@sellerhub.in', '+91-9841227216', 'Pune', 'Maharashtra', 4.41, '2024-01-28'),
(6, 'FitZone Athletics', 'fitzoneathletics@sellerhub.in', '+91-9885329037', 'Delhi', 'Delhi', 4.1, '2025-07-12'),
(7, 'HarvestBasket Co', 'harvestbasketco@sellerhub.in', '+91-9866306997', 'Coimbatore', 'Tamil Nadu', 4.12, '2024-10-11'),
(8, 'PlayBox Studio', 'playboxstudio@sellerhub.in', '+91-9810872248', 'Kochi', 'Kerala', 4.66, '2024-06-12'),
(9, 'Deccan Electronics', 'deccanelectronics@sellerhub.in', '+91-9866722344', 'Ahmedabad', 'Gujarat', 4.24, '2024-06-08'),
(10, 'VogueThread Retail', 'voguethreadretail@sellerhub.in', '+91-9838898923', 'Kolkata', 'West Bengal', 4.86, '2024-12-10'),
(11, 'HomeNest Essentials', 'homenestessentials@sellerhub.in', '+91-9823718431', 'Chennai', 'Tamil Nadu', 3.99, '2024-04-09'),
(12, 'PageTurner Hub', 'pageturnerhub@sellerhub.in', '+91-9858181396', 'Bengaluru', 'Karnataka', 4.75, '2024-09-27'),
(13, 'AuraCare Solutions', 'auracaresolutions@sellerhub.in', '+91-9815831819', 'Mumbai', 'Maharashtra', 4.63, '2025-07-03'),
(14, 'ProGear Sports', 'progearsports@sellerhub.in', '+91-9826753883', 'Hyderabad', 'Telangana', 4.87, '2025-01-22'),
(15, 'SpiceRoute Gourmet', 'spiceroutegourmet@sellerhub.in', '+91-9820576383', 'Pune', 'Maharashtra', 4.45, '2025-01-05'),
(16, 'PixelPlay Gadgets', 'pixelplaygadgets@sellerhub.in', '+91-9887490893', 'Delhi', 'Delhi', 4.09, '2024-03-12'),
(17, 'MetroMart Traders', 'metromarttraders@sellerhub.in', '+91-9816150444', 'Coimbatore', 'Tamil Nadu', 4.56, '2024-10-23'),
(18, 'SouthStar Logistics', 'southstarlogistics@sellerhub.in', '+91-9820709497', 'Kochi', 'Kerala', 4.76, '2024-04-13'),
(19, 'EliteStyle Boutique', 'elitestyleboutique@sellerhub.in', '+91-9861019678', 'Ahmedabad', 'Gujarat', 4.18, '2025-01-08'),
(20, 'PrimeValue Bazaar', 'primevaluebazaar@sellerhub.in', '+91-9831831063', 'Kolkata', 'West Bengal', 4.27, '2024-08-02');

INSERT INTO Customer (customer_id, first_name, last_name, email, phone, city, state, registration_date, loyalty_tier) VALUES
(1, 'Aarav', 'Patel', 'aarav.patel1@mail.in', '+91-9799949389', 'Hyderabad', 'Telangana', '2025-05-17', 'Gold'),
(2, 'Ananya', 'Verma', 'ananya.verma2@mail.in', '+91-9796977837', 'Pune', 'Maharashtra', '2025-02-06', 'Silver'),
(3, 'Vikram', 'Krishnan', 'vikram.krishnan3@mail.in', '+91-9732969840', 'Delhi', 'Delhi', '2025-10-01', 'Gold'),
(4, 'Priya', 'Desai', 'priya.desai4@mail.in', '+91-9731931511', 'Coimbatore', 'Tamil Nadu', '2025-08-25', 'Silver'),
(5, 'Karthik', 'Bhat', 'karthik.bhat5@mail.in', '+91-9795899313', 'Kochi', 'Kerala', '2025-12-19', 'Silver'),
(6, 'Divya', 'Mehta', 'divya.mehta6@mail.in', '+91-9753524491', 'Ahmedabad', 'Gujarat', '2025-01-29', 'Bronze'),
(7, 'Rohan', 'Subramanian', 'rohan.subramanian7@mail.in', '+91-9714308421', 'Kolkata', 'West Bengal', '2025-06-11', 'Silver'),
(8, 'Sneha', 'Reddy', 'sneha.reddy8@mail.in', '+91-9718883684', 'Chennai', 'Tamil Nadu', '2025-04-19', 'Platinum'),
(9, 'Arjun', 'Menon', 'arjun.menon9@mail.in', '+91-9786125617', 'Bengaluru', 'Karnataka', '2025-06-11', 'Bronze'),
(10, 'Meera', 'Joshi', 'meera.joshi10@mail.in', '+91-9777005685', 'Mumbai', 'Maharashtra', '2025-07-22', 'Gold'),
(11, 'Siddharth', 'Pillai', 'siddharth.pillai11@mail.in', '+91-9796282117', 'Hyderabad', 'Telangana', '2025-08-23', 'Bronze'),
(12, 'Kavya', 'Chopra', 'kavya.chopra12@mail.in', '+91-9728740864', 'Pune', 'Maharashtra', '2025-05-07', 'Gold'),
(13, 'Aditya', 'Rajan', 'aditya.rajan13@mail.in', '+91-9782340307', 'Delhi', 'Delhi', '2025-05-15', 'Gold'),
(14, 'Nisha', 'Nair', 'nisha.nair14@mail.in', '+91-9767503414', 'Coimbatore', 'Tamil Nadu', '2025-10-26', 'Silver'),
(15, 'Rahul', 'Iyer', 'rahul.iyer15@mail.in', '+91-9739436733', 'Kochi', 'Kerala', '2025-03-12', 'Silver'),
(16, 'Pooja', 'Gupta', 'pooja.gupta16@mail.in', '+91-9722201654', 'Ahmedabad', 'Gujarat', '2025-01-25', 'Gold'),
(17, 'Varun', 'Rao', 'varun.rao17@mail.in', '+91-9730514014', 'Kolkata', 'West Bengal', '2025-11-18', 'Bronze'),
(18, 'Shruti', 'Kulkarni', 'shruti.kulkarni18@mail.in', '+91-9766661351', 'Chennai', 'Tamil Nadu', '2025-11-02', 'Bronze'),
(19, 'Nikhil', 'Sundaram', 'nikhil.sundaram19@mail.in', '+91-9761220073', 'Bengaluru', 'Karnataka', '2025-11-02', 'Platinum'),
(20, 'Lakshmi', 'Sharma', 'lakshmi.sharma20@mail.in', '+91-9781016525', 'Mumbai', 'Maharashtra', '2025-05-09', 'Platinum'),
(21, 'Pranav', 'Patel', 'pranav.patel21@mail.in', '+91-9711540956', 'Hyderabad', 'Telangana', '2025-12-15', 'Gold'),
(22, 'Aishwarya', 'Verma', 'aishwarya.verma22@mail.in', '+91-9782070937', 'Pune', 'Maharashtra', '2025-05-17', 'Gold'),
(23, 'Harish', 'Krishnan', 'harish.krishnan23@mail.in', '+91-9755657579', 'Delhi', 'Delhi', '2025-02-27', 'Bronze'),
(24, 'Deepika', 'Desai', 'deepika.desai24@mail.in', '+91-9731227574', 'Coimbatore', 'Tamil Nadu', '2025-08-21', 'Bronze'),
(25, 'Surya', 'Bhat', 'surya.bhat25@mail.in', '+91-9745351479', 'Kochi', 'Kerala', '2025-09-14', 'Gold'),
(26, 'Aarav', 'Mehta', 'aarav.mehta26@mail.in', '+91-9778139880', 'Ahmedabad', 'Gujarat', '2025-02-24', 'Gold'),
(27, 'Ananya', 'Subramanian', 'ananya.subramanian27@mail.in', '+91-9750056581', 'Kolkata', 'West Bengal', '2025-11-24', 'Silver'),
(28, 'Vikram', 'Reddy', 'vikram.reddy28@mail.in', '+91-9736697396', 'Chennai', 'Tamil Nadu', '2025-03-20', 'Silver'),
(29, 'Priya', 'Menon', 'priya.menon29@mail.in', '+91-9731682744', 'Bengaluru', 'Karnataka', '2025-10-04', 'Platinum'),
(30, 'Karthik', 'Joshi', 'karthik.joshi30@mail.in', '+91-9781182864', 'Mumbai', 'Maharashtra', '2025-01-01', 'Silver'),
(31, 'Divya', 'Pillai', 'divya.pillai31@mail.in', '+91-9775579548', 'Hyderabad', 'Telangana', '2025-01-10', 'Bronze'),
(32, 'Rohan', 'Chopra', 'rohan.chopra32@mail.in', '+91-9758718453', 'Pune', 'Maharashtra', '2025-06-07', 'Bronze'),
(33, 'Sneha', 'Rajan', 'sneha.rajan33@mail.in', '+91-9742329237', 'Delhi', 'Delhi', '2025-10-18', 'Platinum'),
(34, 'Arjun', 'Nair', 'arjun.nair34@mail.in', '+91-9721496211', 'Coimbatore', 'Tamil Nadu', '2025-09-06', 'Gold'),
(35, 'Meera', 'Iyer', 'meera.iyer35@mail.in', '+91-9781498611', 'Kochi', 'Kerala', '2025-03-06', 'Bronze'),
(36, 'Siddharth', 'Gupta', 'siddharth.gupta36@mail.in', '+91-9773791320', 'Ahmedabad', 'Gujarat', '2025-10-09', 'Bronze'),
(37, 'Kavya', 'Rao', 'kavya.rao37@mail.in', '+91-9780823176', 'Kolkata', 'West Bengal', '2025-11-07', 'Silver'),
(38, 'Aditya', 'Kulkarni', 'aditya.kulkarni38@mail.in', '+91-9738427073', 'Chennai', 'Tamil Nadu', '2025-10-04', 'Gold'),
(39, 'Nisha', 'Sundaram', 'nisha.sundaram39@mail.in', '+91-9736998038', 'Bengaluru', 'Karnataka', '2025-06-09', 'Silver'),
(40, 'Rahul', 'Sharma', 'rahul.sharma40@mail.in', '+91-9797225156', 'Mumbai', 'Maharashtra', '2025-07-11', 'Silver'),
(41, 'Pooja', 'Patel', 'pooja.patel41@mail.in', '+91-9779467853', 'Hyderabad', 'Telangana', '2025-08-20', 'Bronze'),
(42, 'Varun', 'Verma', 'varun.verma42@mail.in', '+91-9740158366', 'Pune', 'Maharashtra', '2025-02-02', 'Bronze'),
(43, 'Shruti', 'Krishnan', 'shruti.krishnan43@mail.in', '+91-9788961459', 'Delhi', 'Delhi', '2025-10-11', 'Bronze'),
(44, 'Nikhil', 'Desai', 'nikhil.desai44@mail.in', '+91-9739557077', 'Coimbatore', 'Tamil Nadu', '2025-01-04', 'Bronze'),
(45, 'Lakshmi', 'Bhat', 'lakshmi.bhat45@mail.in', '+91-9794705205', 'Kochi', 'Kerala', '2025-01-31', 'Bronze'),
(46, 'Pranav', 'Mehta', 'pranav.mehta46@mail.in', '+91-9714216175', 'Ahmedabad', 'Gujarat', '2025-06-19', 'Bronze'),
(47, 'Aishwarya', 'Subramanian', 'aishwarya.subramanian47@mail.in', '+91-9741944441', 'Kolkata', 'West Bengal', '2025-05-23', 'Gold'),
(48, 'Harish', 'Reddy', 'harish.reddy48@mail.in', '+91-9738754377', 'Chennai', 'Tamil Nadu', '2025-10-04', 'Bronze'),
(49, 'Deepika', 'Menon', 'deepika.menon49@mail.in', '+91-9786644106', 'Bengaluru', 'Karnataka', '2025-10-23', 'Silver'),
(50, 'Surya', 'Joshi', 'surya.joshi50@mail.in', '+91-9773481353', 'Mumbai', 'Maharashtra', '2025-07-28', 'Bronze');

INSERT INTO Product (product_id, product_name, category_id, seller_id, unit_price, cost_price, created_at) VALUES
(1, 'Wireless Noise-Canceling Headphones', 1, 1, 4175.00, 2858.51, '2025-11-13'),
(2, 'Mechanical Gaming Keyboard', 1, 2, 2985.00, 1961.91, '2025-07-06'),
(3, 'USB-C Fast Charger 65W', 1, 3, 7011.00, 3926.98, '2025-10-17'),
(4, 'Smart Fitness Watch', 1, 4, 4055.00, 2962.13, '2025-07-13'),
(5, 'Bluetooth Portable Speaker', 1, 5, 1069.00, 621.05, '2025-08-15'),
(6, '27-inch IPS Monitor', 1, 6, 2915.00, 1943.83, '2025-10-07'),
(7, 'Laptop Cooling Pad', 1, 7, 6157.00, 4217.81, '2025-07-31'),
(8, 'True Wireless Earbuds', 1, 8, 4927.00, 3630.91, '2025-07-23'),
(9, '1080p Webcam Pro', 1, 9, 11294.00, 8310.17, '2025-06-19'),
(10, 'Power Bank 20000mAh', 1, 10, 16016.00, 9233.08, '2025-08-29'),
(11, 'Wireless Ergonomic Mouse', 1, 11, 9003.00, 6154.20, '2025-10-20'),
(12, 'NVMe SSD 1TB', 1, 12, 4393.00, 2663.70, '2025-07-24'),
(13, 'Smart LED Desk Lamp', 1, 13, 12234.00, 8943.88, '2025-06-14'),
(14, 'Cotton Linen Casual Shirt', 2, 14, 1632.00, 950.34, '2025-09-22'),
(15, 'Running Sneakers Pro', 2, 15, 2796.00, 2004.51, '2025-10-28'),
(16, 'Denim Slim Fit Jeans', 2, 16, 2259.00, 1337.36, '2025-08-03'),
(17, 'Silk Blend Kurta Set', 2, 17, 1947.00, 1450.98, '2025-07-16'),
(18, 'Classic Leather Belt', 2, 18, 1233.00, 872.32, '2025-06-28'),
(19, 'Waterproof Windbreaker', 2, 19, 2426.00, 1442.46, '2025-11-16'),
(20, 'Polo T-Shirt Pack', 2, 20, 1843.00, 1264.12, '2025-10-16'),
(21, 'Canvas Tote Bag', 2, 1, 971.00, 601.18, '2025-08-20'),
(22, 'Sports Track Pants', 2, 2, 972.00, 534.93, '2025-10-16'),
(23, 'Formal Oxford Shoes', 2, 3, 1990.00, 1296.33, '2025-11-18'),
(24, 'Ethnic Dupatta', 2, 4, 2147.00, 1471.69, '2025-07-15'),
(25, 'Woolen Winter Cardigan', 2, 5, 2162.00, 1528.86, '2025-11-03'),
(26, 'UV Polarized Sunglasses', 2, 6, 2403.00, 1638.29, '2025-08-12'),
(27, 'Non-Stick Induction Cookware Set', 3, 7, 6752.00, 3746.58, '2025-08-02'),
(28, 'Stainless Steel Electric Kettle', 3, 8, 3994.00, 2391.59, '2025-11-15'),
(29, 'Air Fryer 4.5L Digital', 3, 9, 6975.00, 3906.30, '2025-08-03'),
(30, 'Ceramic Coffee Mug Set', 3, 10, 4405.00, 3154.48, '2025-10-19'),
(31, 'Memory Foam Pillow', 3, 11, 4285.00, 2893.87, '2025-08-10'),
(32, 'Microfiber Bedsheet Queen', 3, 12, 2939.00, 1697.79, '2025-07-30'),
(33, 'Vacuum Insulated Flask', 3, 13, 2351.00, 1488.55, '2025-07-23'),
(34, 'Spice Rack Organizer', 3, 14, 6296.00, 3838.81, '2025-09-08'),
(35, 'LED Strip Ambient Light', 3, 15, 5540.00, 3585.09, '2025-09-08'),
(36, 'Automatic Coffee Maker', 3, 16, 1951.00, 1304.01, '2025-11-17'),
(37, 'Glass Food Storage Containers', 3, 17, 4110.00, 2572.12, '2025-07-25'),
(38, 'Cotton Bath Towel Set', 3, 18, 6834.00, 4401.52, '2025-10-17'),
(39, 'Python Data Science Handbook', 4, 19, 339.00, 243.35, '2025-11-07'),
(40, 'SQL & Database Systems Guide', 4, 20, 433.00, 252.68, '2025-11-03'),
(41, 'Hardcover Dotted Journal', 4, 1, 420.00, 264.32, '2025-07-21'),
(42, 'Fountain Pen Gift Set', 4, 2, 816.00, 556.76, '2025-06-18'),
(43, 'Algorithms & Data Structures', 4, 3, 1202.00, 831.14, '2025-09-20'),
(44, 'Desk Organizer Mesh', 4, 4, 1460.00, 897.11, '2025-08-02'),
(45, 'Sticky Notes Mega Pack', 4, 5, 1150.00, 828.22, '2025-07-17'),
(46, 'Scientific Calculator Pro', 4, 6, 896.00, 585.38, '2025-07-19'),
(47, 'Acrylic Paint Marker Set', 4, 7, 1199.00, 766.92, '2025-06-05'),
(48, 'Canvas Art Sketchbook', 4, 8, 697.00, 442.67, '2025-10-19'),
(49, 'Wireless Presentation Clicker', 4, 9, 753.00, 522.78, '2025-08-20'),
(50, 'Ergonomic Book Stand', 4, 10, 591.00, 440.95, '2025-07-20'),
(51, 'Vitamin C Brightening Serum', 5, 11, 277.00, 154.87, '2025-06-14'),
(52, 'Matte Finish Sunscreen SPF 50', 5, 12, 459.00, 295.54, '2025-09-21'),
(53, 'Blueberry Hydrating Face Wash', 5, 13, 482.00, 272.24, '2025-11-09'),
(54, 'Herbal Hair Strengthening Oil', 5, 14, 871.00, 576.27, '2025-09-15'),
(55, 'Aloe Vera Soothing Gel', 5, 15, 1155.00, 705.79, '2025-11-06'),
(56, 'Charcoal Peel-Off Mask', 5, 16, 790.00, 461.96, '2025-06-20'),
(57, 'Keratin Repair Shampoo', 5, 17, 1211.00, 735.83, '2025-08-12'),
(58, 'Shea Butter Body Lotion', 5, 18, 790.00, 520.54, '2025-11-13'),
(59, 'Beard Grooming Kit', 5, 19, 588.00, 375.04, '2025-09-28'),
(60, 'Rose Water Facial Toner', 5, 20, 1273.00, 720.63, '2025-06-11'),
(61, 'Lip Balm SPF 30', 5, 1, 436.00, 326.96, '2025-11-20'),
(62, 'Micellar Cleansing Water', 5, 2, 1154.00, 781.21, '2025-10-04'),
(63, 'TPE Anti-Slip Yoga Mat', 6, 3, 1255.00, 793.57, '2025-10-05'),
(64, 'Adjustable Dumbbell Set 20kg', 6, 4, 2975.00, 1705.22, '2025-09-12'),
(65, 'Resistance Bands 5-Pack', 6, 5, 843.00, 568.63, '2025-10-06'),
(66, 'Skipping Rope Speed Pro', 6, 6, 2758.00, 1583.88, '2025-11-09'),
(67, 'Foam Roller Muscle Recovery', 6, 7, 4923.00, 2928.89, '2025-06-30'),
(68, 'Gym Duffel Bag', 6, 8, 4567.00, 3274.29, '2025-09-29'),
(69, 'Badminton Carbon Racket', 6, 9, 4562.00, 2761.15, '2025-09-15'),
(70, 'Stainless Shaker Bottle', 6, 10, 4410.00, 2900.53, '2025-08-28'),
(71, 'Pull-Up Bar Doorway', 6, 11, 2355.00, 1405.26, '2025-09-14'),
(72, 'Wrist Support Wraps', 6, 12, 1645.00, 946.29, '2025-10-30'),
(73, 'Cycling Helmet Aero', 6, 13, 524.00, 379.47, '2025-07-10'),
(74, 'Football Size 5 Match', 6, 14, 1056.00, 782.31, '2025-11-08'),
(75, 'Organic Cold-Pressed Coconut Oil', 7, 15, 1541.00, 1154.96, '2025-06-24'),
(76, 'Premium California Almonds 500g', 7, 16, 862.00, 482.03, '2025-06-15'),
(77, 'Assam Orthodox Loose Tea', 7, 17, 1092.00, 637.72, '2025-06-21'),
(78, 'Roasted Arabica Coffee Beans', 7, 18, 724.00, 490.57, '2025-09-26'),
(79, 'Raw Wildflower Honey 1kg', 7, 19, 1153.00, 861.90, '2025-08-16'),
(80, 'Quinoa Organic Grain 1kg', 7, 20, 1036.00, 591.90, '2025-09-06'),
(81, 'Dark Chocolate 70% Bar', 7, 1, 811.00, 537.84, '2025-11-23'),
(82, 'Mixed Dry Fruits Gift Box', 7, 2, 1492.00, 885.95, '2025-07-19'),
(83, 'Himalayan Pink Salt', 7, 3, 881.00, 490.43, '2025-09-02'),
(84, 'Green Tea Matcha Powder', 7, 4, 660.00, 466.82, '2025-09-02'),
(85, 'Chia Seeds Superfood 500g', 7, 5, 942.00, 606.33, '2025-06-20'),
(86, 'Peanut Butter Unsweetened', 7, 6, 1057.00, 637.26, '2025-07-02'),
(87, 'Strategy Board Game Classic', 8, 7, 2314.00, 1490.90, '2025-11-06'),
(88, 'Robotics STEM Building Kit', 8, 8, 3743.00, 2145.99, '2025-06-12'),
(89, 'RGB Gaming Mousepad XL', 8, 9, 3582.00, 2295.09, '2025-11-19'),
(90, '3D Wooden Puzzle Castle', 8, 10, 3742.00, 2760.89, '2025-08-11'),
(91, 'Wireless Game Controller', 8, 11, 3408.00, 2245.51, '2025-11-13'),
(92, 'Chess Tournament Set', 8, 12, 2136.00, 1448.94, '2025-10-31'),
(93, 'Card Game Party Edition', 8, 13, 2096.00, 1398.61, '2025-07-30'),
(94, 'Drone Mini Indoor', 8, 14, 2452.00, 1740.19, '2025-06-29'),
(95, 'VR Headset Starter', 8, 15, 1826.00, 1101.21, '2025-07-03'),
(96, 'Rubik Speed Cube 3x3', 8, 16, 1292.00, 827.40, '2025-07-27'),
(97, 'Gaming Headset Surround', 8, 17, 654.00, 367.66, '2025-10-01'),
(98, 'RC Off-Road Car', 8, 18, 3037.00, 2039.83, '2025-06-17'),
(99, 'Essential Home Item 99', 3, 19, 1525.00, 991.25, '2025-10-01'),
(100, 'Essential Books Item 100', 4, 20, 2992.00, 1944.80, '2025-10-01');

INSERT INTO Inventory (inventory_id, product_id, stock_quantity, reorder_level, warehouse_location, last_updated) VALUES
(1, 1, 37, 15, 'WH-BEN', '2026-11-15'),
(2, 2, 79, 15, 'WH-MUM', '2026-11-15'),
(3, 3, 26, 15, 'WH-HYD', '2026-11-15'),
(4, 4, 73, 15, 'WH-PUN', '2026-11-15'),
(5, 5, 52, 15, 'WH-DEL', '2026-11-15'),
(6, 6, 92, 15, 'WH-COI', '2026-11-15'),
(7, 7, 76, 15, 'WH-KOC', '2026-11-15'),
(8, 8, 110, 15, 'WH-AHM', '2026-11-15'),
(9, 9, 161, 15, 'WH-KOL', '2026-11-15'),
(10, 10, 33, 15, 'WH-CHE', '2026-11-15'),
(11, 11, 6, 15, 'WH-BEN', '2026-11-15'),
(12, 12, 116, 15, 'WH-MUM', '2026-11-15'),
(13, 13, 36, 15, 'WH-HYD', '2026-11-15'),
(14, 14, 95, 15, 'WH-PUN', '2026-11-15'),
(15, 15, 95, 15, 'WH-DEL', '2026-11-15'),
(16, 16, 110, 15, 'WH-COI', '2026-11-15'),
(17, 17, 77, 15, 'WH-KOC', '2026-11-15'),
(18, 18, 208, 15, 'WH-AHM', '2026-11-15'),
(19, 19, 49, 15, 'WH-KOL', '2026-11-15'),
(20, 20, 67, 15, 'WH-CHE', '2026-11-15'),
(21, 21, 80, 15, 'WH-BEN', '2026-11-15'),
(22, 22, 12, 15, 'WH-MUM', '2026-11-15'),
(23, 23, 77, 15, 'WH-HYD', '2026-11-15'),
(24, 24, 103, 15, 'WH-PUN', '2026-11-15'),
(25, 25, 108, 15, 'WH-DEL', '2026-11-15'),
(26, 26, 90, 15, 'WH-COI', '2026-11-15'),
(27, 27, 220, 15, 'WH-KOC', '2026-11-15'),
(28, 28, 113, 15, 'WH-AHM', '2026-11-15'),
(29, 29, 40, 15, 'WH-KOL', '2026-11-15'),
(30, 30, 82, 15, 'WH-CHE', '2026-11-15'),
(31, 31, 81, 15, 'WH-BEN', '2026-11-15'),
(32, 32, 74, 15, 'WH-MUM', '2026-11-15'),
(33, 33, 8, 15, 'WH-HYD', '2026-11-15'),
(34, 34, 78, 15, 'WH-PUN', '2026-11-15'),
(35, 35, 68, 15, 'WH-DEL', '2026-11-15'),
(36, 36, 163, 15, 'WH-COI', '2026-11-15'),
(37, 37, 83, 15, 'WH-KOC', '2026-11-15'),
(38, 38, 31, 15, 'WH-AHM', '2026-11-15'),
(39, 39, 44, 15, 'WH-KOL', '2026-11-15'),
(40, 40, 120, 15, 'WH-CHE', '2026-11-15'),
(41, 41, 34, 15, 'WH-BEN', '2026-11-15'),
(42, 42, 89, 15, 'WH-MUM', '2026-11-15'),
(43, 43, 47, 15, 'WH-HYD', '2026-11-15'),
(44, 44, 3, 15, 'WH-PUN', '2026-11-15'),
(45, 45, 222, 15, 'WH-DEL', '2026-11-15'),
(46, 46, 35, 15, 'WH-COI', '2026-11-15'),
(47, 47, 36, 15, 'WH-KOC', '2026-11-15'),
(48, 48, 67, 15, 'WH-AHM', '2026-11-15'),
(49, 49, 40, 15, 'WH-KOL', '2026-11-15'),
(50, 50, 62, 15, 'WH-CHE', '2026-11-15'),
(51, 51, 95, 15, 'WH-BEN', '2026-11-15'),
(52, 52, 68, 15, 'WH-MUM', '2026-11-15'),
(53, 53, 112, 15, 'WH-HYD', '2026-11-15'),
(54, 54, 237, 15, 'WH-PUN', '2026-11-15'),
(55, 55, 2, 15, 'WH-DEL', '2026-11-15'),
(56, 56, 45, 15, 'WH-COI', '2026-11-15'),
(57, 57, 114, 15, 'WH-KOC', '2026-11-15'),
(58, 58, 44, 15, 'WH-AHM', '2026-11-15'),
(59, 59, 113, 15, 'WH-KOL', '2026-11-15'),
(60, 60, 80, 15, 'WH-CHE', '2026-11-15'),
(61, 61, 59, 15, 'WH-BEN', '2026-11-15'),
(62, 62, 36, 15, 'WH-MUM', '2026-11-15'),
(63, 63, 196, 15, 'WH-HYD', '2026-11-15'),
(64, 64, 90, 15, 'WH-PUN', '2026-11-15'),
(65, 65, 105, 15, 'WH-DEL', '2026-11-15'),
(66, 66, 11, 15, 'WH-COI', '2026-11-15'),
(67, 67, 84, 15, 'WH-KOC', '2026-11-15'),
(68, 68, 56, 15, 'WH-AHM', '2026-11-15'),
(69, 69, 68, 15, 'WH-KOL', '2026-11-15'),
(70, 70, 67, 15, 'WH-CHE', '2026-11-15'),
(71, 71, 30, 15, 'WH-BEN', '2026-11-15'),
(72, 72, 202, 15, 'WH-MUM', '2026-11-15'),
(73, 73, 34, 15, 'WH-HYD', '2026-11-15'),
(74, 74, 116, 15, 'WH-PUN', '2026-11-15'),
(75, 75, 80, 15, 'WH-DEL', '2026-11-15'),
(76, 76, 62, 15, 'WH-COI', '2026-11-15'),
(77, 77, 11, 15, 'WH-KOC', '2026-11-15'),
(78, 78, 57, 15, 'WH-AHM', '2026-11-15'),
(79, 79, 106, 15, 'WH-KOL', '2026-11-15'),
(80, 80, 98, 15, 'WH-CHE', '2026-11-15'),
(81, 81, 259, 15, 'WH-BEN', '2026-11-15'),
(82, 82, 104, 15, 'WH-MUM', '2026-11-15'),
(83, 83, 118, 15, 'WH-HYD', '2026-11-15'),
(84, 84, 92, 15, 'WH-PUN', '2026-11-15'),
(85, 85, 43, 15, 'WH-DEL', '2026-11-15'),
(86, 86, 83, 15, 'WH-COI', '2026-11-15'),
(87, 87, 96, 15, 'WH-KOC', '2026-11-15'),
(88, 88, 2, 15, 'WH-AHM', '2026-11-15'),
(89, 89, 120, 15, 'WH-KOL', '2026-11-15'),
(90, 90, 164, 15, 'WH-CHE', '2026-11-15'),
(91, 91, 70, 15, 'WH-BEN', '2026-11-15'),
(92, 92, 27, 15, 'WH-MUM', '2026-11-15'),
(93, 93, 67, 15, 'WH-HYD', '2026-11-15'),
(94, 94, 109, 15, 'WH-PUN', '2026-11-15'),
(95, 95, 119, 15, 'WH-DEL', '2026-11-15'),
(96, 96, 103, 15, 'WH-COI', '2026-11-15'),
(97, 97, 76, 15, 'WH-KOC', '2026-11-15'),
(98, 98, 41, 15, 'WH-AHM', '2026-11-15'),
(99, 99, 99, 15, 'WH-CHE', '2026-11-15'),
(100, 100, 94, 15, 'WH-CHE', '2026-11-15');

INSERT INTO Orders (order_id, customer_id, order_date, order_status, total_amount, shipping_city) VALUES
(1, 25, '2026-01-11', 'Delivered', 22266.00, 'Kochi'),
(2, 37, '2026-02-04', 'Processing', 6930.00, 'Kolkata'),
(3, 43, '2026-03-14', 'Delivered', 5775.00, 'Delhi'),
(4, 30, '2026-04-12', 'Cancelled', 11730.00, 'Mumbai'),
(5, 34, '2026-05-12', 'Shipped', 5876.00, 'Coimbatore'),
(6, 20, '2026-06-28', 'Delivered', 26822.00, 'Mumbai'),
(7, 22, '2026-07-05', 'Delivered', 3264.00, 'Pune'),
(8, 18, '2026-08-25', 'Delivered', 3465.00, 'Chennai'),
(9, 38, '2026-09-20', 'Delivered', 4056.00, 'Chennai'),
(10, 13, '2026-10-25', 'Delivered', 10616.00, 'Delhi'),
(11, 3, '2026-11-24', 'Delivered', 3876.00, 'Delhi'),
(12, 20, '2026-01-11', 'Delivered', 11424.00, 'Mumbai'),
(13, 3, '2026-02-06', 'Shipped', 18006.00, 'Delhi'),
(14, 20, '2026-03-20', 'Delivered', 1962.00, 'Mumbai'),
(15, 20, '2026-04-10', 'Delivered', 10191.00, 'Mumbai'),
(16, 49, '2026-05-02', 'Delivered', 7044.00, 'Bengaluru'),
(17, 7, '2026-06-16', 'Shipped', 2259.00, 'Kolkata'),
(18, 22, '2026-07-27', 'Delivered', 3929.00, 'Pune'),
(19, 46, '2026-08-28', 'Delivered', 8193.00, 'Ahmedabad'),
(20, 19, '2026-09-11', 'Delivered', 8951.00, 'Bengaluru'),
(21, 26, '2026-10-17', 'Delivered', 11019.00, 'Ahmedabad'),
(22, 6, '2026-11-17', 'Delivered', 4483.00, 'Ahmedabad'),
(23, 10, '2026-01-20', 'Delivered', 55078.00, 'Mumbai'),
(24, 34, '2026-02-15', 'Delivered', 8310.00, 'Coimbatore'),
(25, 3, '2026-03-15', 'Delivered', 9305.00, 'Delhi'),
(26, 2, '2026-04-12', 'Shipped', 13179.00, 'Pune'),
(27, 19, '2026-05-19', 'Delivered', 11647.00, 'Bengaluru'),
(28, 22, '2026-06-02', 'Delivered', 19791.00, 'Pune'),
(29, 33, '2026-07-15', 'Delivered', 3792.00, 'Delhi'),
(30, 16, '2026-08-20', 'Delivered', 13698.00, 'Ahmedabad'),
(31, 19, '2026-09-09', 'Shipped', 3291.00, 'Bengaluru'),
(32, 8, '2026-10-12', 'Delivered', 1773.00, 'Chennai'),
(33, 4, '2026-11-18', 'Delivered', 20238.00, 'Coimbatore'),
(34, 30, '2026-01-17', 'Delivered', 12282.00, 'Mumbai'),
(35, 50, '2026-02-05', 'Delivered', 43806.00, 'Mumbai'),
(36, 16, '2026-03-25', 'Delivered', 4756.00, 'Ahmedabad'),
(37, 38, '2026-04-06', 'Shipped', 3597.00, 'Chennai'),
(38, 48, '2026-05-20', 'Delivered', 6775.00, 'Chennai'),
(39, 38, '2026-06-16', 'Processing', 6942.00, 'Chennai'),
(40, 21, '2026-07-10', 'Shipped', 3784.00, 'Hyderabad'),
(41, 12, '2026-08-21', 'Delivered', 7032.00, 'Pune'),
(42, 34, '2026-09-09', 'Delivered', 9576.00, 'Coimbatore'),
(43, 47, '2026-10-14', 'Delivered', 5467.00, 'Kolkata'),
(44, 16, '2026-11-04', 'Shipped', 4892.00, 'Ahmedabad'),
(45, 21, '2026-01-27', 'Delivered', 1943.00, 'Hyderabad'),
(46, 11, '2026-02-05', 'Delivered', 6877.00, 'Hyderabad'),
(47, 7, '2026-03-08', 'Delivered', 43446.00, 'Kolkata'),
(48, 23, '2026-04-08', 'Shipped', 12525.00, 'Delhi'),
(49, 26, '2026-05-06', 'Delivered', 1199.00, 'Ahmedabad'),
(50, 25, '2026-06-26', 'Cancelled', 1899.00, 'Kochi'),
(51, 12, '2026-07-01', 'Delivered', 12855.00, 'Pune'),
(52, 5, '2026-08-19', 'Shipped', 10537.00, 'Kochi'),
(53, 10, '2026-09-25', 'Delivered', 8406.00, 'Mumbai'),
(54, 21, '2026-10-10', 'Delivered', 10884.00, 'Hyderabad'),
(55, 2, '2026-11-21', 'Delivered', 21290.00, 'Pune'),
(56, 37, '2026-01-14', 'Processing', 3511.00, 'Kolkata'),
(57, 18, '2026-02-26', 'Delivered', 17372.00, 'Chennai'),
(58, 16, '2026-03-03', 'Delivered', 2370.00, 'Ahmedabad'),
(59, 9, '2026-04-15', 'Delivered', 2688.00, 'Bengaluru'),
(60, 13, '2026-05-26', 'Cancelled', 2984.00, 'Delhi'),
(61, 47, '2026-06-05', 'Processing', 2280.00, 'Kolkata'),
(62, 29, '2026-07-12', 'Delivered', 5858.00, 'Bengaluru'),
(63, 18, '2026-08-25', 'Delivered', 2398.00, 'Chennai'),
(64, 13, '2026-09-04', 'Delivered', 9846.00, 'Delhi'),
(65, 7, '2026-10-25', 'Delivered', 11679.00, 'Kolkata'),
(66, 8, '2026-11-03', 'Delivered', 23087.00, 'Chennai'),
(67, 25, '2026-01-10', 'Processing', 17300.00, 'Kochi'),
(68, 7, '2026-02-07', 'Shipped', 2975.00, 'Kolkata'),
(69, 26, '2026-03-15', 'Shipped', 9939.00, 'Ahmedabad'),
(70, 33, '2026-04-16', 'Delivered', 52107.00, 'Delhi'),
(71, 31, '2026-05-12', 'Delivered', 5571.00, 'Hyderabad'),
(72, 41, '2026-06-27', 'Delivered', 972.00, 'Hyderabad'),
(73, 33, '2026-07-12', 'Cancelled', 17223.00, 'Delhi'),
(74, 7, '2026-08-10', 'Delivered', 881.00, 'Kolkata'),
(75, 26, '2026-09-06', 'Delivered', 3632.00, 'Ahmedabad'),
(76, 1, '2026-10-02', 'Cancelled', 40464.00, 'Hyderabad'),
(77, 43, '2026-11-18', 'Delivered', 15672.00, 'Delhi'),
(78, 3, '2026-01-15', 'Delivered', 2908.00, 'Delhi'),
(79, 16, '2026-02-28', 'Delivered', 11202.00, 'Ahmedabad'),
(80, 12, '2026-03-04', 'Delivered', 12234.00, 'Pune'),
(81, 19, '2026-04-20', 'Delivered', 5601.00, 'Bengaluru'),
(82, 22, '2026-05-17', 'Delivered', 35769.00, 'Pune'),
(83, 11, '2026-06-12', 'Delivered', 3276.00, 'Hyderabad'),
(84, 13, '2026-07-01', 'Processing', 17496.00, 'Delhi'),
(85, 19, '2026-08-19', 'Delivered', 56268.00, 'Bengaluru'),
(86, 25, '2026-09-27', 'Cancelled', 6153.00, 'Kochi'),
(87, 25, '2026-10-12', 'Shipped', 5516.00, 'Kochi'),
(88, 2, '2026-11-05', 'Shipped', 18376.00, 'Pune'),
(89, 27, '2026-01-06', 'Delivered', 3264.00, 'Kolkata'),
(90, 24, '2026-02-23', 'Delivered', 16113.00, 'Coimbatore'),
(91, 20, '2026-03-10', 'Shipped', 6015.00, 'Mumbai'),
(92, 48, '2026-04-26', 'Cancelled', 10693.00, 'Chennai'),
(93, 8, '2026-05-22', 'Delivered', 6538.00, 'Chennai'),
(94, 20, '2026-06-14', 'Delivered', 9443.00, 'Mumbai'),
(95, 33, '2026-07-17', 'Delivered', 5134.00, 'Delhi'),
(96, 9, '2026-08-18', 'Delivered', 10863.00, 'Bengaluru'),
(97, 13, '2026-09-16', 'Delivered', 3290.00, 'Delhi'),
(98, 48, '2026-10-10', 'Shipped', 13980.00, 'Chennai'),
(99, 25, '2026-11-26', 'Shipped', 3168.00, 'Kochi'),
(100, 44, '2026-01-13', 'Shipped', 28269.00, 'Coimbatore');

INSERT INTO Order_Details (order_detail_id, order_id, product_id, quantity, unit_price, line_total) VALUES
(1, 1, 38, 3, 6834.00, 20502.00),
(2, 1, 59, 3, 588.00, 1764.00),
(3, 2, 99, 3, 1525.00, 4575.00),
(4, 2, 71, 1, 2355.00, 2355.00),
(5, 3, 54, 1, 871.00, 871.00),
(6, 3, 94, 2, 2452.00, 4904.00),
(7, 4, 61, 1, 436.00, 436.00),
(8, 4, 9, 1, 11294.00, 11294.00),
(9, 5, 76, 3, 862.00, 2586.00),
(10, 5, 72, 2, 1645.00, 3290.00),
(11, 6, 93, 3, 2096.00, 6288.00),
(12, 6, 7, 2, 6157.00, 12314.00),
(13, 6, 37, 2, 4110.00, 8220.00),
(14, 7, 14, 2, 1632.00, 3264.00),
(15, 8, 55, 3, 1155.00, 3465.00),
(16, 9, 78, 3, 724.00, 2172.00),
(17, 9, 85, 2, 942.00, 1884.00),
(18, 10, 1, 1, 4175.00, 4175.00),
(19, 10, 24, 3, 2147.00, 6441.00),
(20, 11, 96, 3, 1292.00, 3876.00),
(21, 12, 42, 3, 816.00, 2448.00),
(22, 12, 100, 3, 2992.00, 8976.00),
(23, 13, 11, 2, 9003.00, 18006.00),
(24, 14, 97, 3, 654.00, 1962.00),
(25, 15, 68, 2, 4567.00, 9134.00),
(26, 15, 86, 1, 1057.00, 1057.00),
(27, 16, 28, 1, 3994.00, 3994.00),
(28, 16, 99, 2, 1525.00, 3050.00),
(29, 17, 49, 3, 753.00, 2259.00),
(30, 18, 51, 1, 277.00, 277.00),
(31, 18, 95, 2, 1826.00, 3652.00),
(32, 19, 52, 3, 459.00, 1377.00),
(33, 19, 91, 2, 3408.00, 6816.00),
(34, 20, 59, 1, 588.00, 588.00),
(35, 20, 89, 2, 3582.00, 7164.00),
(36, 20, 47, 1, 1199.00, 1199.00),
(37, 21, 96, 2, 1292.00, 2584.00),
(38, 21, 44, 1, 1460.00, 1460.00),
(39, 21, 29, 1, 6975.00, 6975.00),
(40, 22, 45, 1, 1150.00, 1150.00),
(41, 22, 94, 1, 2452.00, 2452.00),
(42, 22, 83, 1, 881.00, 881.00),
(43, 23, 10, 3, 16016.00, 48048.00),
(44, 23, 23, 2, 1990.00, 3980.00),
(45, 23, 99, 2, 1525.00, 3050.00),
(46, 24, 83, 2, 881.00, 1762.00),
(47, 24, 82, 3, 1492.00, 4476.00),
(48, 24, 80, 2, 1036.00, 2072.00),
(49, 25, 76, 3, 862.00, 2586.00),
(50, 25, 8, 1, 4927.00, 4927.00),
(51, 25, 46, 2, 896.00, 1792.00),
(52, 26, 12, 3, 4393.00, 13179.00),
(53, 27, 6, 3, 2915.00, 8745.00),
(54, 27, 58, 1, 790.00, 790.00),
(55, 27, 74, 2, 1056.00, 2112.00),
(56, 28, 44, 3, 1460.00, 4380.00),
(57, 28, 92, 3, 2136.00, 6408.00),
(58, 28, 11, 1, 9003.00, 9003.00),
(59, 29, 47, 2, 1199.00, 2398.00),
(60, 29, 48, 2, 697.00, 1394.00),
(61, 30, 43, 2, 1202.00, 2404.00),
(62, 30, 9, 1, 11294.00, 11294.00),
(63, 31, 78, 2, 724.00, 1448.00),
(64, 31, 20, 1, 1843.00, 1843.00),
(65, 32, 85, 1, 942.00, 942.00),
(66, 32, 51, 3, 277.00, 831.00),
(67, 33, 17, 3, 1947.00, 5841.00),
(68, 33, 86, 3, 1057.00, 3171.00),
(69, 33, 90, 3, 3742.00, 11226.00),
(70, 34, 24, 2, 2147.00, 4294.00),
(71, 34, 28, 2, 3994.00, 7988.00),
(72, 35, 13, 3, 12234.00, 36702.00),
(73, 35, 65, 3, 843.00, 2529.00),
(74, 35, 99, 3, 1525.00, 4575.00),
(75, 36, 20, 1, 1843.00, 1843.00),
(76, 36, 21, 3, 971.00, 2913.00),
(77, 37, 47, 3, 1199.00, 3597.00),
(78, 38, 58, 3, 790.00, 2370.00),
(79, 38, 30, 1, 4405.00, 4405.00),
(80, 39, 87, 3, 2314.00, 6942.00),
(81, 40, 54, 1, 871.00, 871.00),
(82, 40, 21, 3, 971.00, 2913.00),
(83, 41, 14, 3, 1632.00, 4896.00),
(84, 41, 92, 1, 2136.00, 2136.00),
(85, 42, 56, 1, 790.00, 790.00),
(86, 42, 12, 2, 4393.00, 8786.00),
(87, 43, 31, 1, 4285.00, 4285.00),
(88, 43, 50, 2, 591.00, 1182.00),
(89, 44, 19, 1, 2426.00, 2426.00),
(90, 44, 18, 2, 1233.00, 2466.00),
(91, 45, 58, 1, 790.00, 790.00),
(92, 45, 79, 1, 1153.00, 1153.00),
(93, 46, 68, 1, 4567.00, 4567.00),
(94, 46, 55, 2, 1155.00, 2310.00),
(95, 47, 59, 2, 588.00, 1176.00),
(96, 47, 9, 3, 11294.00, 33882.00),
(97, 47, 15, 3, 2796.00, 8388.00),
(98, 48, 1, 3, 4175.00, 12525.00),
(99, 49, 47, 1, 1199.00, 1199.00),
(100, 50, 50, 1, 591.00, 591.00),
(101, 50, 61, 3, 436.00, 1308.00),
(102, 51, 31, 3, 4285.00, 12855.00),
(103, 52, 6, 3, 2915.00, 8745.00),
(104, 52, 46, 2, 896.00, 1792.00),
(105, 53, 62, 1, 1154.00, 1154.00),
(106, 53, 81, 1, 811.00, 811.00),
(107, 53, 24, 3, 2147.00, 6441.00),
(108, 54, 6, 3, 2915.00, 8745.00),
(109, 54, 41, 2, 420.00, 840.00),
(110, 54, 40, 3, 433.00, 1299.00),
(111, 55, 100, 3, 2992.00, 8976.00),
(112, 55, 7, 2, 6157.00, 12314.00),
(113, 56, 50, 1, 591.00, 591.00),
(114, 56, 44, 2, 1460.00, 2920.00),
(115, 57, 94, 2, 2452.00, 4904.00),
(116, 57, 55, 3, 1155.00, 3465.00),
(117, 57, 11, 1, 9003.00, 9003.00),
(118, 58, 58, 3, 790.00, 2370.00),
(119, 59, 46, 3, 896.00, 2688.00),
(120, 60, 82, 2, 1492.00, 2984.00),
(121, 61, 57, 1, 1211.00, 1211.00),
(122, 61, 5, 1, 1069.00, 1069.00),
(123, 62, 78, 3, 724.00, 2172.00),
(124, 62, 20, 2, 1843.00, 3686.00),
(125, 63, 47, 2, 1199.00, 2398.00),
(126, 64, 67, 2, 4923.00, 9846.00),
(127, 65, 79, 3, 1153.00, 3459.00),
(128, 65, 37, 2, 4110.00, 8220.00),
(129, 66, 57, 2, 1211.00, 2422.00),
(130, 66, 12, 3, 4393.00, 13179.00),
(131, 66, 88, 2, 3743.00, 7486.00),
(132, 67, 92, 3, 2136.00, 6408.00),
(133, 67, 91, 1, 3408.00, 3408.00),
(134, 67, 90, 2, 3742.00, 7484.00),
(135, 68, 64, 1, 2975.00, 2975.00),
(136, 69, 79, 1, 1153.00, 1153.00),
(137, 69, 12, 2, 4393.00, 8786.00),
(138, 70, 74, 2, 1056.00, 2112.00),
(139, 70, 10, 3, 16016.00, 48048.00),
(140, 70, 17, 1, 1947.00, 1947.00),
(141, 71, 71, 1, 2355.00, 2355.00),
(142, 71, 82, 1, 1492.00, 1492.00),
(143, 71, 76, 2, 862.00, 1724.00),
(144, 72, 22, 1, 972.00, 972.00),
(145, 73, 37, 2, 4110.00, 8220.00),
(146, 73, 11, 1, 9003.00, 9003.00),
(147, 74, 83, 1, 881.00, 881.00),
(148, 75, 78, 3, 724.00, 2172.00),
(149, 75, 44, 1, 1460.00, 1460.00),
(150, 76, 34, 3, 6296.00, 18888.00),
(151, 76, 84, 2, 660.00, 1320.00),
(152, 76, 27, 3, 6752.00, 20256.00),
(153, 77, 62, 2, 1154.00, 2308.00),
(154, 77, 32, 2, 2939.00, 5878.00),
(155, 77, 88, 2, 3743.00, 7486.00),
(156, 78, 44, 1, 1460.00, 1460.00),
(157, 78, 78, 2, 724.00, 1448.00),
(158, 79, 98, 3, 3037.00, 9111.00),
(159, 79, 48, 3, 697.00, 2091.00),
(160, 80, 13, 1, 12234.00, 12234.00),
(161, 81, 21, 3, 971.00, 2913.00),
(162, 81, 42, 2, 816.00, 1632.00),
(163, 81, 74, 1, 1056.00, 1056.00),
(164, 82, 64, 2, 2975.00, 5950.00),
(165, 82, 3, 3, 7011.00, 21033.00),
(166, 82, 12, 2, 4393.00, 8786.00),
(167, 83, 77, 3, 1092.00, 3276.00),
(168, 84, 34, 2, 6296.00, 12592.00),
(169, 84, 94, 2, 2452.00, 4904.00),
(170, 85, 37, 2, 4110.00, 8220.00),
(171, 85, 10, 3, 16016.00, 48048.00),
(172, 86, 16, 1, 2259.00, 2259.00),
(173, 86, 17, 2, 1947.00, 3894.00),
(174, 87, 66, 2, 2758.00, 5516.00),
(175, 88, 67, 3, 4923.00, 14769.00),
(176, 88, 59, 3, 588.00, 1764.00),
(177, 88, 20, 1, 1843.00, 1843.00),
(178, 89, 39, 2, 339.00, 678.00),
(179, 89, 76, 3, 862.00, 2586.00),
(180, 90, 3, 2, 7011.00, 14022.00),
(181, 90, 48, 3, 697.00, 2091.00),
(182, 91, 89, 1, 3582.00, 3582.00),
(183, 91, 81, 3, 811.00, 2433.00),
(184, 92, 30, 1, 4405.00, 4405.00),
(185, 92, 93, 3, 2096.00, 6288.00),
(186, 93, 90, 1, 3742.00, 3742.00),
(187, 93, 15, 1, 2796.00, 2796.00),
(188, 94, 100, 2, 2992.00, 5984.00),
(189, 94, 79, 3, 1153.00, 3459.00),
(190, 95, 85, 3, 942.00, 2826.00),
(191, 95, 62, 2, 1154.00, 2308.00),
(192, 96, 99, 3, 1525.00, 4575.00),
(193, 96, 93, 3, 2096.00, 6288.00),
(194, 97, 72, 2, 1645.00, 3290.00),
(195, 98, 89, 2, 3582.00, 7164.00),
(196, 98, 91, 2, 3408.00, 6816.00),
(197, 99, 74, 3, 1056.00, 3168.00),
(198, 100, 19, 2, 2426.00, 4852.00),
(199, 100, 38, 3, 6834.00, 20502.00),
(200, 100, 6, 1, 2915.00, 2915.00);

INSERT INTO Payment (payment_id, order_id, payment_date, payment_method, payment_status, amount_paid) VALUES
(1, 1, '2026-01-11', 'Credit Card', 'Completed', 22266.00),
(2, 2, '2026-02-04', 'Credit Card', 'Completed', 6930.00),
(3, 3, '2026-03-14', 'Credit Card', 'Completed', 5775.00),
(4, 4, '2026-04-12', 'UPI', 'Refunded', 11730.00),
(5, 5, '2026-05-12', 'Debit Card', 'Completed', 5876.00),
(6, 6, '2026-06-28', 'UPI', 'Completed', 26822.00),
(7, 7, '2026-07-05', 'Net Banking', 'Completed', 3264.00),
(8, 8, '2026-08-25', 'Wallet', 'Completed', 3465.00),
(9, 9, '2026-09-20', 'UPI', 'Completed', 4056.00),
(10, 10, '2026-10-25', 'Credit Card', 'Completed', 10616.00),
(11, 11, '2026-11-24', 'UPI', 'Completed', 3876.00),
(12, 12, '2026-01-11', 'UPI', 'Completed', 11424.00),
(13, 13, '2026-02-06', 'Credit Card', 'Completed', 18006.00),
(14, 14, '2026-03-20', 'UPI', 'Completed', 1962.00),
(15, 15, '2026-04-10', 'UPI', 'Completed', 10191.00),
(16, 16, '2026-05-02', 'UPI', 'Completed', 7044.00),
(17, 17, '2026-06-16', 'Debit Card', 'Completed', 2259.00),
(18, 18, '2026-07-27', 'UPI', 'Completed', 3929.00),
(19, 19, '2026-08-28', 'UPI', 'Completed', 8193.00),
(20, 20, '2026-09-11', 'UPI', 'Completed', 8951.00),
(21, 21, '2026-10-17', 'Credit Card', 'Completed', 11019.00),
(22, 22, '2026-11-17', 'UPI', 'Completed', 4483.00),
(23, 23, '2026-01-20', 'Debit Card', 'Completed', 55078.00),
(24, 24, '2026-02-15', 'UPI', 'Completed', 8310.00),
(25, 25, '2026-03-15', 'Credit Card', 'Completed', 9305.00),
(26, 26, '2026-04-12', 'Credit Card', 'Completed', 13179.00),
(27, 27, '2026-05-19', 'Credit Card', 'Completed', 11647.00),
(28, 28, '2026-06-02', 'UPI', 'Completed', 19791.00),
(29, 29, '2026-07-15', 'UPI', 'Completed', 3792.00),
(30, 30, '2026-08-20', 'Credit Card', 'Completed', 13698.00),
(31, 31, '2026-09-09', 'Credit Card', 'Completed', 3291.00),
(32, 32, '2026-10-12', 'Debit Card', 'Completed', 1773.00),
(33, 33, '2026-11-18', 'UPI', 'Completed', 20238.00),
(34, 34, '2026-01-17', 'UPI', 'Completed', 12282.00),
(35, 35, '2026-02-05', 'UPI', 'Completed', 43806.00),
(36, 36, '2026-03-25', 'Debit Card', 'Completed', 4756.00),
(37, 37, '2026-04-06', 'Debit Card', 'Completed', 3597.00),
(38, 38, '2026-05-20', 'UPI', 'Completed', 6775.00),
(39, 39, '2026-06-16', 'Wallet', 'Completed', 6942.00),
(40, 40, '2026-07-10', 'UPI', 'Completed', 3784.00),
(41, 41, '2026-08-21', 'UPI', 'Completed', 7032.00),
(42, 42, '2026-09-09', 'Net Banking', 'Completed', 9576.00),
(43, 43, '2026-10-14', 'UPI', 'Completed', 5467.00),
(44, 44, '2026-11-04', 'Net Banking', 'Completed', 4892.00),
(45, 45, '2026-01-27', 'UPI', 'Completed', 1943.00),
(46, 46, '2026-02-05', 'UPI', 'Completed', 6877.00),
(47, 47, '2026-03-08', 'UPI', 'Completed', 43446.00),
(48, 48, '2026-04-08', 'UPI', 'Completed', 12525.00),
(49, 49, '2026-05-06', 'Wallet', 'Completed', 1199.00),
(50, 50, '2026-06-26', 'UPI', 'Failed', 1899.00),
(51, 51, '2026-07-01', 'Credit Card', 'Completed', 12855.00),
(52, 52, '2026-08-19', 'Debit Card', 'Completed', 10537.00),
(53, 53, '2026-09-25', 'Debit Card', 'Completed', 8406.00),
(54, 54, '2026-10-10', 'Credit Card', 'Completed', 10884.00),
(55, 55, '2026-11-21', 'UPI', 'Completed', 21290.00),
(56, 56, '2026-01-14', 'Debit Card', 'Completed', 3511.00),
(57, 57, '2026-02-26', 'Credit Card', 'Completed', 17372.00),
(58, 58, '2026-03-03', 'Debit Card', 'Completed', 2370.00),
(59, 59, '2026-04-15', 'Wallet', 'Completed', 2688.00),
(60, 60, '2026-05-26', 'UPI', 'Refunded', 2984.00),
(61, 61, '2026-06-05', 'UPI', 'Completed', 2280.00),
(62, 62, '2026-07-12', 'Wallet', 'Completed', 5858.00),
(63, 63, '2026-08-25', 'UPI', 'Completed', 2398.00),
(64, 64, '2026-09-04', 'Net Banking', 'Completed', 9846.00),
(65, 65, '2026-10-25', 'UPI', 'Completed', 11679.00),
(66, 66, '2026-11-03', 'Debit Card', 'Completed', 23087.00),
(67, 67, '2026-01-10', 'Credit Card', 'Completed', 17300.00),
(68, 68, '2026-02-07', 'UPI', 'Completed', 2975.00),
(69, 69, '2026-03-15', 'UPI', 'Completed', 9939.00),
(70, 70, '2026-04-16', 'Credit Card', 'Completed', 52107.00),
(71, 71, '2026-05-12', 'Credit Card', 'Completed', 5571.00),
(72, 72, '2026-06-27', 'UPI', 'Completed', 972.00),
(73, 73, '2026-07-12', 'Credit Card', 'Failed', 17223.00),
(74, 74, '2026-08-10', 'Credit Card', 'Completed', 881.00),
(75, 75, '2026-09-06', 'Net Banking', 'Completed', 3632.00),
(76, 76, '2026-10-02', 'Credit Card', 'Failed', 40464.00),
(77, 77, '2026-11-18', 'UPI', 'Completed', 15672.00),
(78, 78, '2026-01-15', 'Net Banking', 'Completed', 2908.00),
(79, 79, '2026-02-28', 'UPI', 'Completed', 11202.00),
(80, 80, '2026-03-04', 'UPI', 'Completed', 12234.00),
(81, 81, '2026-04-20', 'Debit Card', 'Completed', 5601.00),
(82, 82, '2026-05-17', 'Wallet', 'Completed', 35769.00),
(83, 83, '2026-06-12', 'Debit Card', 'Completed', 3276.00),
(84, 84, '2026-07-01', 'UPI', 'Completed', 17496.00),
(85, 85, '2026-08-19', 'Credit Card', 'Completed', 56268.00),
(86, 86, '2026-09-27', 'UPI', 'Failed', 6153.00),
(87, 87, '2026-10-12', 'Credit Card', 'Completed', 5516.00),
(88, 88, '2026-11-05', 'UPI', 'Completed', 18376.00),
(89, 89, '2026-01-06', 'Net Banking', 'Completed', 3264.00),
(90, 90, '2026-02-23', 'UPI', 'Completed', 16113.00),
(91, 91, '2026-03-10', 'Credit Card', 'Completed', 6015.00),
(92, 92, '2026-04-26', 'Credit Card', 'Failed', 10693.00),
(93, 93, '2026-05-22', 'Credit Card', 'Completed', 6538.00),
(94, 94, '2026-06-14', 'Debit Card', 'Completed', 9443.00),
(95, 95, '2026-07-17', 'UPI', 'Completed', 5134.00),
(96, 96, '2026-08-18', 'Debit Card', 'Completed', 10863.00),
(97, 97, '2026-09-16', 'UPI', 'Completed', 3290.00),
(98, 98, '2026-10-10', 'Credit Card', 'Completed', 13980.00),
(99, 99, '2026-11-26', 'Credit Card', 'Completed', 3168.00),
(100, 100, '2026-01-13', 'UPI', 'Completed', 28269.00);

INSERT INTO Review (review_id, product_id, customer_id, rating, review_text, review_date) VALUES
(1, 57, 42, 5, 'Exceeded expectations, highly recommended.', '2026-05-21'),
(2, 26, 35, 5, 'Good value for money and reliable performance.', '2026-06-20'),
(3, 18, 7, 4, 'Good value for money and reliable performance.', '2026-06-03'),
(4, 32, 4, 4, 'Good value for money and reliable performance.', '2026-05-27'),
(5, 82, 15, 5, 'Exceeded expectations, highly recommended.', '2026-07-20'),
(6, 92, 31, 5, 'Worth every rupee, works seamlessly.', '2026-02-03'),
(7, 71, 11, 5, 'Exceeded expectations, highly recommended.', '2026-10-03'),
(8, 84, 13, 3, 'Works fine, though delivery took a bit longer.', '2026-07-15'),
(9, 37, 42, 5, 'Excellent build quality and fast delivery.', '2026-05-30'),
(10, 69, 48, 4, 'Excellent build quality and fast delivery.', '2026-05-01'),
(11, 54, 12, 2, 'Battery or material quality is below par.', '2026-08-23'),
(12, 64, 12, 2, 'Not satisfied with the finish, feels flimsy.', '2026-02-20'),
(13, 2, 20, 4, 'Excellent build quality and fast delivery.', '2026-07-22'),
(14, 37, 30, 1, 'Not satisfied with the finish, feels flimsy.', '2026-04-10'),
(15, 65, 30, 5, 'Excellent build quality and fast delivery.', '2026-07-20'),
(16, 21, 47, 4, 'Great packaging and genuine product.', '2026-05-07'),
(17, 2, 48, 5, 'Great packaging and genuine product.', '2026-05-10'),
(18, 23, 40, 3, 'Works fine, though delivery took a bit longer.', '2026-09-07'),
(19, 66, 21, 5, 'Excellent build quality and fast delivery.', '2026-05-06'),
(20, 18, 31, 5, 'Worth every rupee, works seamlessly.', '2026-02-04'),
(21, 34, 25, 5, 'Great packaging and genuine product.', '2026-07-19'),
(22, 39, 38, 4, 'Excellent build quality and fast delivery.', '2026-06-14'),
(23, 84, 24, 4, 'Excellent build quality and fast delivery.', '2026-04-02'),
(24, 60, 20, 5, 'Good value for money and reliable performance.', '2026-07-10'),
(25, 89, 8, 4, 'Great packaging and genuine product.', '2026-08-08'),
(26, 79, 15, 5, 'Worth every rupee, works seamlessly.', '2026-10-03'),
(27, 20, 30, 3, 'Satisfactory quality, meets basic expectations.', '2026-08-11'),
(28, 54, 45, 4, 'Exceeded expectations, highly recommended.', '2026-11-03'),
(29, 86, 14, 3, 'Satisfactory quality, meets basic expectations.', '2026-03-14'),
(30, 68, 29, 4, 'Great packaging and genuine product.', '2026-03-12'),
(31, 73, 8, 5, 'Good value for money and reliable performance.', '2026-10-17'),
(32, 26, 37, 4, 'Worth every rupee, works seamlessly.', '2026-07-18'),
(33, 67, 29, 5, 'Worth every rupee, works seamlessly.', '2026-10-09'),
(34, 12, 33, 4, 'Excellent build quality and fast delivery.', '2026-09-21'),
(35, 17, 33, 5, 'Good value for money and reliable performance.', '2026-03-02'),
(36, 72, 30, 4, 'Great packaging and genuine product.', '2026-02-12'),
(37, 51, 17, 3, 'Satisfactory quality, meets basic expectations.', '2026-05-23'),
(38, 75, 5, 5, 'Great packaging and genuine product.', '2026-03-05'),
(39, 70, 4, 2, 'Battery or material quality is below par.', '2026-09-30'),
(40, 5, 19, 5, 'Worth every rupee, works seamlessly.', '2026-09-04'),
(41, 48, 25, 4, 'Exceeded expectations, highly recommended.', '2026-08-12'),
(42, 11, 44, 1, 'Battery or material quality is below par.', '2026-07-29'),
(43, 16, 12, 1, 'Not satisfied with the finish, feels flimsy.', '2026-10-29'),
(44, 17, 47, 1, 'Battery or material quality is below par.', '2026-02-12'),
(45, 39, 30, 4, 'Good value for money and reliable performance.', '2026-09-06'),
(46, 69, 25, 3, 'Decent product for the price, average finish.', '2026-09-24'),
(47, 45, 10, 5, 'Excellent build quality and fast delivery.', '2026-02-17'),
(48, 85, 27, 4, 'Excellent build quality and fast delivery.', '2026-06-04'),
(49, 27, 5, 5, 'Excellent build quality and fast delivery.', '2026-09-17'),
(50, 77, 44, 4, 'Excellent build quality and fast delivery.', '2026-06-06');

-- -----------------------------------------------------------------------------
-- 3. PERFORMANCE OPTIMIZATION: INDEXES & EXPLAIN ANALYSIS
-- -----------------------------------------------------------------------------

CREATE INDEX idx_product_search ON Product(product_name, category_id);
CREATE INDEX idx_customer_lookup ON Customer(email, city, loyalty_tier);
CREATE INDEX idx_order_retrieval ON Orders(customer_id, order_date, order_status);
CREATE INDEX idx_order_details_prod ON Order_Details(product_id, order_id);
CREATE INDEX idx_payment_status ON Payment(payment_status, payment_date);

-- Query Optimization Verification using EXPLAIN
EXPLAIN SELECT product_id, product_name, unit_price FROM Product WHERE product_name LIKE 'Wireless%' AND category_id = 1;
EXPLAIN SELECT o.order_id, o.order_date, o.total_amount FROM Orders o WHERE o.customer_id = 5 AND o.order_date BETWEEN '2026-01-01' AND '2026-11-30';

-- -----------------------------------------------------------------------------
-- 4. DATABASE OBJECTS: VIEWS, STORED PROCEDURES, FUNCTIONS, TRIGGERS
-- -----------------------------------------------------------------------------

-- 4A. VIEWS
CREATE OR REPLACE VIEW vw_customer_order_history AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.loyalty_tier,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    p.payment_method,
    p.payment_status
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Payment p ON o.order_id = p.order_id;

CREATE OR REPLACE VIEW vw_sales_report AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.total_amount) AS gross_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM Orders o
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    pr.product_id,
    pr.product_name,
    cat.category_name,
    s.seller_name,
    pr.unit_price,
    COALESCE(SUM(od.quantity), 0) AS units_sold,
    COALESCE(SUM(od.line_total), 0.00) AS total_revenue,
    ROUND(COALESCE(AVG(r.rating), 0), 2) AS avg_rating,
    COUNT(DISTINCT r.review_id) AS review_count
FROM Product pr
JOIN Category cat ON pr.category_id = cat.category_id
JOIN Seller s ON pr.seller_id = s.seller_id
LEFT JOIN Order_Details od ON pr.product_id = od.product_id
LEFT JOIN Orders o ON od.order_id = o.order_id AND o.order_status <> 'Cancelled'
LEFT JOIN Review r ON pr.product_id = r.product_id
GROUP BY pr.product_id, pr.product_name, cat.category_name, s.seller_name, pr.unit_price;

-- 4B. STORED FUNCTIONS
DELIMITER //

CREATE FUNCTION fn_total_customer_spending(p_customer_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(12,2);
    SELECT COALESCE(SUM(total_amount), 0.00)
    INTO v_total
    FROM Orders
    WHERE customer_id = p_customer_id AND order_status <> 'Cancelled';
    RETURN v_total;
END //

CREATE FUNCTION fn_product_revenue(p_product_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_rev DECIMAL(12,2);
    SELECT COALESCE(SUM(od.line_total), 0.00)
    INTO v_rev
    FROM Order_Details od
    JOIN Orders o ON od.order_id = o.order_id
    WHERE od.product_id = p_product_id AND o.order_status <> 'Cancelled';
    RETURN v_rev;
END //

-- 4C. STORED PROCEDURES
CREATE PROCEDURE sp_place_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_shipping_city VARCHAR(80),
    IN p_payment_method ENUM('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Wallet')
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_stock INT;
    DECLARE v_order_id INT;
    DECLARE v_line_total DECIMAL(12,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT unit_price INTO v_price FROM Product WHERE product_id = p_product_id;
    SELECT stock_quantity INTO v_stock FROM Inventory WHERE product_id = p_product_id FOR UPDATE;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for requested quantity';
    END IF;

    SET v_line_total = v_price * p_quantity;

    INSERT INTO Orders (customer_id, order_date, order_status, total_amount, shipping_city)
    VALUES (p_customer_id, CURDATE(), 'Processing', v_line_total, p_shipping_city);
    SET v_order_id = LAST_INSERT_ID();

    INSERT INTO Order_Details (order_id, product_id, quantity, unit_price, line_total)
    VALUES (v_order_id, p_product_id, p_quantity, v_price, v_line_total);

    INSERT INTO Payment (order_id, payment_date, payment_method, payment_status, amount_paid)
    VALUES (v_order_id, CURDATE(), p_payment_method, 'Completed', v_line_total);

    COMMIT;
END //

CREATE PROCEDURE sp_update_stock(
    IN p_product_id INT,
    IN p_added_qty INT
)
BEGIN
    UPDATE Inventory
    SET stock_quantity = stock_quantity + p_added_qty,
        last_updated = CURDATE()
    WHERE product_id = p_product_id;
END //

CREATE PROCEDURE sp_calculate_sales(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT
        COUNT(DISTINCT order_id) AS order_count,
        COALESCE(SUM(total_amount), 0.00) AS total_sales,
        ROUND(COALESCE(AVG(total_amount), 0.00), 2) AS avg_order_value
    FROM Orders
    WHERE order_date BETWEEN p_start_date AND p_end_date
      AND order_status <> 'Cancelled';
END //

-- 4D. TRIGGERS
CREATE TRIGGER trg_reduce_stock_after_order
AFTER INSERT ON Order_Details
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET stock_quantity = GREATEST(0, stock_quantity - NEW.quantity),
        last_updated = CURDATE()
    WHERE product_id = NEW.product_id;
END //

CREATE TRIGGER trg_update_order_status_after_payment
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Completed' THEN
        UPDATE Orders
        SET order_status = 'Shipped'
        WHERE order_id = NEW.order_id AND order_status = 'Processing';
    ELSEIF NEW.payment_status = 'Failed' OR NEW.payment_status = 'Refunded' THEN
        UPDATE Orders
        SET order_status = 'Cancelled'
        WHERE order_id = NEW.order_id;
    END IF;
END //

CREATE TRIGGER trg_audit_order_changes
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action_type, record_id, details)
    VALUES ('Orders', 'UPDATE', NEW.order_id,
            CONCAT('Status changed from ', OLD.order_status, ' to ', NEW.order_status));
END //

DELIMITER ;

-- -----------------------------------------------------------------------------
-- 5. SQL QUERIES: BASIC, INTERMEDIATE & ADVANCED
-- -----------------------------------------------------------------------------

-- 5A. BASIC QUERIES (SELECT, WHERE, ORDER BY, DISTINCT, LIKE, BETWEEN)
SELECT DISTINCT city, state FROM Customer ORDER BY state, city;
SELECT product_id, product_name, unit_price FROM Product WHERE product_name LIKE '%Pro%' ORDER BY unit_price DESC;
SELECT order_id, customer_id, order_date, total_amount FROM Orders WHERE order_date BETWEEN '2026-06-01' AND '2026-08-31' ORDER BY total_amount DESC;

-- 5B. INTERMEDIATE QUERIES (JOINS, AGGREGATES, GROUP BY, HAVING)
SELECT cat.category_name, COUNT(p.product_id) AS product_count, ROUND(AVG(p.unit_price), 2) AS avg_price
FROM Category cat
JOIN Product p ON cat.category_id = p.category_id
GROUP BY cat.category_name
HAVING COUNT(p.product_id) >= 10
ORDER BY avg_price DESC;

SELECT s.seller_name, s.city, COUNT(od.order_detail_id) AS line_items_sold, SUM(od.line_total) AS seller_revenue
FROM Seller s
JOIN Product p ON s.seller_id = p.seller_id
JOIN Order_Details od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY s.seller_id, s.seller_name, s.city
HAVING SUM(od.line_total) > 10000
ORDER BY seller_revenue DESC;

-- 5C. ADVANCED QUERIES (SUBQUERIES, NESTED QUERIES, WINDOW FUNCTIONS, RANKING)
-- Subquery: Customers spending above the overall average order value
SELECT customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, fn_total_customer_spending(customer_id) AS total_spent
FROM Customer
WHERE fn_total_customer_spending(customer_id) > (SELECT AVG(total_amount) * 2 FROM Orders WHERE order_status <> 'Cancelled')
ORDER BY total_spent DESC;

-- Window Function & Ranking: Top 3 products per category by revenue
WITH ProductRev AS (
    SELECT
        cat.category_name,
        p.product_name,
        SUM(od.line_total) AS revenue,
        DENSE_RANK() OVER (PARTITION BY cat.category_name ORDER BY SUM(od.line_total) DESC) AS category_rank
    FROM Product p
    JOIN Category cat ON p.category_id = cat.category_id
    JOIN Order_Details od ON p.product_id = od.product_id
    JOIN Orders o ON od.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY cat.category_name, p.product_name
)
SELECT category_name, product_name, revenue, category_rank
FROM ProductRev
WHERE category_rank <= 3;

-- -----------------------------------------------------------------------------
-- 6. BUSINESS INTELLIGENCE REPORTS
-- -----------------------------------------------------------------------------

-- 6A. SALES INTELLIGENCE REPORT
SELECT SUM(total_amount) AS total_net_revenue, COUNT(*) AS completed_orders, ROUND(AVG(total_amount), 2) AS avg_order_value
FROM Orders WHERE order_status <> 'Cancelled';

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(*) AS orders, SUM(total_amount) AS monthly_revenue
FROM Orders WHERE order_status <> 'Cancelled'
GROUP BY DATE_FORMAT(order_date, '%Y-%m') ORDER BY month;

SELECT p.product_name, SUM(od.quantity) AS units_sold, SUM(od.line_total) AS revenue
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Product p ON od.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name ORDER BY revenue DESC LIMIT 10;

SELECT cat.category_name, SUM(od.line_total) AS category_revenue, SUM(od.quantity) AS units_sold
FROM Order_Details od
JOIN Orders o ON od.order_id = o.order_id
JOIN Product p ON od.product_id = p.product_id
JOIN Category cat ON p.category_id = cat.category_id
WHERE o.order_status <> 'Cancelled'
GROUP BY cat.category_name ORDER BY category_revenue DESC;

-- 6B. CUSTOMER INTELLIGENCE REPORT
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.loyalty_tier,
       COUNT(o.order_id) AS order_frequency, SUM(o.total_amount) AS lifetime_value,
       CASE
           WHEN SUM(o.total_amount) >= 35000 THEN 'VIP'
           WHEN SUM(o.total_amount) >= 15000 THEN 'Regular'
           ELSE 'Occasional'
       END AS customer_segment
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, customer_name, c.loyalty_tier
ORDER BY lifetime_value DESC LIMIT 15;

-- 6C. INVENTORY INTELLIGENCE REPORT
-- Low-stock products
SELECT p.product_id, p.product_name, i.stock_quantity, i.reorder_level, i.warehouse_location
FROM Inventory i JOIN Product p ON i.product_id = p.product_id
WHERE i.stock_quantity <= i.reorder_level ORDER BY i.stock_quantity ASC;

-- Fast-moving vs Overstocked products
SELECT p.product_name, i.stock_quantity, COALESCE(SUM(od.quantity), 0) AS units_sold,
       CASE
           WHEN i.stock_quantity <= i.reorder_level THEN 'Low Stock - Reorder'
           WHEN COALESCE(SUM(od.quantity), 0) >= 6 THEN 'Fast-Moving'
           WHEN i.stock_quantity >= 150 AND COALESCE(SUM(od.quantity), 0) <= 3 THEN 'Overstocked'
           ELSE 'Healthy'
       END AS inventory_status
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
LEFT JOIN Order_Details od ON p.product_id = od.product_id
LEFT JOIN Orders o ON od.order_id = o.order_id AND o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name, i.stock_quantity, i.reorder_level
ORDER BY units_sold DESC;

-- 6D. PRODUCT INTELLIGENCE REPORT
SELECT p.product_name, cat.category_name, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(r.review_id) AS review_count
FROM Product p
JOIN Category cat ON p.category_id = cat.category_id
JOIN Review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, cat.category_name
ORDER BY avg_rating DESC, review_count DESC LIMIT 10;

SELECT rating, COUNT(*) AS review_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Review), 1) AS pct_share
FROM Review GROUP BY rating ORDER BY rating DESC;


WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS monthly_revenue,
        SUM(SUM(o.total_amount)) OVER (ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS cumulative_revenue
    FROM Orders o
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
MonthlyTopCat AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        cat.category_name,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') ORDER BY SUM(od.line_total) DESC) AS rn
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Product p ON od.product_id = p.product_id
    JOIN Category cat ON p.category_id = cat.category_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), cat.category_name
),
MonthlyTopProd AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        p.product_name,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m') ORDER BY SUM(od.quantity) DESC, SUM(od.line_total) DESC) AS rn
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Product p ON od.product_id = p.product_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), p.product_name
)
SELECT
    ms.sales_month,
    ms.total_orders,
    ms.monthly_revenue,
    ms.cumulative_revenue,
    mtc.category_name AS top_category,
    mtp.product_name AS best_selling_product
FROM MonthlySales ms
LEFT JOIN MonthlyTopCat mtc ON ms.sales_month = mtc.sales_month AND mtc.rn = 1
LEFT JOIN MonthlyTopProd mtp ON ms.sales_month = mtp.sales_month AND mtp.rn = 1
ORDER BY ms.sales_month;

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.loyalty_tier,
    COUNT(o.order_id) AS purchase_frequency,
    SUM(o.total_amount) AS lifetime_value,
    CASE
        WHEN SUM(o.total_amount) >= 35000 THEN 'VIP'
        WHEN SUM(o.total_amount) >= 15000 THEN 'Regular'
        ELSE 'Occasional'
    END AS customer_segment
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, customer_name, c.loyalty_tier
ORDER BY lifetime_value DESC
LIMIT 10;

WITH StockStatus AS (
    SELECT
        p.product_name,
        i.stock_quantity,
        COALESCE(SUM(od.quantity), 0) AS units_sold,
        CASE
            WHEN i.stock_quantity <= i.reorder_level THEN 'Low Stock - Reorder'
            WHEN COALESCE(SUM(od.quantity), 0) >= 6 THEN 'Fast-Moving'
            WHEN i.stock_quantity >= 150 AND COALESCE(SUM(od.quantity), 0) <= 3 THEN 'Overstocked'
            ELSE 'Healthy'
        END AS inventory_status
    FROM Product p
    JOIN Inventory i ON p.product_id = i.product_id
    LEFT JOIN Order_Details od ON p.product_id = od.product_id
    LEFT JOIN Orders o ON od.order_id = o.order_id AND o.order_status <> 'Cancelled'
    GROUP BY p.product_id, p.product_name, i.stock_quantity, i.reorder_level
)
SELECT
    inventory_status,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_stock_units,
    SUM(units_sold) AS total_units_sold,
    SUBSTRING_INDEX(GROUP_CONCAT(product_name ORDER BY stock_quantity ASC SEPARATOR ', '), ', ', 3) AS sample_products
FROM StockStatus
GROUP BY inventory_status
ORDER BY product_count DESC;

SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    COALESCE(SUM(od.quantity), 0) AS units_sold,
    COALESCE(SUM(od.line_total), 0.00) AS total_revenue,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(DISTINCT r.review_id) AS review_count,
    CASE
        WHEN AVG(r.rating) >= 4.5 THEN 'Highest-Rated'
        WHEN AVG(r.rating) < 3.0 OR COALESCE(SUM(od.quantity), 0) = 0 THEN 'Poor-Performing'
        ELSE 'Average'
    END AS performance_tier
FROM Product p
JOIN Category cat ON p.category_id = cat.category_id
LEFT JOIN Order_Details od ON p.product_id = od.product_id
LEFT JOIN Orders o ON od.order_id = o.order_id AND o.order_status <> 'Cancelled'
LEFT JOIN Review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name, cat.category_name
HAVING review_count > 0
ORDER BY avg_rating DESC, total_revenue DESC
LIMIT 12;