-- FIXED /* joins: select all the computers from the products table:
/* using the products table and the categories table, return the product name and the category name */
SELECT prod.name AS "Product Name", cat.name AS "Category Name"
FROM products AS prod
LEFT JOIN categories AS cat -- Is this the same as a natural join?
ON cat.CategoryID = prod.CategoryID
WHERE cat.Name = "Computers"
ORDER BY prod.name;
 
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT prod.name AS Name, prod.price AS Price, rev.rating AS Rating
FROM products AS prod
LEFT JOIN reviews AS rev
ON prod.ProductID = rev.ProductID
WHERE rev.Rating = 5
ORDER BY prod.name;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
-- FIXED - I used Amorriss' 2nd example.
SELECT CONCAT(emp.firstname, " ", emp.LastName) AS "Name", SUM(sales.Quantity) AS "Quantity"
FROM sales
INNER JOIN employees AS emp ON emp.EmployeeID = sales.EmployeeID
GROUP BY emp.EmployeeID
HAVING Quantity = (SELECT (SUM(sales.Quantity)) AS MOST FROM sales GROUP BY sales.EmployeeID ORDER BY MOST DESC LIMIT 1);

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT dept.Name AS "Department Name", cat.Name AS "Category Name"
FROM departments AS dept
JOIN categories AS cat
ON cat.DepartmentID = dept.DepartmentID
WHERE cat.Name = 'Appliances' OR cat.Name = 'Games';

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT prod.Name AS "Name", SUM(sales.Quantity) AS "Quantity Sold", SUM(sales.PricePerUnit * sales.quantity) AS "Total Price of Units Sold"
 FROM sales
 JOIN products AS prod
 ON prod.productID = sales.ProductID
 WHERE prod.Name = "Eagles: Hotel California"
 GROUP BY prod.Name;
 
/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
 SELECT prod.Name AS "Product Name", reviews.reviewer AS "Reviewer", reviews.rating AS "Lowest Rating", reviews.comment AS "Snarky Comment"
 FROM reviews
 JOIN products AS prod
 ON prod.ProductID = reviews.ProductID
 WHERE prod.name = "Visio TV" AND reviews.Rating = 1
 HAVING "Snarky Comment" = (SELECT (SUM(reviews.Comment)) AS MOST FROM reviews GROUP BY reviews.rating ORDER BY MOST DESC LIMIT 1);

-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */
SELECT emp.EmployeeID, CONCAT(emp.FirstName, " ", emp.LastName) AS Name, 
	   products.name "Product Name", sales.quantity AS "Quantity Sold"
FROM employees AS emp
JOIN sales
ON emp.EmployeeID = sales.EmployeeID
JOIN products
ON products.ProductID = sales.ProductID
ORDER BY Name;
