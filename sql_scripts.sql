/* SQL Scripts */

/* Show, create and drop database / table / view. */
SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS my_database;
    CHARACTER SET utf8
    COLLATE utf8_general_ci;
SHOW WARNINGS; 

DROP DATABASE IF EXISTS my_database;

SHOW TABLES;

CREATE TABLE IF NOT EXISTS my_table (
	id TEXT PRIMARY KEY,
	name TEXT,
	country TEXT,
);

SHOW COLUMNS FROM my_table;

DROP TABLE IF EXISTS my_table;

DROP VIEW IF EXISTS tview_my_view;
CREATE VIEW tview_my_view AS (
SELECT * FROM my_table
);

/* CRUD: create, read, update, and delete. */
INSERT INTO my_table (id, name) VALUES ('1', 'The First');
INSERT INTO my_table VALUES (...);

SELECT * FROM my_table WHERE id = '1';
SELECT name FROM my_table WHERE id = '1';

UPDATE my_table SET id = '10' WHERE id = '1';

DELETE FROM my_table WHERE id = '10';


/* 
Normalizing databases: 3NF is the standard.

- 1st normal form (1NF): A single value for each field.
- 2nd normal form (2NF): 
  * Must be in 1NF.
  * Fields not defining a row depend on field do.
- 3rd normal form (#NF):
  * Must be in 2NF.
  * All the fields are determined only by the candidate keys 
    of that table and not by any non-prime fields. 
*/

/* OLAP: Online Analytical Processing. */


/* 
Index for optimizing query:

- Principle: B+ Tree: https://en.wikipedia.org/wiki/B%2B_tree
- Speed up sorting
- Like Hauffman Tree: https://en.wikipedia.org/wiki/Huffman_coding
- Key concept: Reduce disk I/O
- Set index by creating a B+ tree:
  * internal nodes: keys & links 
  * leaves: keys, data & link
  * Must: unique key, not containing duplicates
- Secondary key: Used for often query in "WHERE", combining Primary Key
- Set keys will
  * Take up disk space
  * INSERT / UPDATE / DELETE will take longer time due to re-creating key tree
- Set column with large cardinality
- Rules:
  * Use leftmost prefix
  * Will not use index columns after first range scan column; use BETWEEN / IN
  * Will note use index if put in function 
*/
CREATE TABLE table {
  last_namec varchar(50) not null,
  first_name varchar(50) not null,
  birthday date not null,
  gender enum('m', 'f') not null,
  key(last_name, first_name, birthday)
};

EXPLAIN SELECT * FROM table

SHOW INDEX FROM emplyees.titles

