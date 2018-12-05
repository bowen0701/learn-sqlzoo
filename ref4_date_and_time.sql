/* Reference 4 DATE and TIME. */

/* Date and time types */
CREATE TABLE t_dttest (
  a DATE,
  b TIME,
  c DATETIME);

INSERT INTO t_dttest VALUES (
  DATE '1962-05-20',
  TIME '10:32:16',
  TIMESTAMP '1962-05-20 10:32:16');

SELECT * FROM t_dttest;


/* Format a date and time.

Many engines support the SQL standard - see Mimer for details. 
Specifier	Description
%a	Abbreviated weekday name (Sun..Sat)
%b	Abbreviated month name (Jan..Dec)
%c	Month, numeric (0..12)
%D	Day of the month with English suffix (0th, 1st, 2nd, 3rd, ...)
%d	Day of the month, numeric (00..31)
%e	Day of the month, numeric (0..31)
%f	Microseconds (000000..999999)
%H	Hour (00..23)
%h	Hour (01..12)
%I	Hour (01..12)
%i	Minutes, numeric (00..59)
%j	Day of year (001..366)
%k	Hour (0..23)
%l	Hour (1..12)
%M	Month name (January..December)
%m	Month, numeric (00..12)
%p	AM or PM
%r	Time, 12-hour (hh:mm:ss followed by AM or PM)
%S	Seconds (00..59)
%s	Seconds (00..59)
%T	Time, 24-hour (hh:mm:ss)
%U	Week (00..53), where Sunday is the first day of the week
%u	Week (00..53), where Monday is the first day of the week
%V	Week (01..53), where Sunday is the first day of the week; used with %X
%v	Week (01..53), where Monday is the first day of the week; used with %x
%W	Weekday name (Sunday..Saturday)
%w	Day of the week (0=Sunday..6=Saturday)
%X	Year for the week where Sunday is the first day of the week, numeric, four digits; used with %V
%x	Year for the week, where Monday is the first day of the week, numeric, four digits; used with %v
%Y	Year, numeric, four digits
%y	Year, numeric, two digits
%%	A literal `%'. */
SELECT DATE_FORMAT(wk, '%d/%m/%Y'), song
FROM totp
WHERE singer = 'Tom Jones'


/* Specify a date (a date literal).

The Standard specifies a date literal as: DATE '1982-05-20'
Similarly specify a timestamp using TIMESTAMP '1982-05-20 21:30:00'

Find the songs played on 20th May 1982. */
SELECT * FROM totp
WHERE wk = DATE '1982-05-20'


/* Match a range of dates

The BETWEEN clause may be used with dates, numbers and strings. */
SELECT * FROM totp
WHERE wk BETWEEN DATE '1980-05-20' 
  AND DATE '1980-05-26'


/* Subtract dates.

SQL Standard allows dates to be subtracted. We specify the unit and 
the number of digits of the result answer: 
YEAR MONTH DAY HOUR MINUTE SECOND

We want to know how long has it been since Tom Jones featured on TOTP. */
USE gisq;
SELECT 
  singer, 
  song,
  TO_DAYS(NOW()) - TO_DAYS(wk) AS DAYS
FROM totp
WHERE singer = 'Tom Jones'


/* Intervals of time.

We can add (or subtract) a number of days (or years, months, hours, minutes 
or seconds) from date.

In this example we want to find the totp events that went out in the week 
of my 14th birthday. */
SELECT * 
FROM totp
WHERE DATE '1976-05-20'
  BETWEEN wk - INTERVAL '7' DAY AND wk


/* Components of a date: such as the year or the month.

We can extract the year, the month, the day of the month and the day 
of the week. Times may be extracted in a similar way. */
SELECT 
  wk, 
  YEAR(wk), 
  MONTH(wk),
  DAYOFMONTH(wk), 
  DAYNAME(wk)
FROM totp 
WHERE song = 'Rio'


/* Date functions
Group by day of the week (using date functions)

We might want to count, or find the average by days of the week. 
This approach uses the date functions.

In this example we note that top of the pops usually goes out on a 
Thursday or Friday. */
SELECT DAYOFWEEK(wk), COUNT(song)
FROM totp
GROUP BY DAYOFWEEK(wk)


/* Date arithmetics
Group by day of the week (using arithmetic).
We can use modular arithmetic to calculate the day of the week.

We happen to know that 20 May 1962 was a Sunday. 
We calculate the number of days from that day and take mod 7 value. 
This tells us the day of the week: 0 is Sunday, 1 is Monday... */
SELECT 
  DATEDIFF(wk, '1962-05-20') % 7 AS day_of_week, 
  COUNT(song)
FROM totp
GROUP BY day_of_week


/* Select the oldest person
How can I select the oldest person in the table PERSON by birthday?

I have a table
PERSON(personID, name, sex, birthday, placeOfBirth)

Now I would like to SELECT the oldest person in the table by birthday. */
-- Set up the table
DROP TABLE person;
CREATE TABLE person(
  personId INTEGER PRIMARY KEY,
  name VARCHAR(20),
  sex CHAR(1),
  birthday DATE,
  placOfBirth VARCHAR(20));

INSERT INTO person VALUES
  (1,'Oliver','M','1985-05-25','Bedford');
INSERT INTO person VALUES
  (2,'Andrew','M','1962-05-20','Hong Kong');

--Here is the answer
SELECT * 
FROM person
WHERE birthday = (
  SELECT MIN(birthday) FROM person)


/* Select a record with the latest date.

There may be several records with the same date.

There are two steps... 
(a) Find the latest date 
(b) Select records with that date 
With a nested select we can do both of these in one go. */
SELECT * 
FROM totp 
where wk = (
  SELECT MAX(wk) FROM totp)


/* YYYYMMDD date format
How to format a date in the like yyyymmdd.

Display the dates that Madness played Top of the Pops, 
show the dates in the format yyyymmdd.

The SQL standard gives us the EXTRACT function to get year, month and day. 
We can use the LPAD function to pad these numbers to 2 digits. */
SELECT
  DATE_FORMAT(wk, '%Y%m%d'),
  wk,
  song
FROM totp
WHERE singer = 'Madness'


/* Getting the latest record
How can I get the Lastest record from SQL
I have a table like this:

balance    keepplace     startdate
___________________________________
A01        floor 1       2002-10-10
A01        BBB           2001-08-08
A02        222           2002-07-08
A02        111           2000-01-01
A03    
....
I want to get " where is the keep place for all balance by now? 
Answer Use a sub-select to get the last date - 
and make that match the original... */
CREATE TABLE placement (
  balance CHAR(3) NOT NULL,
  keepplace VARCHAR(10),
  startdate DATE NOT NULL,
  PRIMARY KEY(balance, startdate));

INSERT INTO placement VALUES ('A01', 'floor 1', '2002-10-10');
INSERT INTO placement VALUES ('A01', 'BBB', '2002-08-08');
INSERT INTO placement VALUES ('A02', '222', '2002-07-08');
INSERT INTO placement VALUES ('A02', '111', '2002-01-01');

SELECT balance, keepplace, startdate
FROM placement p1
WHERE startdate >= ALL(
  SELECT startdate FROM placement p2
  WHERE p1.balance = p2.balance)
