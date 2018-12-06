/* Reference 6. Users */

/* Create a new user.
Give the new user permission to connect and to create their own tables etc. */
CREATE DATABASE scott;
GRANT CREATE, DROP, ALTER, SELECT, INSERT, UPDATE, DELETE
  ON scott.* TO scott@localhost
  IDENTIFIED BY 'tiger';
FLUSH PRIVILEGES;


/* Read tables from another schema/database
A particular server may support a number of different sets of tables. 
In Oracle these are schemas in MySQL they are databases. 
In both cases each user normally has their own set of tables, 
other users tables may be accessed using a dot notation. */
SELECT * FROM gisq.one


/* Change the default schema/database.
In many engines several independant databases may exist. 
Often each user has his or her own database. 
This allows different users to use the same names for tables. */
USE scott;
SHOW TABLES

/* Find another process and kill it.
Sometimes users set off queries that may take a very long time to complete. 
We may want to find such long running processes and stop them. 
Some kind of administrative account is usually required. */
SHOW PROCESSLIST;
KILL 16318


/* Set a timeout.
Users may accidentally (or deliberately) start queries which would take 
a very long time to complete. We can set a 'timeout'; 
this means that the system gives up after a certain amount of time. */
SET LOCK_TIMEOUT 5000; --5 seconds.


/* Change my own password.
Users should be able to change their own passwords. 
The administrator should be able to change other people's passwords. */
SET PASSWORD FOR scott@localhost = password('tiger')


/* Who am I - what is my user id?
Find the user name or user id. The SQL standard permits the function USER */
SELECT user()
