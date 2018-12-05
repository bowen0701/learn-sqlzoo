/* Reference 3. CREATE and DROP Reference */

/* CREATE a new table

The following are examples of field types:

INTEGER	A whole number
VARCHAR(10)	Up to 10 characters.
CHAR(10)	Fixed number of characters
DATE	A date
TIMESTAMP	Date and time
FLOAT	Floating point numbers */
CREATE TABLE t_test (
  a INTEGER PRIMARY KEY,
  b VARCHAR(10));

INSERT INTO t_test VALUES (1, 'Bowen');

SELECT * FROM t_test


/* DROP a table
Naturally, all of the data in the table is lost when the table is dropped.

Foreign Key references can cause problems. */
DROP TABLE t_test


/* Composite primary key
CREATE TABLE with a composite primary key

A composite key has more than one attribute (field). 
In this example we store details of tracks on albums - 
we need to use three columns to get a unique key - 
each album may have more than one disk - 
each disk will have tracks numbered 1, 2, 3...

The primary key must be different for each row of the table. 
The primary key may not contain a null. */
CREATE TABLE track (
  album CHAR(10) NOT NULL,
  dsk INTEGER NOT NULL,
  posn INTEGER NOT NULL,
  song VARCHAR(255),
  PRIMARY KEY (album, dsk, posn))


/* CREATE a foreign key: 
Ref: https://www.w3schools.com/sql/sql_foreignkey.asp */
CREATE TABLE orders (
  order_id int NOT NULL PRIMARY KEY,
  order_number int NOT NULL,
  person_id int FOREIGN KEY REFERENCES persons(person_id);


/* CREATE a VIEW.
A view is a named SELECT statement.

In this example we show only European countries, we also show the 
population in millions.

Note how the columns of the table may be named. */
CREATE VIEW v_europe AS
  SELECT 
    name,
    population AS pop
  FROM world 
  WHERE region = 'Europe';

SELECT * FROM v_europe


/* Autonumber fields
CREATE a table with an autonumber / sequence / identity / autoincrement

An auto number field can provide a unique identifier where no other is 
available. */
CREATE TABLE t_test (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(10));

INSERT INTO t_test(name) VALUES ('Andrew');
INSERT INTO t_test(name) VALUES ('Gordon');

SELECT * FROM t_test


/* ALTER TABLE ... ADD COLUMN
Add a column to a table

This is in the SQL standard ALTER TABLE The term COLUMN is optional. */
ALTER TABLE a ADD COLUMN z INTEGER;

SELECT * FROM a


/* ALTER TABLE ... DROP COLUMN */
ALTER TABLE a DROP COLUMN y;

SELECT * FROM a


/* We can add a constraint
- a foreign key reference
- a UNIQUE requirement
- a CHECK constraint
This is in the SQL standard ALTER TABLE */
ALTER TABLE a ADD CHECK (y > 2);

SELECT * FROM a


/* CREATE TABLE problems: Table already exists.

When developing table definitions it may be useful to precede a 
sequence of CREATE TABLE statements with the corresponding 
DROP TABLE statements in the reverse order (see next tip). */
CREATE TABLE IF NOT EXISTS
  t_holiday (a INTEGER);

SELECT * FROM t_holiday


/* CREATE TABLE problems: Foreign key references.

A foreign key should refer to a candidate key in some table. 
This is usually the primary key but may be a field (or list of fields) 
specified as UNIQUE.

You must have REFERENCE permission on the table being referenced. */
CREATE TABLE customer (
  id INTEGER PRIMARY KEY,
  name VARCHAR(100));

CREATE TABLE invoice (
   cust_no INTEGER,
   whn DATE,
   amt DECIMAL(10,2),
   FOREIGN KEY(cust_no) REFERENCES customer(id));

INSERT INTO customer VALUES (101, 'Arnold Anxious');
INSERT INTO invoice VALUES (101, '2014-08-21', 42.00);

SELECT *
FROM invoice JOIN customer 
ON invoice.cust_no = customer.id


/* Rename column */
CREATE TABLE a (x INTEGER);
INSERT INTO a VALUES (2);
ALTER TABLE a CHANGE x y INTEGER;
SELECT * FROM a
