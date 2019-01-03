/* SQLZOO: 6.2 JOIN: Previously Music Tutorial
http://sqlzoo.net/wiki/Music_Tutorial

The Music database
This tutorial introduces the notion of a join. The music has two tables: album and track.

album(asin, title, artist, price, release, label, rank)
track(album, dsk, posn, song) 

How to do joins.
The phrase FROM album JOIN track ON album.asin=track.album represents the join of 
the tables album and track. This JOIN has one row for every track. 
In addition to the track fields (album, disk, posn and song) it includes the 
details of the corresponding album (title, artist ...). */

/* Ex1.
Find the title and artist who recorded the song 'Alison'. */
SELECT title, artist
FROM album a JOIN track t
ON a.asin = t.album
WHERE song = 'Alison'

/* Ex2.
Which artist recorded the song 'Exodus'? */
SELECT artist
FROM album a JOIN track t
ON a.asin = t.album
WHERE song = 'Exodus'

/* Ex3.
Show the song for each track on the album with title'Blur'. */
SELECT song
FROM track t JOIN album a
ON t.album = a.asin
WHERE title = 'Blur'

/* Ex4. We can use the aggregate functions and GROUP BY expressions on the joined table.
For each album show the title and the total number of track. */
SELECT title, COUNT(song)
FROM album a JOIN track t
ON a.asin = t.album
GROUP BY title

/* Ex5.
For each album show the title and the total number of tracks containing the word 'Heart'
(albums with no such tracks need not be shown).
Hint:
Use song LIKE '%Heart%' to find the songs that include the word Heart. */
SELECT title, COUNT(song)
FROM album a JOIN track t
ON a.asin = t.album
WHERE song LIKE '%Heart%'
GROUP BY title
HAVING COUNT(song) > 0

/* Ex6.
A "title track" is where the song is the same as the title. Find the title tracks. */
SELECT song
FROM album a JOIN track t
ON a.asin = t.album
WHERE title = song

/* Ex7.
An "eponymous" album is one where the title is the same as the artist (for example the album 'Blur' by the band 'Blur'). Show the eponymous albums.

Hint
You only need to access one table in this example - so don't use the JOIN. */
SELECT title
FROM album
WHERE title = artist

/* Ex8.
Find the songs that appear on more than 2 albums. Include a count of the number of times each shows up.

hint
The HAVING clause can be used outside of the GROUP BY. */
SELECT song, COUNT(DISTINCT(album))
FROM track
GROUP BY song
HAVING COUNT(DISTINCT(album)) > 2

/* Ex9.
A "good value" album is one where the price per track is less than 50 pence. 
Find the good value album - show the title, the price and the number of tracks. */
SELECT title, price, COUNT(song)
FROM album a JOIN track t
ON a.asin = t.album
GROUP BY title, price
HAVING price / COUNT(song) < 0.50

/* Ex10.
Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101 tracks.

List albums so that the album with the most tracks is first. 
Show the title and the number of tracks. */
SELECT title, COUNT(song)
FROM album a JOIN track t
ON a.asin = t.album
GROUP BY title
ORDER BY COUNT(song) DESC
