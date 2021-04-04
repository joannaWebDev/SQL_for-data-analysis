/* turn on the database**/
USE sql_store;

SELECT 
    last_name,
    first_name,
    points,
    (points + 10) * 100 AS discount_factor
FROM
    customers;
    
/*◾◾◾◾◾◾◾◾◾◾◾GET UNIQUE VALUE. REMOVE DUPPLICATES IF ANY 👇◾◾◾◾◾◾◾◾◾◾◾*/
SELECT DISTINCT state
FROM customers;

-- ⚡ Exercise:
-- Return all products
-- name
-- unit price
-- new price

SELECT p.name, p.unit_price, p.unit_price * 1.1 AS new_price
FROM products AS p;

SELECT * 
FROM customers 
WHERE points > 3000;    
    
-- ⚡ Exercise
-- From the order_items table, get the items
-- for order #6
-- where the total price is geater than 30

SELECT *
FROM order_items AS o
WHERE o.order_id = 6 AND ((o.unit_price * o.quantity) > 30);

/*◾◾◾◾◾◾◾◾◾◾◾"IN" OPERATOR ◾◾◾◾◾◾◾◾◾◾◾
 INSTEAD OF 'OR' 'OR' 'OR' , WE CAN USE IN 👇 */
 
  SELECT *
  FROM customers
  WHERE state IN ('VA', 'FL', 'GA');
    
 /*
 When you want to compare an attribute with a list of values
 ◾◾◾◾◾◾◾◾◾◾◾"IN" OPERATOR ◾◾◾◾◾◾◾◾◾◾◾
 INSTEAD OF 'OR' 'OR' 'OR' , WE CAN USE IN 👇 */
 
  SELECT *
  FROM customers
  WHERE state IN ('VA', 'FL', 'GA');   
  
  /*
 When you want to compare an attribute with a list of values
 ◾◾◾◾◾◾◾◾◾◾◾"NOT IN" OPERATOR ◾◾◾◾◾◾◾◾◾◾◾
the opposite 👇 */
 
  SELECT *
  FROM customers
  WHERE state NOT IN ('VA', 'FL', 'GA');   
  
  
 /*◾◾◾◾◾◾◾◾◾◾◾BETWEEN OPERATOR ◾◾◾◾◾◾◾◾◾◾◾
 The values are inclusive,which means that is going to be >= AND <= 👇 */

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;
  
 /*all the values that start with X and % are followed by any number or no number of characters
 makes no differece if it's uppercase or lowercase*/
 
SELECT *
FROM customers
WHERE last_name LIKE 'b%';
  
/* those who have a letter anywhere in the value*/
SELECT *
FROM customers
WHERE last_name LIKE '%b%';  

/* those who's name is exactly 5 characters long(5 _) and ends in y*/
SELECT *
FROM customers
WHERE last_name LIKE '_____y';  

/* ◾◾◾◾◾◾◾◾◾◾◾REGEXP ◾◾◾◾◾◾◾◾◾◾◾
Regular expression
Extremely powerful when it comes to strings
They allow us to search for more complex patterns
more modern than LIKE
those who have the word "field" in their name 👇 */
SELECT *
FROM customers
WHERE last_name REGEXP 'field';  

/* ❗❗❗❗❗ REGEXP 
^  the BEGINNING of a string
$  the END of a string
|  or
 */
 
 SELECT *
FROM customers
WHERE last_name REGEXP 'field$';  

/*the pattern should have field OR mac in their name*/
SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac';  


/*the pattern should start with field OR mac OR rose */
 SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose';  

/*the pattern should has either ge or ie or me  */
 SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';  

/*the pattern should has anything between a-h folllowed by e  */
 SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';  

SELECT *
FROM customers
-- WHERE first_name REGEXP 'elka|ambur'; -- first names are ELKA or AMBUR
-- WHERE last_name REGEXP 'ey$|on$'; -- last names end with EY or On       ❗❗❗❗❗ $ in both conditions
-- WHERE last_name REGEXP '^my|se';   -- last names start with MY or contains SE
-- WHERE last_name REGEXP 'br|bu'; -- last names contain B followed by R or U
WHERE last_name REGEXP 'b[ru]'; -- last names contain B followed by R or U


 /*◾◾◾◾◾◾◾◾◾◾◾NULL OPERATOR ◾◾◾◾◾◾◾◾◾◾◾ 👇 */
SELECT *
FROM customers
WHERE phone IS NULL;

 /*◾◾◾◾◾◾◾◾◾◾◾ORDER BY Clause ◾◾◾◾◾◾◾◾◾◾◾ 👇 */
SELECT *
FROM customers
ORDER BY state DESC, first_name;

/* ◾◾◾🛑 NOT A GOOD PRACTICE◾◾◾◾◾◾◾◾ 
sorting data by column position produces unexpected results and should be avoid. ORDER BY 1, 2
ALWAYS SORT by column names*/

--  ⚡ Exercise
-- Sort all the order with id #2
-- and order them by total price in descending order 
SELECT * , quantity * unit_price AS total_price
FROM order_items 
WHERE order_id = 2
ORDER BY total_price DESC;

/*◾◾◾◾◾◾◾◾◾◾◾LIMIT ◾◾◾◾◾◾◾◾◾◾◾ 
limit the number of records returned by your query
❗❗❗❗❗ if the value we pass is greater than the number of columns in the query, we get ALL the data  👇 */
SELECT *
FROM customers
LIMIT 300;

/* ❗❗❗❗❗  we can optionally supply an OFFSET. 
useful in situations where we wan to paginate the data 👇 */
SELECT *
FROM customers
LIMIT 6, 3;

 --  ⚡ Exercise
 -- Get the top 3 loyal customers. Those who have more points than anyone else
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

/*◾◾◾◾◾◾◾◾◾◾◾INNER JOIN ◾◾◾◾◾◾◾◾◾◾◾ 👇 */
SELECT o.order_id, c.customer_id, c.first_name, c.last_name
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id;

SELECT o.order_id, c.customer_id, c.first_name, c.last_name
FROM orders o
JOIN customers c 
USING (customer_id);

 --  ⚡ Exercise
 -- Order_items table: join this table with the products table
 -- For each table return the product_id and its name, followed by the quantity and the unit_price in the orders table
 
 SELECT p.product_id, p.name, o.quantity, o.unit_price, (p.quantity_in_stock - o.quantity) AS quantity_left
 FROM order_items o
 JOIN products p
 USING (product_id);
 
 /*◾◾◾◾◾◾◾◾◾◾◾JOINING ACROSS DATABASES ◾◾◾◾◾◾◾◾◾◾◾ 👇 */
 --  ⚡ Exercise
 -- JOIN products table from sql_inventory databases with    from sql_store
 -- ❗❗❗❗❗ You only have to prefix the queries (specifying database_name.table_name) that are not part of the active database
 
SELECT * 
FROM order_items oi -- ❗❗❗❗❗ FROM contains the database that is active  
JOIN sql_inventory.products p -- JOIN from any other database
USING (product_id);

 /*◾◾◾◾◾◾◾◾◾◾◾SELF JOINS ◾◾◾◾◾◾◾◾◾◾◾
 JOIN a table with itself 👇 */
 USE sql_hr;
 
 SELECT e.employee_id, e.first_name AS employee, m.first_name AS manager
 FROM employees e
 JOIN employees m
    ON e.reports_to = m.employee_id;
 
 /*◾◾◾◾◾◾◾◾◾◾◾JOINING MULTIPLE TABLES◾◾◾◾◾◾◾◾◾◾◾ 👇 */
USE sql_store;

SELECT o.order_id, o.order_date, o.shipped_date, c.first_name, c.address, c.points, os.name AS 'order status'
FROM orders o
JOIN customers c
USING(customer_id)
JOIN order_statuses os
	ON o.status = os.order_status_id
WHERE os.name !=  'shipped' ;

 --  ⚡ Exercise
 -- sql_invoicing database
 -- JOIN payment table, payments_method table AND clients table
 -- show the name of the client and the payment method
 USE sql_invoicing;
 
 SELECT c.name, pm.name
 FROM payments p
 JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
 JOIN clients c
WHERE pm.name = 'cash' AND c.name REGEXP '^m';
-- ORDER BY c.name;
 -- LIMIT 3;
 
 /*◾◾◾◾◾◾◾◾◾◾◾COMPOUND JOIN CONDITIONS ◾◾◾◾◾◾◾◾◾◾◾ 
 A composite primary key contains more than one column
 when in a table you don't have a unique id 👇 */
 
 SELECT * 
 FROM order_items oi
 JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
	AND oi.product_id = oin.product_id; -- compound JOIN condition. Multiple conditions to join this 2 tables
    
 /*◾◾◾◾◾◾🛑 NOT A GOOD PRACTICE.  PROVOQUES CROSS JOIN
 ◾◾◾◾◾IMPLICIT JOIN SYNTAX ◾◾◾◾◾◾◾◾◾◾◾  👇 */    
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id; -- if you forget to  put the WHERE,tables are joined without a shared criteria

    
 /*◾◾◾◾◾◾OUTER JOINS ◾◾◾◾◾◾◾◾◾◾◾  👇 */   
 -- see all the customers even though they have an order or not
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
JOIN orders o 
	ON c.customer_id = o.customer_id -- this condition is not valid for those qho don't have an order
ORDER BY c.customer_id;
 
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o -- returns all the customers that is the table in the left
	ON c.customer_id = o.customer_id 
ORDER BY c.customer_id; 

/*◾◾◾◾◾◾🛑 NOT A GOOD PRACTICE TO USE RIGHT JOIN. 
makes code more difficult to read ◾◾◾◾◾◾◾◾◾◾◾  👇*/

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o -- returns all the orders that is the table in the right
	ON c.customer_id = o.customer_id 
ORDER BY c.customer_id;  
 
 
 --  ⚡ Exercise
 -- ❗❗❗❗❗ If we do a INNER JOIN we'll only see the products that are ordered
 
SELECT 
    p.product_id,
    p.name,
    oi.quantity AS quantity_orderded,
    (p.quantity_in_stock - oi.quantity) AS updated_stock
FROM products p
LEFT JOIN order_items oi 
	USING (product_id)
ORDER BY p.name;	    
 
 
/*◾◾◾◾◾◾OUTER JOINS BETWEEN MULTIPLE TABLES◾◾◾◾◾◾◾◾◾◾◾  👇 */   
SELECT customer_id,
	c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	USING (customer_id)
LEFT JOIN shippers sh
		USING (shipper_id)
ORDER BY c.customer_id;	   


 --  ⚡ Exercise
SELECT 
	o.order_id,
    o.order_date,   
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c -- every order has a customer so INNER JOIN works here
	USING (customer_id) -- USING when the value is identical
LEFT JOIN shippers sh 
	USING (shipper_id)
JOIN order_statuses os
	ON o.status = os.order_status_id;


/*◾◾◾◾◾◾SELF OUTER JOINS◾◾◾◾◾◾◾◾◾◾◾  👇 */   
-- get all employees and their manager, whether they have a manager or not
USE  sql_hr;

SELECT e.employee_id,  e.first_name, m.first_name AS manager
FROM employees e
LEFT JOIN employees m -- same table. differenet alias m for managers
	ON e.reports_to = m.employee_id;

/*◾◾◾◾◾◾the USING clause◾◾◾◾◾◾◾◾◾◾◾  👇 */   
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id);
 
--  ⚡ Exercise
-- sql_invoices
-- output: date, client, amount, name
-- on what date, who has paid, using what payment method
USE sql_invoicing;

SELECT c.name, p.date, p.amount, pm.name AS payment_method
FROM payments p
JOIN clients c
	USING (client_id)
LEFT JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id; 
 

/*◾◾◾◾◾◾🛑 NOT RECCOMMENDED
SOMETIME PRODUCES UNEXPECTED RESULTS
NATURAL JOINS◾◾◾◾◾◾◾◾◾◾◾  👇 */ 
USE sql_store;
SELECT o.order_id, c.first_name
FROM orders o
NATURAL JOIN customers c; -- it will join them based on the column columns, that have the same name  

/*◾◾◾◾◾◾CROSS JOINS◾◾◾◾◾◾◾◾◾◾◾  
used to combine every record from the 1st table with every record from the 2nd table 👇 */ 
SELECT c.first_name AS customer, p.name AS product
FROM customers c
CROSS JOIN 	products p -- explicit sintax  ❗❗❗❗❗ use this one. is more clear
ORDER BY c.first_name;

SELECT c.first_name AS customer, p.name AS product
FROM customers c, products p -- implicit sintax
ORDER BY c.first_name;


--  ⚡ Exercise
 -- do a CROSS JOIN between shippers and products
-- using the implicit syntax
-- and then using the explicit one

SELECT *
-- FROM shippers s, products p;
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name;

/*◾◾◾◾◾◾ UNION
combine ROWS from multiple tables◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
-- get all the orders
-- next to each order add a label 
-- if the order is placed in the current year, the label is active
-- if the order is placed in previous year, we'll label it as archived

SELECT order_id, order_date, 'Active' AS status
FROM orders 
WHERE order_date >= '2019-01-01' -- the hard coded method is not the best solution
UNION
SELECT order_id, order_date, 'Archived' AS status
FROM orders 
WHERE order_date < '2019-01-01';


/* ❗❗❗❗❗ The number of columns that you return should be equal, otherwise you get an error */

SELECT first_name -- whatever we have in the first query is going to name our column
FROM customers
UNION
SELECT name
FROM shippers;


--  ⚡ Exercise
-- 4 columns: customer id, first name, point, type

SELECT customer_id, first_name, points, 'Gold' AS type
FROM customers  
WHERE points > 3000 
UNION
SELECT customer_id, first_name, points, 'Silver' AS type
FROM customers 
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, points, 'Bronze' AS type
FROM customers 
WHERE points < 2000
ORDER BY first_name;

/*◾◾◾◾◾◾ COLUMN ATTRIBUTES
insert, update, delete data◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
/* ❗❗❗❗❗ for the id that is auto-generated, best practive to put DEFAULT so we let mySQL generate that value) */

INSERT INTO customers 
VALUES (DEFAULT, 'John', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT);


/* ❗❗❗❗❗ BEST PRACTICE  👇*/

INSERT INTO customers (first_name, last_name, birth_date, phone, address, city, state)
VALUES ('John', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA');

/*◾◾◾◾◾◾ INSERTING MULTIPLE ROWS◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
INSERT INTO customers (first_name, last_name, birth_date, phone, address, city, state)
VALUES ('Anna', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA'),
('Maria', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA'),
('Gaby', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA'),
('James', 'smith', '1990-01-01', NULL, 'address', 'city', 'CA');


/*◾◾◾◾◾◾ INSERTING HIERARCHICAL ROWS◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
-- An order can have one or more order items. PARENT-CHILD RELATIONSHIP
-- orders table is parent
-- order_items is a child

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);
-- in the table order_items we have the order_id column.
-- as soon as we insert an order, MySQL is going to generate an id for our new order
-- we need to be able to access that id inn order to insert the items in this table
-- BUILD-IN FUNCTIONS: LAST_INSERT_ID()
-- SELECT LAST_INSERT_ID() -- get the id of the newly inserted record

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,2.95),
	   (LAST_INSERT_ID(),2,1,3.95);


/*◾◾◾◾◾◾ CREATING A COPY OF A TABLE◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
/* ❗❗❗❗❗ when using this teqnique, MySQL ignores the primitive key and auto-incremented value*/

CREATE TABLE orders_archived AS
SELECT * FROM orders; -- 👉 SUBQUERY = a select statement that is a part of another SQL statement


/* ❗❗❗❗❗ Right click on the table orders_archived and choose TRUNCATE in order to delete all the data
let's say we want to copy all the orders palced before 1990 */

INSERT INTO orders_archived
-- subquery 👇
SELECT * 
FROM orders
WHERE order_date < '2019-01-01';


--  ⚡ Exercise
-- sql_invoicing database
-- invoices table
-- let's say we e¡want to create a copy of the records in this table and put them in a new table invoices_archived
-- in the table invoices_archived, instead of the client id column we want to have the client name column
-- you have to join this table with the cliednt table
-- then use that query as a subquery to create the table statment
-- also, copy only the invoices that have a payment

CREATE TABLE invoices_archived AS -- this cannot be executed 2 times 
SELECT 
    i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;


/*◾◾◾◾◾◾ UPDATING A SINGLE ROW◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
UPDATE invoices 
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;

/*◾◾◾◾◾◾ AFTER UPDATING,  RESTORING TO ITS ORIGINAL VALUE◾◾◾◾◾◾◾◾◾◾◾ 👇 */ 
UPDATE invoices 
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;

-- for invoice id  3, the client made a 50% payment on the due date
UPDATE invoices 
SET 
    payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id = 3; -- data truncated


/*◾◾◾◾◾◾ UPDATING MULTIPLE ROWS◾◾◾◾◾◾◾◾◾◾ 👇 */
UPDATE invoices 
SET  payment_total = invoice_total * 0.5,
     payment_date = due_date
WHERE client_id = 1;


UPDATE invoices 
SET  payment_total = invoice_total * 0.5,
     payment_date = due_date
WHERE client_id IN (3,4);


--  ⚡ Exercise
-- write a SQL statement to
-- give any customers born before 1990
-- 50 extra points

USE sql_store; 

UPDATE customers
SET points = points + 50
WHERE birth_date > '1990-01-01';


/*◾◾◾◾◾◾ USING SUBQUERIES IN UPDATES ◾◾◾◾◾◾◾◾◾◾ 👇 */

UPDATE invoices 
SET  payment_total = invoice_total * 0.5,
     payment_date = due_date
WHERE client_id = 
-- a subquery is a select statement that is in a SQL statement
		(SELECT client_id
		FROM clients
		WHERE name = 'Myworks');

-- update the invoices for all clients located in New York or California

UPDATE invoices 
SET  payment_total = invoice_total * 0.5,
     payment_date = due_date
WHERE client_id IN -- when the where in the subquey has more than 1 condition
-- a subquery is a select statement that is in a SQL statement
		(SELECT client_id
		FROM clients
		WHERE state IN ('CA', 'NY'));

/* ❗❗❗❗❗ BEST PRACTISE: run the subquery before the update so you make sure you are updating the corerct fields*/


--  ⚡ Exercise
-- sql_store
-- orders table, some of the orders don't have a comment
-- update that comments for orders for customers who have > 3000 points
-- they are gold customers. 
-- find their order
-- update their comments column i¡and set it to Gold Customers
UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
	(SELECT customer_id
	FROM customers
	WHERE points > 3000);


/*◾◾◾◾◾◾ DELETING ROWS ◾◾◾◾◾◾◾◾◾◾ 👇 */

DELETE FROM invoices -- deletes all the records
-- better to use where, even though it's optional
WHERE client_id = 
	(SELECT *
	FROM clients 
	WHERE name = 'Myworks');


/*◾◾◾◾◾◾ RESTORING THE DATABASES ◾◾◾◾◾◾◾◾◾◾ 👇 */









