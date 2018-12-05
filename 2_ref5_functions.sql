/* Reference 5. Functions Reference */

/* Concatenate strings.

Concatenation means "stick strings together". 
In this example we concatenate three strings, name and region are string 
attributes of the table, ' is in ' is a string literal. */
SELECT CONCAT(name, ' is in ', region)
FROM bbc
WHERE name LIKE 'D%'


/* SUBSTR
SUBSTR allows you to extract part of a string.

   SUBSTR('Hello world', 2, 3) -> 'ell'    

In this example you get the 2nd to 5th character from each country's name. */
SELECT 
  name, SUBSTR(name, 2, 5)
FROM bbc


/* Substring: Extracting part of a string (Not recommended.)

We from position 1 (the beginning) we take two characters. 4.

'Afghanistan' -> 'Af'
'China'       -> 'Ch'
'Sri Lanka'   -> 'Sr'
The SQL standard insists on a horrible syntax:

SUBSTRING(name FROM 1 FOR 2) */
SELECT name, SUBSTRING(name FROM 1 FROM 2)
FROM bbc


/* Finding a substring in a string

Here we extract the first word of a country name. 
POSITION gives this position of one string within another, 
we use this and substring to pick out the first few characters. */
SELECT name,
  POSITION(' ' IN name) AS pos_space,
  SUBSTRING(name FROM 1 FOR POSITION(' ' IN name)) AS sub_str
FROM bbc
WHERE name LIKE '% %'


/* LOWER CASE & UPPER CASE */
SELECT LOWER(name) 
FROM bbc
WHERE UPPER(region) = 'SOUTH AMERICA'


/* Formatting numbers to two decimal places.

This rounds up or down. */
SELECT 
  name,
  population,
  ROUND(population / 1000000, 2),
  ROUND(population, -6)
FROM bbc
WHERE region='North America'


/* Replace a NULL with a specific value

The SQL standard is COALESCE */
SELECT 
  code, 
  name,
  COALESCE(leader, 'NO LEADER')
FROM party


/* Conditional values

The SQL Standard is the CASE statement. */
SELECT
  title, 
  yr,
  CASE WHEN yr > 2000 THEN 'NEW'
    ELSE 'OLD'
  END AS age_cat
FROM movie


/* Get the current date and/or time

SQL Standard specifies CURRENT_TIMESTAMP, CURRENT_DATE and CURRENT_TIME. 
These are widely ignored :( */
SELECT CURRENT_TIMESTAMP, CURRENT_DATE, CURRENT_TIME


/* Format a date and time.

Many engines support the SQL standard - see Mimer for details. */
SELECT DATE_FORMAT(wk, '%d/%m/%Y'), song
FROM totp
WHERE singer = 'Tom Jones'


/* SQL Functions */


/* CURRENT_TIMESTAMP
CURRENT_TIMESTAMP returns the current date and time.

 CURRENT_TIMESTAMP -> '2006-12-31 18:03:44'  */
SELECT CURRENT_TIMESTAMP, whn
FROM eclipse



/* CASE
CASE allows you to return different values under different conditions.

If there no conditions match (and there is not ELSE) then NULL is returned.

  CASE WHEN condition1 THEN value1 
       WHEN condition2 THEN value2  
       ELSE def_value 
  END */
SELECT 
  name, 
  population,
  CASE WHEN population < 1000000 THEN 'small'
       WHEN population < 10000000 THEN 'medium'
       ELSE 'large'
  END AS size
FROM bbc


/* ROUND
The number of decimal places may be negative, this will round to the 
nearest 10 (when p is -1) or 100 (when p is -2) or 1000 (when p is -3) etc.

ROUND(7253.86, 0)    ->  7254
ROUND(7253.86, 1)    ->  7253.9
ROUND(7253.86,-3)    ->  7000

In this example we calculate the population in millions to 
one decimial place. */
SELECT 
  name, ROUND(population / 1E6, 1)
FROM bbc 

/* ABS
ABS returns the absolute value. 
The output is positive even if the input is negative:

ABS(x) = x if x>=0
ABS(x) = -x if x<0

ABS can be useful for testing values that are "close". 
For example this query shows each country that has area that is roughly 
70 thousand. The value 70000 is the target value, 
500 is the "tolerance" so the test ABS(area-70000)<500 tests that the area is 
between 70000-500 and 70000+500. That is 69500<area<70500 */
SELECT name, area
FROM bbc
WHERE ABS(area - 70000) < 500


/* CAST
CAST allows you to convert from one type to another.

Often a CAST is implicit - for example if you concatenate a string 
with a number the number will be automatically changed to a string. 
However sometimes you need to make the CAST explicit.

 CAST(expr TO type) */
SELECT
  CAST(population / 1E6 AS DECIMAL(8, 1)) AS a,
  population / 1E6 AS b
FROM bbc


/* CONCAT
CONCAT allows you to stick two or more strings together.
This operation is concatenation.

   CONCAT(s1, s2 ...). */
SELECT CONCAT(region, name) AS region_name
FROM bbc


/* DIV
a DIV b returns the integer value of a divided by b.

   8 DIV 3 -> 2

In this example we calculate the population in millions. */
SELECT name, population DIV 1E6
FROM bbc


/* MOD
MOD(a,b) returns the remainder when a is divied by b

If you use MOD(a, 2) you get 0 for even numbers and 1 for odd numbers.

If you use MOD(a, 10) you get the last digit of the number a.

 MOD(27,2) ->  1
 MOD(27,10) ->  7 */
SELECT 
  MOD(yr, 10) AS yr_mod, yr, city
FROM games


/* % (Modulo)
a % b returns the remainder when a is divied by b

If you use a % 2 you get 0 for even numbers and 1 for odd numbers.

If you use a % 10 you get the last digit of the number a.

 27 % 2  ->  1
 27 % 10 ->  7 */
SELECT yr % 10, yr, city
FROM games


/* LEFT
LEFT(s,n) allows you to extract n characters from the start of the 
string s.

   LEFT('Hello world', 4) -> 'Hell' */
SELECT 
  name, LEFT(name, 3)
FROM bbc


/* RIGHT
RIGHT(s,n) allows you to extract n characters from the end 
of the string s.

   RIGHT('Hello world', 4) -> 'orld' */
SELECT 
       name, RIGHT(name, 3)
FROM bbc


/* LEN
LEN(s) returns the number of characters in string s.

    LEN('Hello') -> 5 */
SELECT 
  name, LEN(name)
FROM bbc


/* LENGTH
LENGTH(s) returns the number of characters in string s.

    LENGTH('Hello') -> 5 */
SELECT 
  name, LENGTH(name)
FROM bbc


/* REPLACE
REPLACE(f, s1, s2) returns the string f with all occurances of s1 
replaced with s2.

 REPLACE('vessel','e','a') -> 'vassal' 

In this example you remove all the 'a's from the name of each country. 
This happens because the string 'a' is replaced with. */
SELECT name, REPLACE(name, 'a', '')
FROM bbc


/* TRIM
TRIM(s) returns the string with leading and trailing spaces removed.

   TRIM('Hello world  ') -> 'Hello world'

This function is particularly useful when working with CHAR fields. 
Typically a CHAR field is paddded with spaces. 
In contrast a VARCHAR field does not require padding. */
SELECT 
  name, TRIM(name)
FROM bbc


/* CEIL
CEIL(f) is ceiling, it returns the integer that is equal to or just 
more than f

CEIL(f) give the integer that is equal to, or just higher than f. 
CEIL always rounds up.

 CEIL(2.7)  ->  3
 CEIL(-2.7) -> -2 */
SELECT 
  population / 1E6 AS a,
  CEIL(population / 1E6) AS b
FROM bbc


/* FLOOR
FLOOR(f) returns the integer value of f

FLOOR(f) give the integer that is equal to, or just less than f. 
FLOOR always rounds down.

  FLOOR(2.7) ->  2
  FLOOR(-2.7) -> -3

In this example we calculate the population in millions. */
SELECT name, FLOOR(population / 1E6)
FROM bbc


/* SIN 
SIN(f) returns the sine of f where f is in radians.

  SIN(3.14159/6) -> 0.5  

In this example you return the sine of each of the angles. */
SELECT id, angle, SIN(angle)
FROM angle


/* COS
COS(f) returns the cosine of f where f is in Degrees.

  COS(3.14159/3) -> -1.0 */
SELECT id, angle, COS(angle)
FROM angle


/* TAN
TAN(f) returns the tangent of f where f is in radians.

  TAN(3.14159/4) -> 1 

In this example you return the tangent of each of the angles. */
SELECT id, angle, TAN(angle)
FROM angle


/* COALESCE
COALESCE takes any number of arguments and returns the first value that 
is not null.

  COALESCE(x, y, z) = x if x is not NULL
  COALESCE(x, y, z) = y if x is NULL and y is not NULL
  COALESCE(x, y, z) = z if x and y are NULL but z is not NULL
  COALESCE(x, y, z) = NULL if x and y and z are all NULL */
SELECT name, party, COALESCE(party, 'None') AS aff
FROM msp 
WHERE name LIKE 'C%'


/* IFNULL
IFNULL takes two arguments and returns the first value that is not null.

  IFNULL(x,y) = x if x is not NULL
  IFNULL(x,y) = y if x is NULL */
SELECT 
  name, 
  party,
  IFNULL(party, 'None') AS aff
FROM msp 
WHERE name LIKE 'C%'


/* NULLIF
NULLIF returns NULL if the two arguments are equal; otherwise NULLIF 
returns the first argument.

   NULLIF(x,y) = NULL if x=y
   NULLIF(x,y) = x if x != y

NULLIF can be used to replace a specific value with NULL. 
In this example the party Lab is replaced with NULL. */
SELECT name, party, NULLIF(party, 'Lab') AS aff
FROM msp
WHERE name LIKE 'C%'


/* NVL
NVL takes two arguments and returns the first value that is not null.

   NVL(x,y) = x if x is not NULL
   NVL(x,y) = y if x is NULL */
SELECT 
  name, party, NVL(party, 'None') AS aff
FROM msp 
WHERE name LIKE 'C%'


/* INSTR
INSTR(s1, s2) returns the character position of the substring s2 
within the larger string s1. The first character is in position 1. 
If s2 does not occur in s1 it returns 0.

    INSTR('Hello world', 'll') -> 3 

In this example you get the position of string 'an' 
within a country's name. */
SELECT 
  name, INSTR(name, 'an')
FROM bbc


/* COUNT
COUNT(column_name) finds the number of non-null values in a column. 
COUNT(*) also counts the null values.

COUNT is an aggregate function it is normally used with GROUP BY.

  SELECT region, COUNT(name)
    FROM bbc
   GROUP BY region */
SELECT region, COUNT(name)
FROM bbc
GROUP BY region


/* SUM
SUM adds a whole column of values.

SUM is an aggregate function it is normally used with GROUP BY.
With a GROUP BY region statement each region shows up just once. 
The SUM column gives the total for each region. */
SELECT region, SUM(population)
FROM bbc
GROUP BY region 


/* AVG
AVG gives the average (the mean) of a whole column or a group of rows for 
a single column of values.

AVG is an aggregate function it is normally used with GROUP BY. */
SELECT region, AVG(population)
FROM bbc
GROUP BY region


/* MAX
MAX finds the highest values in a column or part of a column

MAX is an aggregate function it is normally used with GROUP BY.

 SELECT region, MAX(name)
    FROM bbc
   GROUP BY region 

With a GROUP BY region statement each region shows up just once. 
The MAX column gives the "largest" name in the region in the context 
of strings this is the last name alphabetically. */
SELECT region, MAX(name)
FROM bbc
GROUP BY region


/* MIN
MIN finds the smallest values in a column or part of a column

MIN is an aggregate function it is normally used with GROUP BY.

  SELECT region, MIN(name)
    FROM bbc
   GROUP BY region */
SELECT region, MIN(name)
FROM bbc
GROUP BY region


/* RANK 1.
RANK() OVER (ORDER BY f DESC) returns the rank position relative to the 
expression f.

In this example we show the ranking, by population of those countries 
with a population of over 180 million */
SELECT name, RANK() OVER (ORDER BY population DESC) AS rank
FROM bbc
WHERE population > 180E6
GROUP BY name
ORDER BY rank


/* RANK 2.
Using RANK OVER PARTITION BY
You can see view the RANK according to continent. 
This shows the biggest country */
SELECT
  name,
  population,
  RANK() OVER (ORDER BY population DESC) 
    AS world_rank,
  RANK() OVER 
    (PARTITION BY continent ORDER BY population DESC) 
    AS local_rank
FROM world 
WHERE population > 100E6
GROUP BY name, population
ORDER BY world_rank, local_rank


/* CURRENT_DATE
CURRENT_DATE returns today's date.

   CURRENT_DATE -> '2006-12-31' */
SELECT CAST(CURRENT_DATE AS DATE) AS today, wk
FROM totp


/* YEAR
YEAR allows you to retrieve the year from a date.

   YEAR(d)

In this example you get the year from the date field whn. */
SELECT YEAR(whn) AS yr, whn, wht
FROM eclipse


/* QUARTER
QUARTER allows you to retrieve the 3 month period from a date.

QUARTERS
First Quarter	January 1	March 31
Second Quarter	April 1	June 30
Third Quarter	July 1	September 30
Fourth Quarter	October 1	December 31

   QUARTER(d) */
SELECT 
  wk,
  QUARTER(wk) AS quarter,
  song
FROM totp
WHERE singer = 'Cliff Richard'
ORDER BY wk DESC


/* MONTH
MONTH allows you to retrieve the month from a date.

   MONTH(d)

In this example you get the month from the date field whn. */
SELECT MONTH(whn) AS month, whn, wht
FROM eclipse


/* DAY
DAY allows you to retrieve the day from a date.

   DAY(d) */
SELECT 
  DAY(whn) AS day, whn, wht
FROM eclipse


/* HOUR
HOUR allows you to retrieve the hour from a datetime.

   HOUR(d)

In this example you get the hour from the datetime field whn. */
SELECT 
  HOUR(whn) AS hr, 
  whn, 
  wht
FROM eclipse


/* MINUTE
MINUTE allows you to retrieve the minute from a date.

   MINUTE(d)

In this example you get the minute from the date field whn. */
SELECT MINUTE(whn) AS minute, whn, wht
FROM eclipse


/* + (dates)
d + i returns the date i days after the date d.

 DATE '2006-05-20' + 7  -> DATE '2006-05-27' */
SELECT whn, whn + 7 
FROM eclipse


/* + INTERVAL
d + INTERVAL i DAY returns the date i days after the date d.

You can also add YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

You can also add a negative value.

 DATE '2006-05-20' + INTERVAL 5 DAY   -> DATE '2006-05-25' 
 DATE '2006-05-20' + INTERVAL 5 MONTH -> DATE '2006-10-20' 
 DATE '2006-05-20' + INTERVAL 5 YEAR  -> DATE '2011-05-20' 

In this example we show the date 7 days after the value specified 
in whn */
SELECT whn, whn+INTERVAL 7 DAY
FROM eclipse


/* EXTRACT
EXTRACT allows you to retrieve components of a date.

You can extract also YEAR, MONTH, DAY, HOUR, MINUTE, SECOND.

  EXTRACT(YEAR FROM d)    EXTRACT(MONTH FROM d)
  EXTRACT(DAY FROM d)     EXTRACT(HOUR FROM d)
  EXTRACT(MINUTE FROM d)  EXTRACT(SECOND FROM d) */
SELECT 
  whn, 
  EXTRACT(YEAR FROM td)  AS yr,
  EXTRACT(HOUR FROM td) AS hr
FROM eclipse


/* SECOND
SECOND allows you to retrieve the second from a date.

   SECOND(d)

In this example you get the second from the date field whn. */
SELECT SECOND(td) AS second, whn, wht
FROM eclipse
