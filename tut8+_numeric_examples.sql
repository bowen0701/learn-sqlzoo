/* SQLZOO: 8+ Numeric Examples:
http://sqlzoo.net/wiki/NSS_Tutorial */

/* Ex1. The example shows the number who responded for:
- question 'Q01'
- at 'Edinburgh Napier University'
- studying '(8) Computer Science' 
Show the the percentage who STRONGLY AGREE*/
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question = 'Q01'
  AND institution = 'Edinburgh Napier University'
  AND subject = '(8) Computer Science'


/* Ex2. Show the institution and subject where the score is at least 100 for question 
'Q15'. */
SELECT institution, subject
FROM nss
WHERE question = 'Q15'
  AND score >= 100


/* Ex3. Show the institution and score where the score for '(8) Computer Science' 
is less than 50 for question 'Q15' */
SELECT institution, score
FROM nss
WHERE subject = '(8) Computer Science'
  AND question = 'Q15'
  AND score < 50


/* Ex4. Show the subject and total number of students who responded to question 'Q22' 
for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
Hint:
You will need to use SUM over the response column and GROUP BY subject. */
SELECT subject, SUM(response) AS num_students
FROM nss
WHERE 
  subject IN 
    ('(8) Computer Science', '(H) Creative Arts and Design')
  AND question = 'Q22'
GROUP BY subject


/* Ex5. Show the subject and total number of students who A_STRONGLY_AGREE to 
question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts 
and Design'.
Hint:
The A_STRONGLY_AGREE column is a percentage. To work out the total number of 
students who strongly agree you must multiply this percentage by the number who
responded (response) and divide by 100 - take the SUM of that. */
SELECT 
  subject, 
  SUM(response * A_STRONGLY_AGREE / 100) AS num_strongly_agree_stud
FROM nss
WHERE question = 'Q22' 
  AND subject IN
    ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject


/* Ex6. Show the percentage of students who A_STRONGLY_AGREE to question 22 for 
the subject 
'(8) Computer Science' show the same figure for the subject 
'(H) Creative Arts and Design'.
Use the ROUND function to show the percentage without decimal places. */
SELECT
  subject,
  ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100, 0)
FROM nss
WHERE question = 'Q22'
  AND subject IN 
    ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject


/* Ex7. Show the average scores for question 'Q22' for each institution that include 
'Manchester' in the name.
The column score is a percentage - you must use the method outlined above to 
multiply the percentage by the response and divide by the total response.
Give your answer rounded to the nearest whole number. */
SELECT 
  institution, 
  ROUND(SUM(score * response ) / SUM(response), 0)
FROM nss
WHERE question = 'Q22'
  AND institution LIKE '%Manchester%'
GROUP BY institution


/* Ex8. Show the institution, the total sample size and the number of sampled students 
for the subject '(8) Computer Science' for institutions in Manchester for 'Q01'. */
SELECT 
  institution, 
  SUM(sample),
  SUM(
    CASE WHEN subject = '(8) Computer Science' THEN sample
    ELSE 0
    END)
FROM nss
WHERE question = 'Q01'
  AND institution LIKE '%Manchester%'
GROUP BY institution
