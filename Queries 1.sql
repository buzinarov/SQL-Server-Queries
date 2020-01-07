--week 2
use university

select	*
from	instructor;

select	*
from	teaches

select	*
from	instructor, teaches --product (combination) of the rows from the previous tables
--where	instructor.ID = Teaches.ID;


select	name
from	instructor
where	name like '%and%';

--Concatenate

select	concat(name, '+', dept_name)
from	instructor;


-- some more string functions
select	lower(name), upper(name), len(name), substring(name, 1, 3) as initial3
from	instructor;


--Find the courses that ruin in fall 2009 or spring 2010 set operations question 3
select	Distinct course_id, semester
from	teaches as t join instructor as i
on		t.ID = i.ID
where	(semester = 'Fall' and year = 2009)
or		(semester ='Spring' and year = 2010);


-- use union
select	course_id
from	section
where	semester = 'Spring' and year = 2010
union --if add "all" is going to show everthing, union apply distinct automatically
(select	course_id
from	section
where	semester = 'Fall' and year = 2009);

--finde the courses that ruin in both fall 2009 and spring 2010
-- the follow not working

select				course_id
from				section
where				semester = 'Fall' and year = 2009
and					semester = 'Spring' and year = 2010;


-- use intersect
select	course_id
from	section
where	semester = 'Fall' and year = 2009
intersect
select	course_id
from	section
where	semester = 'Spring' and year = 2010;

-- find the courses that ruin in fall 2009 but not in spring -- EXCEPT command
(select	course_id
from	section
where	semester = 'Fall' and year = 2009)
except
(select	course_id
from	section
where	semester = 'Spring' and year = 2010);


--find the salaries of all instructors that are lower than the highest salary
(select	distinct	salary
from				instructor)
except
(select	max(salary)
from instructor);



--work with null
select 5+null;
select 5*null;

--use is null to compare with null;
-- whenever has a True is going to be true: "or" operation F or T = T, T or T = T/// "and" operation T and X = UNKNOWN, T and T = T, T and F = F, F and F = F
-- If the value is unknown the where clause will consider it as false.


-- find the total number of instructors who teach a course in Spring 2010.
select	count(distinct ID) AS InstructorNumber
from	teaches
where	semester = 'Spring' and year = 2010;


-- Find the average salary of instructors in each department
select dept_name, avg(salary) as SalaryAVG
from instructor
group by dept_name;

--common error
select dept_name, ID, avg(salary) as SalaryAVG
from instructor
group by dept_name;



--find the names and average salaries of all departments whose average salary is higher than 42000

select dept_name, avg(salary) as SalaryAVG
from instructor
group by dept_name
having avg(salary) > 42000;


-- Finde the titles of courses in the comp sci department that have 3 credits
select	title
from	course
where	dept_name like 'Comp%' and credits = 3;

-- find the highest salary of any instructor
select max(salary) as SalaryMax
from instructor;

-- find all instructors earning the highest salary
select	ID, name, salary 
from	instructor
where	salary = (select max(salary)
				from instructor);


-- find the enrollment of each section that was offered in Spring 2009
select section.course_id, section.sec_id, count(ID)
from	section join takes 
			on section.year = takes.year
			and section.semester = takes.semester
			and section.course_id = takes.course_id
			and section.sec_id = takes.sec_id
where		section.semester = 'spring'
and			section.year = 2009
group by			section.course_ID, section.sec_id

-- find courses ran in both Fall 2009 and Spring 2010
select	course_id
from	section
where	semester = 'Fall' and year = 2009
	and course_id in
					(select	course_id
					from	section
					where semester = 'Spring' and year = 2010);


-- find courses that ran in Fall 2009 but not in Spring 2010
select	course_id
from	section
where	semester = 'Fall' and year = 2009
	and course_id not in
					(select	course_id
					from	section
					where semester = 'Spring' and year = 2010);


-- find instructors with salary higher than that of at least one instructor in the Physics department
select	name
from	instructor
where	salary >	(select min(salary)
					from instructor
					where	dept_name = 'Physics');

--An equivalent query to the previous
select	name
from	instructor
where	salary > some (select	salary
						from	instructor
						where	dept_name = 'Physics');


--find the names of instructors with salary higher than that of all instructor in the Computer Science department

select	name
from	instructor
where	salary > (select max(salary)
					from	instructor
					where	dept_name = 'Comp. Sci.');

select	name, dep
from	instructor
where	salary > all (select salary
					from	instructor
					where	dept_name = 'Comp. Sci.');


-- use exist
-- find courses that run in both Fall 2009 and Spring 2010
select	course_id
from	section as S
where	semester = 'Fall' and year = 2009 and
		exists (select	*
				from	section	as	T
				where	semester = 'Spring' and year = 2010
				and S.course_id = T.course_id);

--not exists
select	course_id
from	section as S
where	semester = 'Fall' and year = 2009 and
		not exists (select	*
					from	section	as	T
					where	semester = 'Spring' and year = 2010
					and S.course_id = T.course_id);


-- find those departments where the average salary is grater than 42000
select	dept_name, avg_salary
from	(select dept_name, avg(salary) as avg_salary
		 from instructor
		 group by	dept_name) as dept_avg
where	 avg_salary > 42000;



-- list all departments along with the number of instructors in each
select	dept_name, (select	count(*) 
					from	instructor
					where	department.dept_name = instructor.dept_name)
					as	num_instructors
from	department;





--MICHAEL

--- List all dept along with the number of instructors in each 
select dept_name,(select count(*)
                  from instructor
				  where department.dept_name = instructor.dept_name)
				  as num_instructors
from department;



with avg_budget(value) as
(select avg(budget)
from department)
select department.dept_name
from department, avg_budget
where department.budget > avg_budget.value;
--List all departments along with the number of instructors in each department
select dept_name, COUNT(*) as Num_Instructors
from instructor
group by dept_name

--- Use Begin Tran
begin tran
update instructor
	set salary = salary*1.03
	where salary > 90000

rollback;

select salary
from instructor
order by salary asc;

select distinct (name)
from student join takes
 on student.ID = takes.ID
 join course
  on takes.course_id = course.course_id
where course.dept_name = 'Comp. Sci';



begin tran
insert into course
	values('CS-001', 'Weekly Seminar', 'Comp.Sci', 2)



--increase the salary of instructor in CS by 10%
begin tran
update instructor
set  salary = salary * 1.10
where dept_name = 'Comp. Sci'
--- Insert Every student with total credit > 100 as instrctor in the same department, with a salary of 30,000
begin tran
insert into instructor
select ID, name, dept_name, 30000
from student
where tot_cred > 100;
rollback