/* SQLZOO: 7 More JOIN operations:
http://sqlzoo.net/wiki/More_JOIN_operations */

/* Ex1. List the films where the yr is 1962 [Show id, title] */
SELECT id, title
FROM movie
WHERE yr = 1962


/* Ex2. Give year of 'Citizen Kane'. */
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'


/* Ex3. List all of the Star Trek movies, 
include the id, title and yr 
(all of these movies include the words Star Trek in the title). 
Order results by year. */
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr


/* Ex4. What id number does the actor 'Glenn Close' have? */
SELECT id
FROM actor
WHERE name = 'Glenn Close'


/* Ex5. What is the id of the film 'Casablanca'. */
SELECT id
FROM movie
WHERE title = 'Casablanca'


/* Ex6. Obtain the cast list for 'Casablanca'.
what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question) */
SELECT name
FROM actor a RIGHT JOIN casting c
ON a.id = c.actorid 
WHERE movieid = (
  SELECT id 
  FROM movie 
  WHERE title = 'Casablanca')


/* Ex7. Obtain the cast list for the film 'Alien'. */
SELECT name
FROM casting c JOIN actor a
ON c.actorid = a.id
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Alien')


/* Ex8. List the films in which 'Harrison Ford' has appeared. */
SELECT title
FROM casting c JOIN movie m
ON c.movieid = m.id
WHERE actorid = (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford')


/* Ex9. List the films where 'Harrison Ford' has appeared - 
but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role] */
SELECT title
FROM casting c JOIN movie m
ON c.movieid = m.id
WHERE actorid = (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford')
  AND ord <> 1


/* Ex10. List the films together with the leading star for all 1962 films. */
SELECT title, name
FROM casting c JOIN movie m
ON c.movieid = m.id
JOIN actor a
ON c.actorid = a.id
WHERE yr = 1962
  AND ord = 1


/* Ex11. Which were the busiest years for 'John Travolta', 
show the year and the number of movies he made each year for any year 
in which he made more than 2 movies. */
SELECT yr, COUNT(movieid)
FROM casting c JOIN actor a
ON c.actorid = a.id
JOIN movie m
ON c.movieid = m.id
WHERE name = 'John Travolta'
GROUP BY yr
HAVING COUNT(movieid) > 2


/* Ex12. List the film title and the leading actor for all of the films 
'Julie Andrews' played in. */
SELECT title, name
FROM movie m JOIN casting c
ON m.id = c.movieid
JOIN actor a
ON c.actorid = a.id
WHERE movieid IN (
  SELECT movieid
  FROM casting
  WHERE actorid = (
    SELECT id FROM actor WHERE name = 'Julie Andrews'))
  AND ord = 1


/* Ex13. Obtain a list, in alphabetical order, 
of actors who've had at least 30 starring roles. */
SELECT name
FROM actor a JOIN casting c
ON a.id = c.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(movieid) >= 30
ORDER BY name


/* Ex14. List the films released in the year 1978 ordered by the 
number of actors in the cast, then by title. */
SELECT title, COUNT(actorid)
FROM movie m JOIN casting c
ON m.id = c.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title
      

/* Ex15. List all the people who have worked with 'Art Garfunkel'. */
SELECT name
FROM actor a JOIN casting c
ON a.id = c.actorid
WHERE movieid IN (
  SELECT movieid 
  FROM casting
  WHERE actorid = (
    SELECT id FROM actor WHERE name = 'Art Garfunkel'))
  AND name <> 'Art Garfunkel'
