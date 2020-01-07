use University

select *
from  instructor;
-- show dept name
Select  dept_name
from instructor;

-- use ditinct 
Select distinct dept_name
from instructor;


--sshow the name and monthly salary 
select name, salary/12 as monthlysalary
from instructor;

-- Show Instructor from computer scienece dept whose salary > 70000
select *
from instructor
where dept_name = 'Comp. Sci.' and  salary > 70000;


-- Work On mUltiple Tables
--show the instructors and the course_ID they teach
select *
from instructor join teaches
on instructor.ID = teaches.ID;


--Show the INstructors and Course ID From Biology Department
select name, course_id
from instructor join teaches
on instructor.ID = teaches.ID
where dept_name = 'Biology'


--Order the Instructor Based on the salary in the ascending order
select *
from instructor
order by salary asc;


-- order the instructor based on salary in the descending order
select *
from instructor
order by salary desc;

-- show the instructor with salary between 90000 and 100000
select *
from instructor
where salary between 90000 and 100000;


-- string ops, find the instructors whose name contain 'and'
select name
from instructor
where name like '%and%';
-- select highest and maximum values
select max(salary) as highestsalary , avg(salary) as Maximumsalary
from instructor;


--- count the number of rows in the instructor relations
select count(*) as numberofrows
from instructor;

-- 
select *
from instructor join teaches
on instructor.ID = teaches.ID
where semester = 'spring' and year = 2010;

select count (distinct ID)
from teaches 
where semester = 'spring' and year = 2010;