select* from profile;
SELECT * FROM tab;
DESCRIBE student;

ALTER TABLE profession ADD ID NUMBER(20);
DESCRIBE profession;
ALTER TABLE profession MODIFY ID VARCHAR(20);
DESCRIBE profession;

ALTER TABLE degree
	RENAME COLUMN country to nation;
DESCRIBE degree;
ALTER TABLE degree
	RENAME COLUMN nation to country;

select* from degree;
UPDATE degree SET GRE_score = 310 WHERE roll_no = 1307012;
select* from degree;

SELECT type_of_job, salary FROM profession WHERE salary IN (45000, 50000);
SELECT roll_no, speciality FROM student ORDER BY roll_no, cgpa DESC;
SELECT MAX(cgpa) FROM student;

Describe profession;
SELECT COUNT(*), COUNT(salary) FROM profession;
SELECT COUNT(*), SUM(salary), AVG(salary) FROM profession;

--SET OPERATIONS

SELECT FIRST_NAME FROM PROFILE WHERE ROLL IN (SELECT ROLL_NO FROM DEGREE UNION SELECT ROLL_NO FROM PROFESSION);
SELECT LAST_NAME FROM PROFILE WHERE ROLL IN (SELECT ROLL_NO FROM STUDENT MINUS SELECT ROLL_NO FROM DEGREE MINUS SELECT ROLL_NO FROM PROFESSION);
SELECT ROLL_NO FROM DEGREE INTERSECT SELECT ROLL_NO FROM PROFESSION WHERE SALARY >= 50000;
