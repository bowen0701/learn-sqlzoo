/* SQLZOO: 8+ Numeric Examples:
http://sqlzoo.net/wiki/NSS_Tutorial */

/* Ex1.
The example shows the number who responded for:

question 1
at 'Edinburgh Napier University'
studying '(8) Computer Science'
Show the the percentage who STRONGLY AGREE */

/* Ex2.
Show the institution and subject where the score is at least 100 for question 15. */

/* Ex3.
Show the institution and score where the score for '(8) Computer Science' 
is less than 50 for question 'Q15' */

/* Ex4.
Show the subject and total number of students who responded to question 22 for 
each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

HINT
You will need to use SUM over the response column and GROUP BY subject. */

/* Ex5.
Show the subject and total number of students who A_STRONGLY_AGREE to question 22 
for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

HINT
The A_STRONGLY_AGREE column is a percentage. To work out the total number of 
students who strongly agree you must multiply this percentage by the number who
responded (response) and divide by 100 - take the SUM of that. */

/* Ex6.
Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject 
'(8) Computer Science' show the same figure for the subject 
'(H) Creative Arts and Design'.

Use the ROUND function to show the percentage without decimal places. */

/* Ex7.
Show the average scores for question 'Q22' for each institution that include 
'Manchester' in the name.

The column score is a percentage - you must use the method outlined above to 
multiply the percentage by the response and divide by the total response.
Give your answer rounded to the nearest whole number. */

/* Ex8.
Show the institution, the total sample size and the number of computing students 
for institutions in Manchester for 'Q01'. */
