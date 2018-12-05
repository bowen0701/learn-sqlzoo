/* Reference 1. Select */

/* SELECT Operations */
SELECT name, population
FROM bbc
WHERE region='North America'

/* Concatenate Columns
You can put two or more strings together using the concatenate operator.

The SQL standard says you should use || but there are many differences 
between the main vendors. */
SELECT CONCAT(region, name)
FROM bbc

/* Like
The LIKE command allows "Wild cards". 
- % may be used to match and string, 
- _ will match any single character.
The example shows countries begining with Z. 
The country Zambia matches because ambia matches with the %. */
SELECT name 
FROM bbc
WHERE name LIKE 'Z%'

/* Union
Make union between different tables to build one single view or request?

List a number of SELECT statements separated by the UNION key word. 
Be sure that you have the same number of columns in each of the 
SELECT statements. */
SELECT name FROM bbc WHERE name LIKE 'Z%'
UNION
SELECT name FROM actor WHERE name LIKE 'Z%'

/* Apostrophe
How to build a statement on a word with an Apostrophe such as 
WHERE name = 'Cote d''Ivoire' */
SELECT * 
FROM bbc
WHERE name = 'Cote d''Ivoire'

/* Full text search
The "brute force" method is to use use the LIKE operator against any 
of the fields to be searched. This will be relatively expensive - 
but probably good enough in many cases. The term to search for should 
be quoted and placed within two wild cards.
You should construct the string literal in some scripting language - 
don't forget to quote it. */
SELECT name 
FROM bbc
WHERE name LIKE '%the%'

/* Column name
How can I display a column name for an aggregate function?

Where one of the results returned is calculated (for example with an 
aggregate) the column name may be assigned arbitrarily.
You should be able to specify a column name. */
SELECT region, SUM(population) AS sum_pop
FROM bbc
GROUP BY region

/* Equi Join
How do you use Equi Join to join two tables with the same name?
I am trying to join two tables with the same name. 
I am required to use an inner join Also I need to show the managers name. 
Question is: Join the employee table with the employee table and department 
table. Show the employee id, name, dept code, manager id, manager name, 
managers department code, and name for that (mgr's) department.

We have a self join, each copy of the table is given an "alias" - 
here we use w for the worker and b for the boss. We can treat these as 
different tables. You get an inner join by default - this means that Robin 
(who has no boss) does not show up in the results. */
CREATE TABLE employee(
  employee_id INTEGER PRIMARY KEY,
  first_name VARCHAR(10),
  dept_code VARCHAR(10),
  manager_id INTEGER REFERENCES employee);

INSERT INTO employee VALUES (1, 'Robin', 'Eng', NULL);
INSERT INTO employee VALUES (2, 'Jon', 'SoC', 1);
INSERT INTO employee VALUES (3, 'Andrew', 'SoC', 2);
INSERT INTO employee VALUES (4, 'Alison', 'SoC', 2);

SELECT 
  w.employee_id AS worker_id, 
  w.first_name AS worker,
  w.dept_code AS worker_dept,  
  b.employee_id AS boss_id,
  b.first_name AS boss,
  b.dept_code AS boss_dept
FROM employee w JOIN employee b
ON w.manager_id = b.employee_id

/* Column name with spaces
SELECT a column whose name contains spaces? Use back ticks. */
CREATE TABLE space_monster(
  `Account Balance` INT);

INSERT INTO space_monster VALUES (42);

SELECT `Account Balance` FROM space_monster

/* NULL 
The NULL value may be used to indicate missing or unknown data. 
You can use the phrase IS NULL to select these values. */
SELECT name, gdp
FROM world
WHERE gdp IS NULL
