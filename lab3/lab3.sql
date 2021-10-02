SELECT * FROM course
WHERE credits > 3;

SELECT * FROM classroom
WHERE building in ('Watson', 'Packard');

SELECT * FROM course
WHERE dept_name = 'Comp. Sci.';

SELECT course.course_id, course.title, course.dept_name, course.credits, section.semester FROM course, section
WHERE course.course_id = section.course_id AND section.semester = 'Fall';

SELECT * FROM student
WHERE tot_cred BETWEEN 46 AND 89;

SELECT * FROM student
WHERE name SIMILAR TO '%[aeuioy]';

SELECT course.course_id, prereq.prereq_id, course.title, course.dept_name, course.credits FROM course, prereq
WHERE course.course_id = prereq.course_id AND prereq.prereq_id = 'CS-101';

SELECT dept_name, avg(salary) as average_salary from instructor
GROUP BY dept_name ORDER BY avg(salary) ASC;

SELECT building, count(course.course_id) as number_of_courses FROM course, department
WHERE course.dept_name = department.dept_name
GROUP BY building ORDER BY count(course.course_id) DESC LIMIT 1; -- FETCH FIRST 1 ROWS ONLY

SELECT department.dept_name, count(course.course_id) as number_of_courses FROM course, department
WHERE course.dept_name = department.dept_name
GROUP BY department.dept_name ORDER BY count(course.course_id);

SELECT dept_name, count(course_id) FROM course
GROUP BY dept_name
HAVING count(course_id) = (SELECT min(cnt) FROM (select count(course_id) as cnt FROM course GROUP BY dept_name) as min_cnt);

SELECT student.id, name, count(course_id) FROM student, takes
WHERE student.id = takes.id AND student.dept_name = 'Comp. Sci.'
GROUP BY student.id, student.name
HAVING count(course_id) > 3;

SELECT * FROM instructor
WHERE dept_name in ('Philosophy', 'Biology', 'Music');

SELECT * FROM instructor
WHERE name not in (SELECT instructor.name FROM instructor, teaches
WHERE instructor.id = teaches.id AND teaches.year = 2017 AND teaches.year <> 2018);

SELECT DISTINCT student.id, student.name, student.dept_name, course.title, takes.grade FROM student, takes, course
WHERE student.id = takes.id AND takes.course_id = course.course_id AND course.dept_name = 'Comp. Sci.' AND takes.grade in ('A-', 'A')
ORDER BY student.name ASC;

SELECT DISTINCT advisor.s_id, advisor.i_id, student.name FROM advisor, student, takes
WHERE takes.id = advisor.s_id AND student.id = takes.id AND takes.grade not in ('B','B+','A-','A');

SELECT DISTINCT dept_name FROM course
WHERE dept_name not in (SELECT dept_name FROM course, takes
WHERE course.course_id = takes.course_id AND takes.grade in ('F','C'));

SELECT DISTINCT * FROM instructor
WHERE name not in (SELECT instructor.name FROM takes, teaches, instructor
WHERE takes.course_id = teaches.course_id AND teaches.id = instructor.id AND takes.grade = 'A');

SELECT DISTINCT course.title, time_slot.end_hr, time_slot.end_min FROM course, section, time_slot
WHERE course.course_id = section.course_id AND section.time_slot_id = time_slot.time_slot_id AND section.time_slot_id in ('A','B','C');
