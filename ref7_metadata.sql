/* Metadata */

/* What are my tables?
Get a list of all tables

We should expect to find a system table that includes a list of tables. 
We should expect this to contain a great deal of extra data that is 
hard to understand. */
SHOW TABLES


/* What are the columns of the bbc table */
SHOW COLUMNS FROM bbc


/* LIMIT
Get the first 10 rows of the bbc table. */
SELECT * FROM bbc LIMIT 10


/* Get the 11th to the 20th rows of the bbc table - by population. */
SELECT * 
FROM bbc
ORDER BY population DESC
LIMIT 11, 20


/* What version of the software am I using?
Many implementations of SQL are being developed continuously and 
new releases are common. Usually there is a version number. */
SELECT VERSION()


/* How can you determine the primary key using SQL?
If you have access to the SQL code which created the table the 
primary key can be seen easily. 
The primary key may be specified in one of two ways:

CREATE TABLE cia (
  name VARCHAR(10) PRIMARY KEY,
  population INTEGER)

or, where the primary key is composite, as example.

If this is not possible then implementation specific commands may work. */
CREATE TABLE casting (
  movieid INTEGER,
  actorid INTEGER,
  PRIMARY KEY (movieid, actorid));

DESCRIBE casting


/* Return a sequential record count for all records returned
this should be simple - I would like to get a consecutive numbering 
count/id for each record returned from a query: eg: 
select * from tablex gives multiple rows like:

field1, field2, field3, ...
field1, field2, field3, ...
field1, field2, field3, ...
What I want is:

1, field1, field2, field3, ...
2, field1, field2, field3, ...
3, field1, field2, field3, ...
4, field1, field2, field3, ... */
DROP TABLE numbered_bbc;

CREATE TABLE numbered_bbc (
  counter INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  region VARCHAR(60),
  area DECIMAL(10, 0),
  population DECIMAL(11, 0),
  gdp DECIMAL(14, 0));

INSERT INTO numbered_bbc (
  counter, name, region, area, population, gdp)
    SELECT name, region, area, population, gdp
    FROM gisq.bbc;

SELECT * FROM numbered_bbc
