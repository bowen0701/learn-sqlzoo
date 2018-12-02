/* SQLZOO: 6.2 JOIN: Previously Music Tutorial
http://sqlzoo.net/wiki/Music_Tutorial

The Music database
This tutorial introduces the notion of a join. The music has two tables: album and track.

album(asin, title, artist, price, release, label, rank)
track(album, dsk, posn, song) */

/* Ex1.
Find the title and artist who recorded the song 'Alison'. */

/* Ex2.
Which artist recorded the song 'Exodus'? */

/* Ex3.
Show the song for each track on the album 'Blur'. */

/* Ex4. We can use the aggregate functions and GROUP BY expressions on the joined table.
For each album show the title and the total number of track. */

/* Ex5.
For each album show the title and the total number of tracks containing the word 'Heart'
(albums with no such tracks need not be shown).

Hint:
Use song LIKE '%Heart%' to find the songs that include the word Heart. */

/* Ex6.
A "title track" is where the song is the same as the title. Find the title tracks. */

/* Ex7.
An "eponymous" album is one where the title is the same as the artist (for example the album 'Blur' by the band 'Blur'). Show the eponymous albums.

Hint
You only need to access one table in this example - so don't use the JOIN. */

/* Ex8.
Find the songs that appear on more than 2 albums. Include a count of the number of times each shows up.

hint
The HAVING clause can be used outside of the GROUP BY. */

/* Ex9.
A "good value" album is one where the price per track is less than 50 pence. 
Find the good value album - show the title, the price and the number of tracks. */

/* Ex10.
Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101 tracks.

List albums so that the album with the most tracks is first. 
Show the title and the number of tracks. */

