/* SQLZOO: 5 SUM and COUNT:
http://sqlzoo.net/wiki/SUM_and_COUNT */

/* Ex1. Show the total population of the world. */
SELECT SUM(population)
FROM world


/* Ex2. List all the continents - just once each. */
SELECT DISTINCT continent
FROM world


/* Ex3. Give the total GDP of Africa. */
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa'


/* Ex4. How many countries have an area of at least 1000000. */
SELECT COUNT(name)
FROM world
WHERE area >= 1E6


/* Ex5. What is the total population of 
('Estonia', 'Latvia', 'Lithuania')*/
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')


/* Ex6. For each continent show the continent and number of countries. */
SELECT continent, COUNT(name)
FROM world
GROUP BY continent


/* Ex7. For each continent show the continent and number of countries 
with populations of at least 10 million. */
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10E6
GROUP BY continent


/* Ex8. List the continents that have a total population of 
at least 100 million. */
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100E6
