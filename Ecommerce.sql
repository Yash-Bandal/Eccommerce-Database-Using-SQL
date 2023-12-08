---Database_EcommerceWeb_Implementation---

mysql> create database Ecommerce_Web;
Query OK, 1 row affected (0.06 sec)

mysql> use Ecommerce_Web
Database changed


---Customers Table
mysql> CREATE TABLE Customer (
    ->     customer_id INT PRIMARY KEY,
    ->     contact VARCHAR(255),
    ->     cart TEXT,
    ->     name VARCHAR(255)
    -> );
Query OK, 0 rows affected (0.16 sec)


mysql> INSERT INTO Customer
    -> VALUES (1, '123-456-7890', 'ProductID1, ProductID3', 'Yash L'),
              (2, '987-654-3210', 'ProductID2, ProductID4', 'Aram S'), 
              (3, '555-123-4567', 'ProductID1, ProductID3', 'Akshay P');

            

mysql> select * from Customer;
+-------------+--------------+------------------------+----------+
| customer_id | contact      | cart                   | name     |
+-------------+--------------+------------------------+----------+
|           1 | 123-456-7890 | ProductID1, ProductID3 | Yash L   |
|           2 | 987-654-3210 | ProductID2, ProductID4 | Aram S   |
|           3 | 555-123-4567 | ProductID1, ProductID3 | Akshay P |
+-------------+--------------+------------------------+----------+



-- Premium table
CREATE TABLE Premium (
    customer_id INT PRIMARY KEY,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

mysql> select * from Premium;
Empty set (0.01 sec)


---------------------------------------------------------------------------------------------------------


-- Normal table
CREATE TABLE Normal (
    customer_id INT PRIMARY KEY,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

mysql> select * from Normal;
Empty set (0.01 sec)



---Admin
mysql> CREATE TABLE Admin (
    ->     admin_id INT PRIMARY KEY,
    ->     admin_name VARCHAR(255),
    ->     customer_id INT,
    ->    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ->    );

mysql> insert into Admin Values(1,"Yash L",1),
                               (2,"Aram S",2),
                               (3,"AKshay P",3);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0



mysql> select * from Admin;
+----------+------------+-------------+
| admin_id | admin_name | customer_id |
+----------+------------+-------------+
|        1 | Yash L     |           1 |
|        2 | Aram S     |           2 |
|        3 | AKshay P   |           3 |
+----------+------------+-------------+


---Payement Table
mysql> CREATE TABLE Payment (
    ->     payment_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_id INT,
    ->     FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    ->     FOREIGN KEY (customer_id) REFERENCES Admin(customer_id)
    -> );

-----------------------------------------------------------------------------------------------------------


mysql> INSERT INTO Payment (payment_id, customer_id, order_id)
    -> VALUES (1, 1, 1);

mysql> INSERT INTO Payment (payment_id, customer_id, order_id)
    -> VALUES (2, 2, 2);

mysql> INSERT INTO Payment (payment_id, customer_id, order_id)
    -> VALUES(3,3,3);

mysql> alter table Payment Add Column Amount INT;
mysql> update Payment Set Amount=1000 Where customer_id=1;
mysql> update Payment Set Amount=2000 Where customer_id=2;
mysql> update Payment Set Amount=3000 Where customer_id=3;


mysql> select * from Payment;
+------------+-------------+----------+--------+
| payment_id | customer_id | order_id | Amount |
+------------+-------------+----------+--------+
|          1 |           1 |        1 |   1000 |
|          2 |           2 |        2 |   2000 |
|          3 |           3 |        3 |   3000 |
+------------+-------------+----------+--------+

---Product Table 
mysql>
mysql> CREATE TABLE Product (
    ->     product_id INT PRIMARY KEY,
    ->     seller_id INT,
    ->     dep_id INT,
    ->     product_name VARCHAR(255),
    ->     color VARCHAR(50),
    ->     cost DECIMAL(10, 2),
    ->     admin_id INT,
    ->     FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
    -> );

mysql> INSERT INTO Product (product_id, seller_id, dep_id, product_name, color, cost, admin_id)
    -> VALUES (1, 101, 201, 'Laptop', 'Silver', 800.00, 1);
mysql> INSERT INTO Product (product_id, seller_id, dep_id, product_name, color, cost, admin_id)
    -> VALUES (2, 102, 202, 'Watch', 'Black', 2000.00, 2);
mysql> INSERT INTO Product (product_id, seller_id, dep_id, product_name, color, cost, admin_id)
    -> VALUES (3, 103, 203, 'Shirt', 'Red', 3000.00, 3);




--------------------------------------------------------------------------------------------------


mysql> select * from Product;
+------------+-----------+--------+--------------+--------+---------+----------+
| product_id | seller_id | dep_id | product_name | color  | cost    | admin_id |
+------------+-----------+--------+--------------+--------+---------+----------+
|          1 |       101 |    201 | Laptop       | Silver |  800.00 |        1 |
|          2 |       102 |    202 | Watch        | Black  | 2000.00 |        2 |
|          3 |       103 |    203 | Shirt        | Red    | 3000.00 |        3 |
+------------+-----------+--------+--------------+--------+---------+----------+    


---Seller Table

mysql> CREATE TABLE Seller (
    ->     seller_id INT ,
    ->     admin_id INT,
    ->     seller_name VARCHAR(255),
    ->     contact VARCHAR(255),
    ->    FOREIGN KEY(seller_id) REFERENCES Product(seller_id),
    ->    FOREIGN KEY(admin_id) REFERENCES Admin(admin_id)
    -> );
Query OK, 0 rows affected (0.21 sec)


mysql> INSERT INTO Seller (seller_id, admin_id, seller_name, contact)
    -> VALUES
    ->     (101, 1, 'HP', 'HP-TollFree-000111'),
    ->     (102, 2, 'Titan', 'Titan-TollFree-222333'),
    ->     (103, 3, 'Khadi', 'KhadiIndia-TollFree-7777777');


mysql> select * from Seller;
+-----------+----------+-------------+-----------------------------+
| seller_id | admin_id | seller_name | contact                     |
+-----------+----------+-------------+-----------------------------+
|       101 |        1 | HP          | HP-TollFree-000111          |
|       102 |        2 | Titan       | Titan-TollFree-222333       |
|       103 |        3 | Khadi       | KhadiIndia-TollFree-7777777 |
+-----------+----------+-------------+-----------------------------+


--------------------------------------------------------------------------------------------------------------

---Department Table

mysql> CREATE TABLE department
    -> (
    ->     dep_id INT,
    ->     department_name VARCHAR(255),
    ->     product_id INT,
    ->     FOREIGN KEY (product_id) REFERENCES  Product(product_id)
    -> );


mysql> insert into department Values
    -> (201,"Electronics",1),
    -> (202,"Accessories",2),
    -> (203,"Clothing",3);
Query OK, 3 rows affected (0.01 sec)


mysql> select * from department;
+--------+-----------------+------------+
| dep_id | department_name | product_id |
+--------+-----------------+------------+
|    201 | Electronics     |          1 |
|    202 | Accessories     |          2 |
|    203 | Clothing        |          3 |
+--------+-----------------+------------+
3 rows in set (0.00 sec)


---Employees Table
mysql> ALTER TABLE Department
    -> ADD PRIMARY KEY (dep_id);


mysql> CREATE TABLE Employees (
    ->     dep_id INT,
    ->     emp_id INT PRIMARY KEY,
    ->     Name VARCHAR(255),
    ->     Increment INT,
    ->     salary INT,
    ->     FOREIGN KEY (dep_id) REFERENCES Department(dep_id)
    -> );
Query OK, 0 rows affected (0.17 sec)

--------------------------------------------------------------------------------------------------------------


mysql> INSERT INTO Employees (dep_id, emp_id, Name, Increment, salary)
    -> VALUES
    ->     (201, 101, 'Nobita Nobi', 500, 50000),
    ->     (202, 102, 'Gian Goda', 700, 60000),
    ->     (203, 103, 'Suneo Honekawa', 600, 55000);
Query OK, 3 rows affected (0.02 sec)


mysql> select * from Employees;
+--------+--------+----------------+-----------+--------+
| dep_id | emp_id | Name           | Increment | salary |
+--------+--------+----------------+-----------+--------+
|    201 |    101 | Nobita Nobi    |       500 |  50000 |
|    202 |    102 | Gian Goda      |       700 |  60000 |
|    203 |    103 | Suneo Honekawa |       600 |  55000 |
+--------+--------+----------------+-----------+--------+
3 rows in set (0.00 sec)


---Department_salary Table

mysql> CREATE TABLE department_salary (
    ->     dep_id INT,
    ->     total_salary  INT,
    ->     PRIMARY KEY (dep_id),
    ->     FOREIGN KEY (dep_id) REFERENCES Department(dep_id)
    -> );
Query OK, 0 rows affected (0.04 sec)


mysql> INSERT INTO department_salary (dep_id, total_salary)
    -> SELECT dep_id, SUM(Increment + salary) AS total_salary 
    ---Uses aggregate  Function Sum()
    -> FROM Employees
    -> GROUP BY dep_id;
Query OK, 3 rows affected (0.04 sec)


mysql> select * from department_salary;
+--------+--------------+
| dep_id | total_salary |
+--------+--------------+
|    201 |        50500 |
|    202 |        60700 |
|    203 |        55600 |
+--------+--------------+
3 rows in set (0.00 sec)


------------------------------------------------------------------------------------------------------------------

---Orders Table

mysql> CREATE TABLE Orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     Status VARCHAR(255),
    ->     order_date DATE,
    ->     order_type VARCHAR(255),
    ->    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    -> );
Query OK, 0 rows affected (0.21 sec)


mysql> INSERT INTO Orders (order_id, customer_id, Status, order_date, order_type)
    -> VALUES
    ->     (101, 1, 'Pending', '2023-01-01', 'Online'),
    ->     (201, 2, 'Shipped', '2023-01-02', 'In-Store'),
    ->     (301, 3, 'Delivered', '2023-01-03', 'Phone Order');
Query OK, 3 rows affected (0.01 sec)


mysql> select * from Orders;
+----------+-------------+-----------+------------+-------------+
| order_id | customer_id | Status    | order_date | order_type  |
+----------+-------------+-----------+------------+-------------+
|      101 |           1 | Pending   | 2023-01-01 | Online      |
|      201 |           2 | Shipped   | 2023-01-02 | In-Store    |
|      301 |           3 | Delivered | 2023-01-03 | Phone Order |
+----------+-------------+-----------+------------+-------------+
3 rows in set (0.00 sec)

mysql> Show tables;
+-------------------------+
| Tables_in_ecommerce_web |
+-------------------------+
| admin                   |
| customer                |
| department              |
| department_salary       |
| employees               |
| orders                  |
| payment                 |
| premium                 |
| product                 |
| seller                  |
+-------------------------+

---------------------------------------------------------------------------------------------


---Applying Aggregate Functions On Database---

mysql> INSERT INTO Product (product_id, seller_id, dep_id, product_name, color, cost, admin_id)
    -> VALUES (4, 102, 202, 'Headphones', 'Amoled-Black', 2500.00, 2),
              (5, 102, 202, 'Broach', 'Emerald-Green', 5800.00, 1);

mysql> select * from product;
+------------+-----------+--------+--------------+---------------+---------+----------+
| product_id | seller_id | dep_id | product_name | color         | cost    | admin_id |
+------------+-----------+--------+--------------+---------------+---------+----------+
|          1 |       101 |    201 | Laptop       | Silver        |  800.00 |        1 |
|          2 |       102 |    202 | Watch        | Black         | 2000.00 |        2 |
|          3 |       103 |    203 | Shirt        | Red           | 3000.00 |        3 |
|          4 |       102 |    202 | Headphones   | Amoled-Black  | 2500.00 |        2 |
|          5 |       102 |    202 | Broach       | Emerald-Green | 5800.00 |        1 |
+------------+-----------+--------+--------------+---------------+---------+----------+

---Total Cost for Each Admin:
mysql> SELECT admin_id, SUM(cost) AS totalSum
    -> FROM Product
    -> GROUP BY admin_id;
+----------+----------+
| admin_id | totalSum |
+----------+----------+
|        1 |  6600.00 |
|        2 |  4500.00 |
|        3 |  3000.00 |
+----------+----------+

--Total Cost for Admin ID 2:
mysql> SELECT SUM(cost) AS totalSum
    -> FROM Product
    -> WHERE admin_id = 2;
+----------+
| totalSum |
+----------+
|  4500.00 |
+----------+

--Average Cost:
mysql> SELECT AVG(cost) AS averageCost
    -> FROM Product;
+-------------+
| averageCost |
+-------------+
| 2820.000000 |
+-------------+

--Maximum Cost:
mysql> SELECT MAX(cost) AS maxCost
    -> FROM Product;
+---------+
| maxCost |
+---------+
| 5800.00 |
+---------+

--Minimum Cost:
mysql> SELECT MIN(cost) AS minCost
    -> FROM Product;
+---------+
| minCost |
+---------+
|  800.00 |
+---------+

--------------------------------------------------------------------------------------------------------

---Trigger---
--create a trigger to update cart in customer to
-- product name 'watch' when order placed by customer with customer id 2--

mysql> Delimiter //
mysql>
mysql> CREATE TRIGGER update_cart_after_ordering
    -> AFTER INSERT ON Orders
    -> FOR EACH ROW
    -> BEGIN
    ->     DECLARE product_name VARCHAR(255);
    ->
    ->     SELECT product_name INTO product_name
    ->     FROM Product
    ->     WHERE product_id = NEW.order_id;
    ->
    ->
    ->     IF NEW.customer_id = 2 AND product_name = 'Watch' THEN
    ->         UPDATE Customer
    ->         SET cart = CONCAT(cart, ', Watch')  -- Add 'Watch' to the cart
    ->         WHERE customer_id = NEW.customer_id;
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.03 sec)

mysql> Delimiter ;

--Before Insert--
mysql> select * from customer;
+-------------+--------------+------------------------+----------+
| customer_id | contact      | cart                   | name     |
+-------------+--------------+------------------------+----------+
|           1 | 123-456-7890 | ProductID1, ProductID3 | Yash L   |
|           2 | 987-654-3210 | ProductID2, ProductID4 | Aram S   |
|           3 | 555-123-4567 | ProductID1, ProductID3 | Akshay P |
+-------------+--------------+------------------------+----------+

mysql> insert into Orders Values(701,2,'Pending','2023-01-02','Online');

--After Insert
mysql> select * from customer;
+-------------+--------------+------------------------+----------+
| customer_id | contact      | cart                   | name     |
+-------------+--------------+------------------------+----------+
|           1 | 123-456-7890 | ProductID1, ProductID3 | Yash L   |
|           2 | 987-654-3210 | Watch                  | Aram S   |
|           3 | 555-123-4567 | ProductID1, ProductID3 | Akshay P |
+-------------+--------------+------------------------+----------+

-----------------------------------------------------------------------------------

--Stored Procedure
-- A stored procedure that checks the availability of a product based on its ID and currentstock:

mysql> ALTER TABLE Product
    -> ADD COLUMN stock_quantity INT;

mysql> UPDATE Product SET stock_quantity = 50 WHERE product_id = 1;
mysql> UPDATE Product SET stock_quantity = 100 WHERE product_id = 2; 
mysql> UPDATE Product SET stock_quantity = 75 WHERE product_id = 3;   

mysql> select product_id,product_name,cost,stock_quantity from Product;
+------------+--------------+---------+----------------+
| product_id | product_name | cost    | stock_quantity |
+------------+--------------+---------+----------------+
|          1 | Laptop       |  800.00 |             50 |
|          2 | Watch        | 2000.00 |            100 |
|          3 | Shirt        | 3000.00 |             75 |
|          4 | Headphones   | 2500.00 |           NULL |
|          5 | Broach       | 5800.00 |           NULL |
+------------+--------------+---------+----------------+


mysql> DELIMITER //
mysql> CREATE PROCEDURE CheckProductAvailability
    ->(IN productID INT, IN quantity INT, OUT availability VARCHAR(50))
    -> BEGIN
    ->     DECLARE currentStock INT;
    ->
    ->     SELECT stock_quantity INTO currentStock
    ->     FROM Product
    ->     WHERE product_id = productID;
    ->
    ->
    ->     IF currentStock >= quantity THEN
    ->         SET availability = 'Available';
    ->     ELSE
    ->         SET availability = 'Out_of_Stock';
    ->     END IF;
    -> END //
Query OK, 0 rows affected (0.09 sec)

mysql> DELIMITER ;
mysql> CALL CheckProductAvailability
    ->(1, 5, @availability); --(pdt_id,quantity_required,@check)
mysql> select @availability;
+---------------+
| @availability |
+---------------+
| Available     |
+---------------+
mysql> CALL CheckProductAvailability
    ->(1, 55, @availability);
mysql> select @availability;
+---------------+
| @availability |
+---------------+
| Out_of_Stock  |
+---------------+



---------------------------------------------------------------
--Stored Functions
--A Function to check if customer Eligible for Premium Account
--Criteria..Customer has Payment > 1500

mysql> select * from Payment;
+------------+-------------+----------+--------+
| payment_id | customer_id | order_id | Amount |
+------------+-------------+----------+--------+
|          1 |           1 |        1 |   1000 |
|          2 |           2 |        2 |   2000 |
|          3 |           3 |        3 |   3000 |
+------------+-------------+----------+--------+

mysql> DELIMITER //
mysql> CREATE FUNCTION PremiumCheck(customerID INT) RETURNS VARCHAR(20)
    -> DETERMINISTIC
    -> BEGIN
    ->     DECLARE totalAmountSpent DECIMAL(10, 2);
    ->
    ->     SELECT SUM(Payment.Amount)
    ->     INTO totalAmountSpent
    ->     FROM Payment
    ->     WHERE Payment.customer_id = customerID;
    ->
    ->     IF totalAmountSpent >= 1500 THEN
    ->         RETURN 'Eligible';
    ->     ELSE
    ->         RETURN 'Not_Eligible';
    ->     END IF;
    -> END //
mysql> DELIMITER ;    

mysql> SELECT PremiumCheck(2) AS EligibilityStatus;
+-------------------+
| EligibilityStatus |
+-------------------+
| Eligible          |
+-------------------+

mysql> SELECT PremiumCheck(1) AS EligibilityStatus;
+-------------------+
| EligibilityStatus |
+-------------------+
| Not_Eligible      |
+-------------------+


-----------------------------------------------------------------
---Cursor
--Cursor implementation to alert User if stock_quantity is less than 15

mysql> update Product Set stock_quantity=15 where product_id=4;
mysql> select product_id,product_name,cost,stock_quantity from Product;
+------------+--------------+---------+----------------+
| product_id | product_name | cost    | stock_quantity |
+------------+--------------+---------+----------------+
|          1 | Laptop       |  800.00 |             50 |
|          2 | Watch        | 2000.00 |            100 |
|          3 | Shirt        | 3000.00 |             75 |
|          4 | Headphones   | 2500.00 |             15 |
|          5 | Broach       | 5800.00 |           NULL |
+------------+--------------+---------+----------------+

mysql> DELIMITER //
mysql> CREATE PROCEDURE ProductStockAlert()
    -> BEGIN
    ->     DECLARE productID INT;
    ->     DECLARE productName VARCHAR(255);
    ->     DECLARE stockQuantity INT;
    ->
    ->     DECLARE productCursor CURSOR FOR
    ->         SELECT product_id, product_name, stock_quantity
    ->         FROM Product;
    ->
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND
    ->         SET productID = NULL;
    ->
    ->     OPEN productCursor;
    ->
    ->     FETCH productCursor INTO productID, productName, stockQuantity;
    ->
    ->     WHILE productID IS NOT NULL DO
    ->         IF stockQuantity < 20 THEN
    ->
    ->             SELECT CONCAT('Product ID ', productID, ' - ', productName, 
    ->      ' needs restocking. Current Stock: ', stockQuantity) AS StockAlert;
    ->         END IF;
    ->         FETCH productCursor INTO productID, productName, stockQuantity;
    ->     END WHILE;
    ->
    ->     CLOSE productCursor;
    -> END //
 mysql> DELIMITER ;


 mysql> CALL ProductStockAlert();
+---------------------------------------------------------------+
| StockAlert                                                    |
+---------------------------------------------------------------+
| Product ID 4 - Headphones needs restocking. Current Stock: 15 |
+---------------------------------------------------------------+   









