/* SQLZOO: 7 More JOIN operations */

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
FROM actor
WHERE id IN
    (SELECT actorid
     FROM casting
     WHERE movieid =
        (SELECT id
         FROM movie
         WHERE title = 'Casablanca'))

/* Ex7. Obtain the cast list for the film 'Alien'. */
SELECT name
FROM actor
WHERE id IN
    (SELECT actorid
     FROM casting
     WHERE movieid =
        (SELECT id
         FROM movie
         WHERE title = 'Alien'))

/* Ex8. List the films in which 'Harrison Ford' has appeared. */
SELECT title
FROM movie
WHERE id IN
    (SELECT movieid
     FROM casting
     WHERE actorid = 
        (SELECT id
         FROM actor
         WHERE name = 'Harrison Ford'))

/* Ex9. List the films where 'Harrison Ford' has appeared - 
but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role] */
SELECT title
FROM movie
WHERE id IN
    (SELECT movieid
     FROM casting
     WHERE actorid = 
        (SELECT id
         FROM actor
         WHERE name = 'Harrison Ford')
         AND ord <> 1)

/* Ex10. List the films together with the leading star for all 1962 films. */
SELECT d.title, c.name
FROM movie d
JOIN (SELECT a.*, b.name
      FROM casting a
      JOIN actor b
      ON (a.actorid = b.id)
      WHERE a.ord = 1) c
ON (d.id = c. movieid)
WHERE d.yr = 1962

/* Ex11. Which were the busiest years for 'John Travolta', 
show the year and the number of movies he made each year for any year 
in which he made more than 2 movies. */
SELECT yr, COUNT(title)
FROM movie
WHERE id IN
    (SELECT movieid
     FROM casting
     WHERE actorid = 
         (SELECT id
          FROM actor
          WHERE name = 'John Travolta'))
GROUP BY yr
Having COUNT(title) > 2

/* Ex12. List the film title and the leading actor for all of the films 
'Julie Andrews' played in. */
SELECT title, name
FROM
    (SELECT movieid, actorid
     FROM casting
     WHERE movieid IN
        (SELECT movieid FROM casting
         WHERE actorid IN (
         SELECT id FROM actor
         WHERE name='Julie Andrews'))
    AND ord = 1) a
JOIN actor b
ON a.actorid = b.id
JOIN movie c
ON a.movieid = c.id

/* Ex13. Obtain a list, in alphabetical order, 
of actors who've had at least 30 starring roles. */
SELECT b.name
FROM
    (SELECT actorid
     FROM casting
     WHERE ord = 1
     GROUP BY actorid
     Having COUNT(*) >= 30) a
LEFT JOIN actor b
ON (a.actorid = b.id)
ORDER BY b.name

/* Ex14. List the films released in the year 1978 ordered by the 
number of actors in the cast, then by title.*/
SELECT a.title, b.actor_cnt
FROM movie a
JOIN
(SELECT movieid, COUNT(actorid) AS actor_cnt
 FROM casting
 GROUP BY movieid) b
ON a.id = b.movieid
WHERE a.yr = 1978
      
/* Ex15. List all the people who have worked with 'Art Garfunkel'. */
SELECT name 
FROM actor
WHERE id IN
    (SELECT actorid
     FROM casting
     WHERE movieid IN
         (SELECT DISTINCT movieid
          FROM casting
          WHERE actorid IN
              (SELECT id
               FROM actor
               WHERE name = 'Art Garfunkel')))
AND id NOT IN 
    (SELECT id
     FROM actor
     WHERE name = 'Art Garfunkel')

