/* SQLZOO: 5.2 Nobel Prizes: Aggregate functions:
http://sqlzoo.net/wiki/The_nobel_table_can_be_used_to_practice_more_SUM_and_COUNT_functions. 

nobel(yr, subject, winner) */

/* Ex1. Show the total number of prizes awarded. */
SELECT COUNT(*)
FROM nobel


/* Ex2. List each subject - just once. */
SELECT DISTINCT subject
FROM nobel


/* Ex3. Show the total number of prizes awarded for Physics. */
SELECT COUNT(*)
FROM nobel
WHERE subject = 'Physics'


/* Ex4. For each subject show the subject and the number of prizes. */
SELECT subject, COUNT(winner)
FROM nobel
GROUP BY subject


/* Ex5. For each subject show the first year that the prize was awarded. */
SELECT subject, MIN(yr)
FROM nobel
GROUP BY subject


/* Ex6. For each subject show the number of prizes awarded in the year 2000. */
SELECT subject, COUNT(winner)
FROM nobel
WHERE yr = 2000
GROUP BY subject


/* Ex7. Show the number of different winners for each subject. */
SELECT subject, COUNT(DISTINCT(winner))
FROM nobel
GROUP BY subject


/* Ex8. For each subject show how many years have had prizes awarded. */
SELECT subject, COUNT(DISTINCT(yr))
FROM nobel
GROUP BY subject


/* Ex9. Show the years in which three prizes were given for Physics. */
SELECT yr
FROM nobel
WHERE subject = 'Physics'
GROUP BY yr
HAVING COUNT(winner) = 3


/* Ex10. Show winners who have won more than once. */
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(*) > 1


/* Ex11. Show winners who have won more than one subject. */
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT(subject)) > 1


/* Ex12. Show the year and subject where 3 prizes were given. 
Show only years 2000 onwards. */
SELECT yr, subject
FROM nobel
WHERE yr >= 2000
GROUP BY yr, subject
HAVING COUNT(winner) = 3
