/* SQLZOO: 9. Self join
http://sqlzoo.net/wiki/Self_join */

/* Ex1.
How many stops are in the database. */

/* Ex2.
Find the id value for the stop 'Craiglockhart' */

/* Ex3.
Give the id and the name for the stops on the '4' 'LRT' service. */

/* Ex4.
The query shown gives the number of routes that visit either London Road (149) 
or Craiglockhart (53). Run the query and notice the two services that 
link these stops have a count of 2. Add a HAVING clause to restrict the output 
to these two routes. */

/* Ex5.
Execute the self join shown and observe that b.stop gives all the places you can 
get to from Craiglockhart, without changing routes. Change the query so that it 
shows the services from Craiglockhart to London Road. */

/* Ex6.
The query shown is similar to the previous one, however by joining two copies of 
the stops table we can refer to stops by name rather than by number. 
Change the query so that the services between 'Craiglockhart' and 'London Road' 
are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' */

/* Ex7.
Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 
'Leith') */

/* Ex8.
Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' */

/* Ex9.
Give a distinct list of the stops which may be reached from 'Craiglockhart' by 
taking one bus, including 'Craiglockhart' itself, offered by the LRT company. 
Include the company and bus no. of the relevant services. */

/* Ex10.
Find the routes involving two buses that can go from Craiglockhart to Sighthill.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.

Hint
Self-join twice to find buses that visit Craiglockhart and Sighthill, then 
join those on matching stops. */
