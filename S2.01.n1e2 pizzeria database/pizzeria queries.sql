-- pizzeria queries

-- list how many products of beverage category were sold in a given store
SELECT p.name, p.type, o.date_time AS 'date order made', e.store_id AS 'store id' FROM product p join orders o on o.product_id = p.id join employee e on o.employee_store_id = e.store_id WHERE e.store_id = 1 AND type = 'drink' group by p.name, o.date_time, e.store_id order by p.name;

-- list how many orders have been placed by an employee
SELECT name_first, name_last, store_id, date_time, delivery_pickup FROM employee e JOIN orders o ON e.id = employee_id WHERE e.id = 1;