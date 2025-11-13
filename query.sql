SELECT s.fullname, AVG(g.grade) AS avg_grade
FROM grades g
JOIN students s ON s.id = g.student_id
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 5;



#query_2.sql
SELECT s.fullname, AVG(g.grade) AS avg_grade
FROM grades g
JOIN students s ON s.id = g.student_id
WHERE g.subject_id = :subject_id
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 1;

#query_3.sql
SELECT gr.name, AVG(g.grade) AS avg_grade
FROM grades g
JOIN students s ON s.id = g.student_id
JOIN groups gr ON gr.id = s.group_id
WHERE g.subject_id = :subject_id
GROUP BY gr.id;

#query_4.sql
SELECT AVG(grade) AS avg_grade
FROM grades;

#query_5.sql
SELECT AVG(grade) AS avg_grade
FROM grades;

#query_6.sql
SELECT fullname
FROM students
WHERE group_id = :group_id;


#query_7.sql
SELECT s.fullname, g.grade, g.date_received
FROM grades g
JOIN students s ON s.id = g.student_id
WHERE s.group_id = :group_id
AND g.subject_id = :subject_id;


#query_8.sql
SELECT t.fullname, AVG(g.grade) AS avg_grade
FROM grades g
JOIN subjects sub ON sub.id = g.subject_id
JOIN teachers t ON t.id = sub.teacher_id
WHERE t.id = :teacher_id;

#query_9.sql
SELECT DISTINCT sub.name
FROM grades g
JOIN subjects sub ON sub.id = g.subject_id
WHERE g.student_id = :student_id;

#query_10.sql
SELECT DISTINCT sub.name
FROM subjects sub
JOIN grades g ON g.subject_id = sub.id
WHERE g.student_id = :student_id
AND sub.teacher_id = :teacher_id;


query_extra1.sql
SELECT AVG(g.grade) AS avg_grade
FROM grades g
JOIN subjects sub ON sub.id = g.subject_id
WHERE sub.teacher_id = :teacher_id
AND g.student_id = :student_id;

query_extra2.sql
SELECT s.fullname, g.grade, g.date_received
FROM grades g
JOIN students s ON s.id = g.student_id
WHERE s.group_id = :group_id
AND g.subject_id = :subject_id
AND g.date_received = (
    SELECT MAX(date_received)
    FROM grades
    WHERE subject_id = :subject_id
);














