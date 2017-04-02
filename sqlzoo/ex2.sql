/* SQLZOO: 2 SELECT from World */

/* Ex1. Read the notes about this table. 
Observe the result of running this SQL command to show the 
name, continent and population of all countries. */
SELECT name, continent, population
FROM world

/* EX2. How to use WHERE to filter records. 
Show the name for the countries that have a population of 
at least 200 million. 200 million is 200000000, there are eight zeros. */
SELECT name
FROM world
WHERE population >= 2E8

/* Ex3. Give the name and the per capita GDP for those 
countries with a population of at least 200 million. */
SELECT name, gdp / population AS per_capita_GDP
FROM world
WHERE population >= 2E8

/* Ex4. Show the name and population in millions for the 
countries of the continent 'South America'. 
Divide the population by 1000000 to get population in millions. */
SELECT name, population / 1E6 AS pop_in_millions
FROM world
WHERE continent = 'South America'

/* Ex5. Show the name and population for France, Germany, Italy. */
SELECT name, population
FROM world
WHERE name in ('France', 'Germany', 'Italy')

/* Ex6. Show the countries which have a name that includes the word 'United'. */
SELECT name
FROM world
WHERE name like '%United%'

/* Ex7. Two ways to be big: 
A country is big if it has an area of more than 3 million sq km or 
it has a population of more than 250 million.
Show the countries that are big by area or big by population. 
Show name, population and area. */
SELECT name, population, area
FROM world
WHERE area > 3E6 OR population > 2.5E8

/* Ex8. Exclusive OR (XOR). 
Show the countries that are big by area or big by population but not both. 
Show name, population and area.
Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded. */
SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000

/* Ex9. Show the name and population in millions and the 
GDP in billions for the countries of the continent 'South America'. 
Use the ROUND function to show the values to two decimal places.
For South America show population in millions and GDP in billions 
both to 2 decimal places. */
SELECT name, 
       ROUND(population / 1E6, 2) AS pop_in_m, 
       ROUND(gdp / 1E9, 2) AS pdp_in_b
FROM world
WHERE continent = 'South America'

/* Ex10. Show the name and per-capita GDP for those countries with a 
GDP of at least one trillion (1000000000000; that is 12 zeros). 
Round this value to the nearest 1000.
Show per-capita GDP for the trillion dollar countries to the nearest $1000. */
SELECT name, ROUND(gdp / population, -3) AS per_capita_gdp
FROM world
WHERE gdp > 1E12

/* Ex11. Greece has capital Athens.
Each of the strings 'Greece', and 'Athens' has 6 characters.
Show the name and capital where the name and the capital have the 
same number of characters.
You can use the LENGTH function to find the number of characters in a string */
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital)

/* Ex12. The capital of Sweden is Stockholm. 
Both words start with the letter 'S'.
Show the name and the capital where the first letters of each match. 
Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
You can use <> as the NOT EQUALS operator. */
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital

/* Ex13. Equatorial Guinea and Dominican Republic have 
all of the vowels (a e i o u) in the name. 
They don't count because they have more than one word in the name.
Find the country that has all the vowels and no spaces in its name.
You can use the phrase name NOT LIKE '%a%' to exclude characters 
from your results.
The query shown misses countries like Bahamas and Belarus 
because they contain at least one 'a'. */
SELECT name
FROM world
WHERE name NOT LIKE '% %' 
AND name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
