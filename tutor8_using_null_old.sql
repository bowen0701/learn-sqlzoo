/* Scottish Parliament
Scottish Parliament
The data includes all Members of the Scottish Parliament (MSPs) in 1999. Most MSPs belong to a political party. Some parties have a leader who is an MSP. There are two tables:

msp
name	party	constituency
Adam MSP, Brian	SNP	North East Scotland
Aitken MSP, Bill	Con	Glasgow
Alexander MSP, Ms Wendy	Lab	Paisley North
... Total number of records: 129

party
code	name	leader
Con	Conservative	McLetchie MSP, David
Green	Green	
Lab	Labour	Dewar MSP, Rt Hon Donald
... Total number of records: 9 */

/* Ex1.
One MSP was kicked out of the Labour party and has no party. Find him.

Why we cannot use =
You might think that the phrase dept=NULL would work here. It doesn't. 
This is because NULL "propogates". Any normal expression that includes NULL 
is itself NULL, thus the value of the expressions 2+NULL and party || NULL and 
NULL=NULL for example are all NULL.

Theory
The NULL value does not cause a type error, however it does infect everything it
touches with NULL-ness. We call this element the bottom value for the algebra - 
but we don't snigger because we are grown-ups. Bottom Type.*/
SELECT name
FROM msp
Where party IS NULL

/* Ex2.
Obtain a list of all parties and leaders. */
SELECT name, leader
FROM party

/* Ex3.
Give the party and the leader for the parties which have leaders. */
SELECT name, leader
FROM party
WHERE leader IS NOT NULL

/* Ex4.
Obtain a list of all parties which have at least one MSP. */
SELECT p.name
FROM msp m JOIN party p
ON m.party = p.code
WHERE party IS NOT NULL
GROUP BY p.name
HAVING COUNT(m.name) >= 1

/* Ex5.
Obtain a list of all MSPs by name, give the name of the MSP and the name of the 
party where available. Be sure that Canavan MSP, Dennis is in the list. 
Use ORDER BY msp.name to sort your output by MSP. */
SELECT m.name, p.name
FROM msp m LEFT JOIN party p
ON m.party = p.code
ORDER BY m.name

/* Ex6.
Obtain a list of parties which have MSPs, include the number of MSPs. */
SELECT p.name, COUNT(m.name)
FROM party p RIGHT JOIN msp m
ON p.code = m.party
WHERE p.name IS NOT NULL
GROUP BY p.name

/* Ex7.
A list of parties with the number of MSPs; include parties with no MSPs. */
SELECT p.name, COUNT(m.name)
FROM party p LEFT JOIN msp m
ON p.code = m.party
GROUP BY p.name
