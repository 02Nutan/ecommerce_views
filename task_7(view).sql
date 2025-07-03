use ecommerce_db;

-- orders with the customer name and how much they paid
CREATE VIEW SimpleOrderView AS
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status,
    p.amount AS payment_amount
FROM
    Orders o
JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN Payment p ON o.order_id = p.order_id;

-- See the data from the view
SELECT * FROM SimpleOrderView;

-- Shows how many orders each customer has placed
CREATE OR REPLACE VIEW CustomerOrderCount AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.address,
    COUNT(o.order_id) AS total_orders
FROM
    Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.name, c.address;
  
-- See the data from the view
SELECT * FROM CustomerOrderCount;

-- Shows how many units of each product have been sold and total revenue
CREATE OR REPLACE VIEW ProductSalesSummary AS
SELECT
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_revenue
FROM
    Product p
LEFT JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.name;

-- See the data from the view
SELECT * FROM ProductSalesSummary;

-- Shows only the most recent 5 orders
CREATE OR REPLACE VIEW RecentOrders AS
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status
FROM
    Orders o
JOIN Customer c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC
LIMIT 5;

-- See the data from the view
SELECT * FROM RecentOrders; 

-- show each product in each order
CREATE OR REPLACE VIEW OrderDetailsView AS
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.status,
    p.name AS product_name,
    oi.quantity,
    pay.amount AS payment_amount,
    pay.method AS payment_method
FROM
    Orders o
JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN OrderItem oi ON o.order_id = oi.order_id
LEFT JOIN Product p ON oi.product_id = p.product_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id;

-- See the data from the view
SELECT * FROM OrderDetailsView;





