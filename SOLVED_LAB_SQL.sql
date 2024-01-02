-- ## Challenge - Joining on multiple tables

-- Write SQL queries to perform the following tasks using the Sakila database:


-- 1. List the number of films per category.
-- 2. Retrieve the store ID, city, and country for each store.
-- 3.  Calculate the total revenue generated by each store in dollars.
-- 4.  Determine the average running time of films for each category.


-- **Bonus**:

-- 5.  Identify the film categories with the longest average running time.
-- 6.  Display the top 10 most frequently rented movies in descending order.
-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a `CASE` statement combined with `IFNULL`."

-- Here are some tips to help you successfully complete the lab:

-- ***Tip 1***: This lab involves joins with multiple tables, which can be challenging. Take your time and follow the steps we discussed in class:

-- - Make sure you understand the relationships between the tables in the database. This will help you determine which tables to join and which columns to use in your joins.
-- - Identify a common column for both tables to use in the `ON` section of the join. If there isn't a common column, you may need to add another table with a common column.
-- - Decide which table you want to use as the left table (immediately after `FROM`) and which will be the right table (immediately after `JOIN`).
-- - Determine which table you want to include all records from. This will help you decide which type of `JOIN` to use. If you want all records from the first table, use a `LEFT JOIN`. If you want all records from the second table, use a `RIGHT JOIN`. If you want records from both tables only where there is a match, use an `INNER JOIN`.
-- - Use table aliases to make your queries easier to read and understand. This is especially important when working with multiple tables.
-- - Write the query

-- ***Tip 2***: Break down the problem into smaller, more manageable parts. For example, you might start by writing a query to retrieve data from just two tables before adding additional tables to the join. Test your queries as you go, and check the output carefully to make sure it matches what you expect. This process takes time, so be patient and go step by step to build your query incrementally.



-- 1. List the number of films per category.

SELECT category_id, COUNT(*) AS number_of_films_per_category
FROM sakila.film_category
GROUP By category_id;



-- 2. Retrieve the store ID, city, and country for each store.

USE sakila;

SELECT s.store_id, ci.city, co.country
FROM store s
LEFT JOIN address a ON a.address_id = s.address_id
LEFT JOIN city ci ON ci.city_id = a.city_id
LEFT JOIN country co ON co.country_id = ci.country_id;


-- 3.  Calculate the total revenue generated by each store in dollars.

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
LEFT JOIN customer c ON c.store_id = s.store_id
LEFT JOIN payment p ON p.customer_id = c.customer_id
GROUP BY s.store_id;


-- 4.  Determine the average running time of films for each category

SELECT fi.category_id, AVG(f.length) AS average_running_time
FROM film_category fi
JOIN film f ON f.film_id = fi.film_id
GROUP BY fi.category_id;

-- 5.  Identify the film categories with the longest average running time.

SELECT fi.category_id, MAX(AVG(f.length)) AS average_running_time
FROM film_category fi
JOIN film f ON f.film_id = fi.film_id
GROUP BY fi.category_id;

-- 6.  Display the top 10 most frequently rented movies in descending order.

SELECT title, COUNT(*) AS most_frequent_rentals
FROM sakila.film
GROUP BY title
ORDER BY most_frequent_rentals DESC
LIMIT 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.

-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a `CASE` statement combined with `IFNULL`."
