-- =========================================
-- E-Commerce SQL Analytics Project
-- Student: Tharwat Badr
-- Track: Data Engineering
-- Description: Build an E-commerce database and run analytical queries
-- =========================================

-- =========================================
-- Create Database
-- الهدف: إنشاء قاعدة بيانات لمتجر إلكتروني
-- =========================================

CREATE DATABASE Ecommerce_SQL_Project;

-- =========================================
-- Table: customers
-- الهدف: تخزين بيانات العملاء
-- كل عميل يمكنه إنشاء عدة طلبات
-- =========================================

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    -- رقم العميل (مفتاح أساسي)
    name VARCHAR(255) NOT NULL,
    -- اسم العميل
    email VARCHAR(100) UNIQUE NOT NULL,
    -- البريد الإلكتروني (يجب أن يكون فريد)
    created_at DATE ,
    -- تاريخ إنشاء الحساب
    city VARCHAR(50),
    -- المدينة
    country VARCHAR(50)
    -- الدولة
);

-- =========================================
-- Table: products
-- الهدف: تخزين المنتجات الموجودة في المتجر
-- =========================================

CREATE TABLE products
(
    product_id INT PRIMARY KEY IDENTITY(1,1),
    -- رقم المنتج
    name VARCHAR(255) NOT NULL,
    -- اسم المنتج
    category VARCHAR(255) NOT NULL,
    -- فئة المنتج
    price DECIMAL(10,2),
    -- سعر المنتج
    active BIT
    -- هل المنتج متاح للبيع
);

-- =========================================
-- Table: orders
-- الهدف: تخزين الطلبات التي يقوم بها العملاء
-- كل طلب مرتبط بعميل معين
-- =========================================

CREATE TABLE orders
(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    -- رقم الطلب
    customer_id INT,
    -- العميل الذي قام بالطلب
    order_date DATE,
    -- تاريخ الطلب
    status VARCHAR(50),
    -- حالة الطلب (completed / pending / cancelled)

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =========================================
-- Table: order_items
-- الهدف: تخزين تفاصيل المنتجات داخل كل طلب
-- الطلب الواحد قد يحتوي على أكثر من منتج
-- =========================================

CREATE TABLE order_items
(
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    -- رقم العنصر داخل الطلب
    order_id INT,
    -- رقم الطلب
    product_id INT,
    -- رقم المنتج
    quantity INT,
    -- الكمية
    unit_price DECIMAL(10,2),
    -- سعر المنتج وقت الطلب

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================================
-- Table: payments
-- الهدف: تخزين عمليات الدفع المرتبطة بالطلبات
-- =========================================

CREATE TABLE payments
(
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    -- رقم عملية الدفع
    order_id INT NOT NULL,
    -- الطلب المرتبط بالدفع
    amount DECIMAL(10,2) NOT NULL,
    -- المبلغ المدفوع
    payment_date DATE,
    -- تاريخ الدفع
    method VARCHAR(50),
    -- طريقة الدفع (card / cash)
    status VARCHAR(50),
    -- حالة الدفع (succeeded / failed / pending)

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- =========================================
-- Insert Customers
-- إضافة بيانات العملاء
-- =========================================
INSERT INTO customers
    (name,email,created_at,city,country)
VALUES
    ('Ahmed Farag', 'ahmedfarag99@gmail.com', '2023-01-10', 'Cairo', 'Egypt'),
    ('Mohamed AboNe3ma', 'mohamedabonema08@gmail.com', '2023-02-12', 'Elmahalah', 'Egypt'),
    ('Mo Etman', 'mae@gmail.com', '2023-03-05', 'Ibyar', 'Egypt'),
    ('Mona Samir', 'mona@gmail.com', '2023-04-20', 'Cairo', 'Egypt'),
    ('Youssef Adel', 'youssef@gmail.com', '2023-05-15', 'Tanta', 'Egypt'),
    ('Nour Khaled', 'nour@gmail.com', '2023-06-10', 'Mansoura', 'Egypt'),
    ('Ali Mahmoud', 'ali@gmail.com', '2023-07-01', 'Cairo', 'Egypt'),
    ('Hassan Tarek', 'hassan@gmail.com', '2023-08-03', 'Giza', 'Egypt'),
    ('Salma Sameh', 'salma@gmail.com', '2023-09-12', 'Obour', 'Egypt'),
    ('Karim Nabil', 'karim@gmail.com', '2023-10-05', 'Cairo', 'Egypt');

-- =========================================
-- Insert Products
-- إضافة المنتجات الموجودة في المتجر
-- =========================================

INSERT INTO products
    (name,category,price,active)
VALUES
    ('Laptop', 'Electronics', 15000, 1),
    ('Phone', 'Electronics', 8000, 1),
    ('Headphones', 'Electronics', 500, 1),
    ('Keyboard', 'Accessories', 300, 1),
    ('Mouse', 'Accessories', 200, 1),
    ('Monitor', 'Electronics', 3500, 1);

-- =========================================
-- Insert Orders
-- تسجيل الطلبات التي قام بها العملاء
-- =========================================

INSERT INTO orders
    (customer_id,order_date,status)
VALUES
    (1, '2024-01-10', 'completed'),
    (2, '2024-01-11', 'completed'),
    (3, '2024-01-12', 'pending'),
    (4, '2024-01-13', 'completed'),
    (5, '2024-01-14', 'cancelled'),
    (6, '2024-01-15', 'completed'),
    (7, '2024-01-16', 'pending'),
    (8, '2024-01-17', 'completed'),
    (9, '2024-01-18', 'completed'),
    (10, '2024-01-19', 'completed'),
    (1, '2024-02-01', 'completed'),
    (2, '2024-02-02', 'completed');

-- =========================================
-- Insert Order Items
-- إضافة المنتجات داخل الطلبات
-- =========================================

INSERT INTO order_items
    (order_id,product_id,quantity,unit_price)
VALUES
    (1, 1, 1, 15000),
    (1, 3, 2, 500),
    (2, 2, 1, 8000),
    (2, 5, 1, 200),
    (3, 4, 1, 300),
    (4, 6, 1, 3500),
    (5, 2, 1, 8000),
    (6, 3, 3, 500),
    (7, 1, 1, 15000),
    (8, 5, 2, 200),
    (9, 4, 1, 300),
    (10, 6, 1, 3500),
    (11, 2, 1, 8000),
    (11, 3, 1, 500),
    (12, 1, 1, 15000),
    (3, 5, 2, 200),
    (4, 2, 1, 8000),
    (6, 4, 1, 300),
    (7, 3, 1, 500),
    (8, 6, 1, 3500);

-- =========================================
-- Insert Payments
-- تسجيل عمليات الدفع الخاصة بالطلبات
-- =========================================

INSERT INTO payments
    (order_id,amount,payment_date,method,status)
VALUES
    (1, 16000, '2024-01-10', 'card', 'succeeded'),
    (2, 8200, '2024-01-11', 'cash', 'succeeded'),
    (3, 300, '2024-01-12', 'card', 'failed'),
    (4, 3500, '2024-01-13', 'card', 'succeeded'),
    (5, 8000, '2024-01-14', 'cash', 'failed'),
    (6, 1500, '2024-01-15', 'card', 'succeeded'),
    (7, 15000, '2024-01-16', 'cash', 'pending'),
    (8, 400, '2024-01-17', 'card', 'succeeded'),
    (9, 300, '2024-01-18', 'card', 'succeeded'),
    (10, 3500, '2024-01-19', 'cash', 'succeeded'),
    (11, 8500, '2024-02-01', 'card', 'succeeded'),
    (12, 15000, '2024-02-02', 'cash', 'succeeded');

-- =========================================
-- Update Orders Dates
-- الهدف: تعديل بعض التواريخ حتى يظهر Query آخر 6 شهور بيانات
-- =========================================

UPDATE orders
SET order_date = '2025-12-10'
WHERE order_id IN (1,2,3,4,5);

-- =========================================
-- View Data
-- عرض البيانات الموجودة في الجداول
-- =========================================

SELECT *
FROM customers;
SELECT *
FROM products;
SELECT *
FROM orders;
SELECT *
FROM order_items;
SELECT *
FROM payments;

-- =========================================
-- TASK 1: Top 3 Customers by Spending
-- الهدف: معرفة أكثر العملاء دفعاً في الموقع
-- يتم حساب الإنفاق باستخدام المدفوعات الناجحة فقط
-- =========================================

SELECT TOP 3
    c.name,
    SUM(p.amount) AS total_spent
FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    JOIN payments p
    ON o.order_id = p.order_id
WHERE p.status = 'succeeded'
GROUP BY c.name
ORDER BY total_spent DESC;

-- =========================================
-- TASK 2: Orders Above Average
-- الهدف: عرض المدفوعات التي قيمتها أعلى من متوسط المدفوعات
-- =========================================

SELECT *
FROM payments
WHERE amount >
(
SELECT AVG(amount)
FROM payments
);

-- =========================================
-- TASK 3: Customers with Orders in Last 6 Months
-- الهدف: معرفة العملاء الذين قاموا بطلبات خلال آخر 6 شهور
-- =========================================

SELECT DISTINCT c.name
FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_date >= DATEADD(MONTH,-6,GETDATE());

-- =========================================
-- TASK 4: Customer Frequency Segmentation
-- الهدف: تصنيف العملاء حسب عدد الطلبات
-- =========================================

SELECT
    c.name,
    COUNT(o.order_id) AS total_orders,

    CASE
WHEN COUNT(o.order_id) = 1 THEN 'New'
WHEN COUNT(o.order_id) BETWEEN 2 AND 4 THEN 'Regular'
ELSE 'VIP'
END AS customer_type

FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name;
