-- optics queries

-- customer total invoices in a given period
SELECT c.name, total_price, date_sales FROM customer c JOIN sales s ON c.id = customer_id WHERE date_sales BETWEEN '2020-01-01' AND '2021-12-31';

-- different makes sold by employee in 1 year
SELECT e.name AS 'employee name', total_price, date_sales, g.make FROM employee e JOIN sales s ON e.id = employee_id JOIN glasses g ON s.glasses_id = g.id WHERE date_sales BETWEEN '2021-01-01' AND '2021-12-31';

-- list different suppliers of glasses sold successfully
SELECT date_sales, make, sup.name AS 'supplier name' FROM sales s JOIN glasses g ON s.glasses_id = g.id JOIN orders o ON o.glasses_id = g.id JOIN supplier sup ON o.supplier_id = sup.id;

