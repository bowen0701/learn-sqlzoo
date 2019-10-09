/* SQLZOO: 8 Using Null:
http://sqlzoo.net/w/index.php/Using_Null */

/* Ex1. List the teachers who have NULL for their department. */
SELECT name
FROM teacher
WHERE dept IS NULL

/* Ex2. Note the INNER JOIN misses the teachers with no department and 
the departments with no teacher. */
SELECT t.name AS teacher, d.name AS dept
FROM teacher t JOIN dept d
ON t.dept = d.id

/* Ex3. Use a different JOIN so that all teachers are listed. */
SELECT t.name AS teacher, d.name AS dept
FROM teacher t LEFT JOIN dept d
ON t.dept = d.id

/* Ex4. Use a different JOIN so that all departments are listed. */
SELECT t.name AS teacher, d.name AS dept
FROM teacher t RIGHT JOIN dept d
ON t.dept = d.id

/* Ex5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' 
if there is no number given. Show teacher name and mobile number or '07986 444 2266' */
SELECT name, COALESCE(mobile, '07986 444 2266') AS mobile
FROM teacher

/* Ex6. Use the COALESCE function and a LEFT JOIN to print the teacher name and 
department name. Use the string 'None' where there is no department. */
SELECT 
  t.name AS name_teacher, 
  COALESCE(d.name, 'None') AS name_dept
FROM teacher t LEFT JOIN dept d
ON t.dept = d.id

/* Ex7. Use COUNT to show the number of teachers and the number of mobile phones. */
SELECT COUNT(name), COUNT(mobile)
FROM teacher

/* Ex8. Use COUNT and GROUP BY dept.name to show each department and the number 
of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed. */
SELECT 
  d.name AS dept, 
  COUNT(t.name) AS num_teachers
FROM teacher t RIGHT JOIN dept d
ON t.dept = d.id
GROUP BY d.name

/* Ex9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher 
is in dept 1 or 2 and 'Art' otherwise. */
SELECT 
  name,
  CASE WHEN dept IN (1, 2) THEN 'Sci'
    ELSE 'Art' 
    END AS dept_type
FROM teacher

/* Ex10. Use CASE to show the name of each teacher followed by 'Sci' if the 
teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise. */
SELECT
  name,
  CASE WHEN dept IN (1, 2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None'
    END AS 'dept_type'
FROM teacher
