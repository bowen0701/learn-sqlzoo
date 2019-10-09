/* SQLZOO: 6 JOIN (old):
http://sqlzoo.net/wiki/Old_JOIN_Tutorial */

/* 
ttms
games	color	who	country
1988	gold	Yoo Nam-Kyu	KOR
1988	silver	Kim Ki Taik	KOR

country
id	name
ALG	Algeria
ARG	Argentina
...	...
KOR	Korea 
*/

/* Ex1. Show the athelete (who) and the country name for medal winners in 2000. */
SELECT who, name
FROM ttms t JOIN country c
ON t.country = c.id
WHERE games = 2000


/* Ex2. Show the who and the color of the medal for the medal winners from 'Sweden'. */
SELECT who, color
FROM ttms t JOIN country c
ON t.country = c.id
WHERE name = 'Sweden'


/* Ex3. Show the years in which 'China' won a 'gold' medal. */
SELECT DISTINCT games
FROM ttms t JOIN country c
ON t.country = c.id
WHERE name = 'China' 
  AND color = 'gold'


/* 
ttws
games	color	who	country
1988	gold	Jing Chen	CHN
1988	silver	Li Hui-Fen	CHN
..	..	..	..

games
yr	city	country
1988	Seoul	KOR
1992	Barcelona	ESP
..	..	.. 
*/


/* Ex4. Show who won medals in the 'Barcelona' games. */
SELECT who
FROM ttws t JOIN games g
ON t.games = g.yr
WHERE city = 'Barcelona'

/* Ex. 5. Show which city 'Jing Chen' won medals. Show the city and the medal color. */
SELECT city, color
FROM ttws t JOIN games g
ON t.games = g.yr
WHERE who = 'Jing Chen'


/* Ex6. Show who won the gold medal and the city. */
SELECT who, city
FROM ttws t JOIN games g
ON t.games = g.yr
WHERE color = 'gold'


/* 
ttmd
games	color	team	country
1988	gold	1	CHN
1988	silver	2	YUG
..	..	..	..
team
id	name
1	Long-Can Chen
1	Qing-Guang Wei
2	Ilija Lupulesku
2	Zoran Primorac
..	..
 */


/* Ex 7. Show the games and color of the medal won by the team that 
includes 'Yan Sen'. */
SELECT games, color
FROM ttmd JOIN team
ON ttmd.team = team.id
WHERE team.name = 'Yan Sen'


/* Ex8. Show the 'gold' medal winners in 2004. */
SELECT name
FROM ttmd JOIN team
ON ttmd.team = team.id
WHERE games = 2004 
  AND color = 'gold'


/* Ex9. Show the name of each medal winner country 'FRA'. */
SELECT name
FROM ttmd JOIN team
ON ttmd.team = team.id
WHERE country = 'FRA'
