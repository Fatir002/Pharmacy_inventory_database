-- Create the database
CREATE DATABASE p_inventory;
USE p_inventory;

-- Create Customer Table
CREATE TABLE customer (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(100) NOT NULL,
    c_age INT CHECK (c_age > 0),
    c_city VARCHAR(50),
    c_email VARCHAR(100),  -- optional attribute
    c_phone VARCHAR(15)    -- optional attribute
);

-- Create Products Table
CREATE TABLE products (
    p_id INT PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    p_price FLOAT CHECK (p_price >= 0),
    p_exp DATE,
    p_type VARCHAR(50),             -- optional: Tablet, Syrup, etc.
    p_description TEXT              -- optional attribute
);

-- Create Supplier Table
CREATE TABLE supplier (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(100) NOT NULL,
    s_contact VARCHAR(15),
    s_city VARCHAR(50)
);

-- Create Inventory Table (Stock Info)
CREATE TABLE inventory (
    inv_id INT PRIMARY KEY,
    p_id INT,
    s_id INT,
    stock_quantity INT CHECK (stock_quantity >= 0),
    last_restock DATE,
    FOREIGN KEY (p_id) REFERENCES products(p_id),
    FOREIGN KEY (s_id) REFERENCES supplier(s_id)
);

-- Create Pharmacist Table
CREATE TABLE pharmacist (
    pharm_id INT PRIMARY KEY,
    pharm_name VARCHAR(100) NOT NULL,
    pharm_email VARCHAR(100),
    pharm_phone VARCHAR(15)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    c_id INT,
    pharm_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (c_id) REFERENCES customer(c_id),
    FOREIGN KEY (pharm_id) REFERENCES pharmacist(pharm_id)
);

-- Create Order_Details Table (Junction between orders and products)
CREATE TABLE order_details (
    order_id INT,
    p_id INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (p_id) REFERENCES products(p_id),
    PRIMARY KEY (order_id, p_id)
);

-- Insert Customers
INSERT INTO customer VALUES 
(1, 'John Doe', 34, 'New York', 'john.doe@example.com', '1234567890'),
(2, 'Jane Smith', 28, 'Los Angeles', NULL, '9876543210'),
(3, 'Alice Brown', 45, 'Chicago', 'alice.b@example.com', NULL);

-- Insert Products
INSERT INTO products VALUES 
(101, 'Paracetamol', 1.99, '2026-05-30', 'Tablet', 'Used for fever and mild pain'),
(102, 'Cough Syrup', 3.49, '2025-11-10', 'Syrup', 'Relieves cough symptoms'),
(103, 'Vitamin D', 5.00, '2027-01-15', 'Capsule', NULL);

-- Insert Suppliers
INSERT INTO supplier VALUES 
(201, 'MediSupply Inc.', '555-1212', 'New York'),
(202, 'Pharma Distributors', '555-2323', 'San Francisco');

-- Insert Inventory
INSERT INTO inventory VALUES
(301, 101, 201, 200, '2025-08-20'),
(302, 102, 202, 150, '2025-07-15'),
(303, 103, 201, 100, '2025-09-01');

-- Insert Pharmacists
INSERT INTO pharmacist VALUES
(401, 'Dr. Emily Stone', 'emily.stone@pharmacy.com', '111-222-3333'),
(402, 'Mr. Alan Reed', NULL, '222-333-4444');

-- Insert Orders
INSERT INTO orders VALUES
(501, 1, 401, '2025-09-01'),
(502, 2, 402, '2025-09-03');

-- Insert Order Details
INSERT INTO order_details VALUES
(501, 101, 2),
(501, 103, 1),
(502, 102, 3);

-- View to see full order details
CREATE VIEW order_summary AS
SELECT o.order_id, o.order_date, c.c_name, p.p_name, od.quantity, p.p_price,
       (od.quantity * p.p_price) AS total_price
FROM orders o
JOIN customer c ON o.c_id = c.c_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.p_id = p.p_id;

 SELECT * FROM order_summary