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


