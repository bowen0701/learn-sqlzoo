/* Reference 3. INSERT and DELETE Reference

How to put records into a table, change them and how to take them out again. */

/* INSERT new records */
INSERT INTO t_peep VALUES (1, 'andrew');
INSERT INTO t_peep VALUES (2, 'gordon');

SELECT * FROM t_peep

/* UPDATE existing records */
UPDATE t_peep
  SET id = 39, name = 'Andy'
  WHERE id = 1;

SELECT * FROM t_peep

/* DELETE records */
DELETE FROM t_peep
WHERE id = 2;

SELECT * FROM t_peep

/* INSERT ... SELECT
'INSERT..SELECT' copies data from a SELECT into a table. */
INSERT INTO t_peep
  SELECT population, name FROM world
  WHERE region = 'Europe';

SELECT * FROM t_peep

/* INSERT: Not all fields need to be specified
INSERT: Not all fields need be specified. 
Default values may be specified in the CREATE TABLE clause - 
otherwise NULL is used. */
INSERT INTO t_peep (id) VALUES (99);

SELECT * FROM t_peep

/* INSERT a date */
CREATE TABLE t_date (
  x VARCHAR(5), 
  y DATE);

INSERT INTO t_date VALUES ('Ryka', '1997-03-01');
INSERT INTO t_date VALUES ('Impos', '1997-09-30');

SELECT * FROM t_date

/* Explicitly enter a NULL */
INSERT INTO t_peep VALUES (4677, NULL);

SELECT * FROM t_peep

/* INSERT problems: reference
Can't INSERT because of reference.

If a foreign key is set up between two tables it may be that you 
cannot insert unless a related record exists. In this example we 
cannot add ('Tom', 'ma') to t_staff table unless we first create a 
maths department ('ma', 'Mathematics') in the t_dept table.*/
CREATE TABLE t_dept (
  id CHAR(2) PRIMARY KEY,
  fname VARCHAR(20));

CREATE TABLE t_staff (
  name VARCHAR(20) PRIMARY KEY,
  dept CHAR(2) FOREIGN KEY REFERENCES t_dept(id));

INSERT INTO t_dept VALUES ('co', 'Computing');
INSERT INTO t_dept VALUES ('ma', 'Mathematics');

INSERT INTO t_staff VALUES ('andrew', 'co');
INSERT INTO t_staff VALUES ('tom', 'ma');

SELECT * FROM t_staff

/* DELETE problems: reference
Cannot DELETE because of reference.

If a foreign key is set up between two tables it may be that you 
cannot delete a record. In this case the table t_staff references the 
table t_dept - you cannot delete the department 'co' if a member of staff
belongs to that department. */
DELETE FROM t_staff WHERE name = 'andrew';
DELETE FROM t_dept WHERE id = 'co';

SELECT * FROM t_dept

/* INSERT problems: incompatible formats
Can't insert data because of incompatable formats.

If the data inserted is of the wrong type the insert may fail. 
Because the date format may depend on the local settings this may 
cause confusion. Using a 4 digit year and a three character month works
for most systems (in English speaking regions). */
CREATE TABLE t_x (
  x VARCHAR(5), 
  y DATE);

INSERT INTO t_x VALUES ('abcdf', NULL);
INSERT INTO t_x VALUES ('ambig', '2010-11-12');
INSERT INTO t_x VALUES ('unamb', '2012-11-12');

SELECT * FROM t_x

/* String contains a quote ' */
INSERT INTO t_q VALUES ('O''KKK');

SELECT * FROM t_q

/* Data normalization
To select the data from 20 different columns into one changing the values 
according to one other column consisting the positions of the 20 columns.

Sometimes we have un-normailsed data that we want to normalise. 
Suppose we have data in 20 columns F1 to F20:

Line    F1    F2   F3   F4 ...
------------------------------
A       11    10   13   15 ...
B       20    22   23   28 ...

But we want a table that has just one data column. Like this...

Line   Col   Val
----------------
A      1     11
A      2     10
A      3     13
A      4     15
...
B      1     20
B      2     22
B      3     23
B      4     28
...

You can use INSERT ... SELECT ... statement. */
-- Create the good table
CREATE TABLE normal (
  line CHAR(1), 
  col INTEGER, 
  val INTEGER,
  PRIMARY KEY (Line, col) );

-- Copy the data into it
INSERT INTO normal (line, col, val)
  SELECT line, 1, F1 FROM unnormal
UNION
  SELECT line, 2, F2 FROM unnormal
UNION
  SELECT line, 3, F3 FROM unnormal
UNION
  SELECT line, 4, F4 FROM unnormal;

SELECT * FROM normal




