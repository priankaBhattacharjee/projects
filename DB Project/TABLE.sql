drop table profile;
create table profile(
	roll number(10),
	first_name varchar(30),
	last_name varchar(30),
	address varchar(50),
	contact_no number(30),
	email varchar(50),
	website varchar(50),
       constraint pk primary key(roll)
);
drop table student;
create table student(
	roll_no number(10) NOT NULL, 
	cgpa number(3,2) check(cgpa > 2.0 and cgpa < 4.0),
	thesis_topic varchar(100),
	backlog_courses_no number(2),
	speciality varchar(100),
	foreign key(roll_no) references profile(roll) ON DELETE CASCADE
);
drop table degree;
create table degree(
	roll_no number(10),
	university varchar(100),
	subject varchar(100),
	country varchar(20),
	GRE_score number(4),
	foreign key(roll_no) references profile(roll) ON DELETE CASCADE
);
drop table profession;
create table profession(
	roll_no number(10),
	job_title varchar(30),
	company varchar(100),
	type_of_job varchar(100),
	salary number(10),
	foreign key(roll_no) references profile(roll) ON DELETE CASCADE
);
DROP TABLE PROFILE_BACKUP;
CREATE TABLE PROFILE_BACKUP AS SELECT* FROM PROFILE WHERE 1 = 2;
commit;
--AUDIT TABLE
DROP TABLE PAUDIT; 
CREATE TABLE PAUDIT(
	NEW_NAME VARCHAR(50),
	OLD_NAME VARCHAR(50),
	USERNAME VARCHAR(50),
	ENTRY_DATE VARCHAR(50),
       	OPERATION VARCHAR(50)
);
CREATE VIEW REALITY AS
SELECT ROLL, CGPA, BACKLOG_COURSES_NO, SPECIALITY, JOB_TITLE, SALARY, COUNTRY FROM PROFILE, STUDENT, PROFESSION, DEGREE; 
--insertion of attributes in the table

insert into profile values(1307011,'Prianka','Bhatt','Khulna', 01962860040, 'bprianka14@gmail.com', 'battwordprocess14.com');
insert into profile values(1307012,'Parisha','Ahmed','Dhaka', 01728137216, 'parishaahmed@gmail.com', 'facebook.com');
insert into profile values(1307013, 'Nur', 'Haque', 'Dhaka', 0193, 'nothing', 'facebook.com');
insert into profile values(1307014, 'Tajul', 'Islam', 'Norshingdi', 019, 'nothing', 'whatsapp.com');

insert into student values (1307011,3.31,'DatabaseDesign', 0, 'ContestProgrammer');
insert into student values (1307012,2.90,'SoftwareDesign', 1, 'SoftwareDeveloper');


insert into degree values(1307012,'Stanford','Algorithm', 'England', 330);
insert into degree values(1307011,'Yale','Hardware', 'USA', 320);

insert into profession values(1307011, 'SoftwareEngineer', 'Samsung','fulltime', 45000);
insert into profession values(1307012,'SoftwareEngineer','Tiger IT','fulltime', 55000);

commit;
