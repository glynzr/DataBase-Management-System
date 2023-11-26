-- here we use university database

create database university;
use university;


create table student(
    student_id int auto_increment primary key,
    student_name varchar(255),
    student_surname varchar(255),
    entry_year int,
    major varchar(255)
);


create table course(
    course_id int auto_increment primary key,
    course_name varchar(255)
);


create table teacher(
    teacher_id int auto_increment primary key,
    teacher_name varchar(255),
    teacher_surname varchar(255),
    department varchar(255)
);


create table enrollment(
    student_id int,
    course_id int,
    teacher_id int,
    year int,
    term ENUM('spring','autumn'),

    CONSTRAINT student_id
    FOREIGN KEY student_id (student_id)
    REFERENCES student(student_id),

    CONSTRAINT course_id
    FOREIGN KEY course_id (course_id)
    REFERENCES course(course_id),

    CONSTRAINT teacher_id
    FOREIGN KEY teacher_id (teacher_id)
    REFERENCES teacher(teacher_id)
);


INSERT INTO student (student_name, student_surname, entry_year, major)
VALUES 
    ('John', 'Doe', 2021, 'Computer Science'),
    ('Alice', 'Smith', 2020, 'Biology'),
    ('Emma', 'Johnson', 2019, 'Mathematics'),
    ('Michael', 'Williams', 2022, 'Engineering'),
    ('Sophia', 'Brown', 2020, 'Psychology'),
    ('James', 'Jones', 2021, 'History'),
    ('Olivia', 'Garcia', 2023, 'Chemistry'),
    ('Ethan', 'Martinez', 2018, 'Physics'),
    ('Ava', 'Anderson', 2022, 'Sociology'),
    ('William', 'Wilson', 2019, 'English');


INSERT INTO course (course_name)
VALUES 
    ('Introduction to Programming'),
    ('Biology 101'),
    ('Linear Algebra'),
    ('Mechanical Engineering Fundamentals'),
    ('Cognitive Psychology'),
    ('World History'),
    ('Organic Chemistry'),
    ('Physics for Engineers'),
    ('Sociology of Culture'),
    ('English Literature');


INSERT INTO teacher (teacher_name, teacher_surname, department)
VALUES 
    ('Professor Smith', 'Johnson', 'Computer Science'),
    ('Dr. Anderson', 'Williams', 'Biology'),
    ('Professor Brown', 'Davis', 'Mathematics'),
    ('Dr. Wilson', 'Miller', 'Engineering'),
    ('Professor Taylor', 'Moore', 'Psychology'),
    ('Dr. Martinez', 'Garcia', 'History'),
    ('Professor Lee', 'Thompson', 'Chemistry'),
    ('Dr. Clark', 'Hernandez', 'Physics'),
    ('Professor Turner', 'Perez', 'Sociology'),
    ('Dr. White', 'Adams', 'English');


INSERT INTO enrollment (student_id, course_id, teacher_id, year, term)
VALUES 
    (1, 1, 1, 2021, 'spring'), (2, 2, 2, 2021, 'autumn'), (3, 3, 3, 2021, 'spring'), (4, 4, 4, 2021, 'autumn'), (5, 5, 5, 2021, 'spring'),
    (6, 6, 6, 2021, 'autumn'), (7, 7, 7, 2021, 'spring'), (8, 8, 8, 2021, 'autumn'), (9, 9, 9, 2021, 'spring'), (10, 10, 10, 2021, 'autumn'),
    (1, 2, 1, 2022, 'spring'), (2, 3, 2, 2022, 'autumn'), (3, 4, 3, 2022, 'spring'), (4, 5, 4, 2022, 'autumn'), (5, 6, 5, 2022, 'spring'),
    (6, 7, 6, 2022, 'autumn'), (7, 8, 7, 2022, 'spring'), (8, 9, 8, 2022, 'autumn'), (9, 10, 9, 2022, 'spring'), (10, 1, 10, 2022, 'autumn'),
    (1, 3, 1, 2023, 'spring'), (2, 4, 2, 2023, 'autumn'), (3, 5, 3, 2023, 'spring'), (4, 6, 4, 2023, 'autumn'), (5, 7, 5, 2023, 'spring'),
    (6, 8, 6, 2023, 'autumn'), (7, 9, 7, 2023, 'spring'), (8, 10, 8, 2023, 'autumn'), (9, 1, 9, 2023, 'spring'), (10, 2, 10, 2023, 'autumn'),
    (1, 4, 1, 2024, 'spring'), (2, 5, 2, 2024, 'autumn'), (3, 6, 3, 2024, 'spring'), (4, 7, 4, 2024, 'autumn'), (5, 8, 5, 2024, 'spring'),
    (6, 9, 6, 2024, 'autumn'), (7, 10, 7, 2024, 'spring'), (8, 1, 8, 2024, 'autumn'), (9, 2, 9, 2024, 'spring'), (10, 3, 10, 2024, 'autumn'),
    (1, 5, 1, 2025, 'spring'), (2, 6, 2, 2025, 'autumn'), (3, 7, 3, 2025, 'spring'), (4, 8, 4, 2025, 'autumn'), (5, 9, 5, 2025, 'spring'),
    (6, 10, 6, 2025, 'autumn'), (7, 1, 7, 2025, 'spring'), (8, 2, 8, 2025, 'autumn'), (9, 3, 9, 2025, 'spring'), (10, 4, 10, 2025, 'autumn');


-- TASK 1:
-- Modify Enrollment (stud_ID, course_ID, teacher_ID) foreign keys to
-- UPDATE RESTRICT DELETE CASCADE
-- prove restrictions by using queries

show create table enrollment;

alter table enrollment
drop foreign key student_id;

alter table enrollment
drop foreign key teacher_id;

alter table enrollment
drop foreign key course_id;

alter table enrollment
add CONSTRAINT student_id
foreign key (student_id)
REFERENCES student(student_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

alter table enrollment
add CONSTRAINT course_id
foreign key (course_id)
REFERENCES course(course_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

alter table enrollment
add CONSTRAINT teacher_id
foreign key (teacher_id)
REFERENCES teacher(teacher_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- when we update student_id in parent table(student), it will automatically change in child table(enrollment)
update student
set student_id=11
where student_id=10;

-- TASK 2:
-- Query: Display all students list (sample: A.Alisoy, B.Valiyov) 
-- by each course, count of students, order by count 
select tbl.course_id,tbl.course_name,count(tbl.enrolled_student) as student_count,group_concat(tbl.enrolled_student) as students_name
from (
    select enrollment.course_id,course.course_name,concat(substring(student.student_name,1,1),'.',student.student_surname) as enrolled_student
    from enrollment
    left join course
    using(course_id)
    left join student
    using(student_id)
) as tbl
group by tbl.course_id
order by student_count;

-- TASK 3:
-- Query: Display all cource list (sample: Computer Graphics, Math) 
-- by each student, count of courses
select tbl.student_id,tbl.enrolled_student,count(tbl.course_name) as course_count,group_concat(tbl.course_name) as courses_list
from (
    select enrollment.student_id, concat(substring(student.student_name,1,1),'.',student.student_surname) as enrolled_student,course.course_name
    from enrollment
    left join student
    using (student_id)

    left join course
    using (course_id)
) as tbl
group by tbl.student_id;


-- TASK 4:
-- Query: Display list of all students (sample: A.Alisoy, B.Valiyov)
-- by year, count of students
select entry_year,group_concat(concat(substring(student_name,1,1),'.',student_surname)) as student_list,count(student_name) as student_count
from student
group by entry_year;


-- TASK 5:
-- Query: Display count of teachers by each term and also list of
-- teachers (sample: A.Alisoy, B.Valiyov)
select tbl.term,group_concat(tbl.teacher_name) as teachers, count(tbl.teacher_name) as teacher_count
from (
    select distinct teacher.teacher_name,enrollment.term
    from teacher
    left join enrollment
    using (teacher_id)
) as tbl
group by term;



-- Alter Table to Add Column
ALTER TABLE enrollment
ADD COLUMN score DECIMAL(5, 2);

-- Update Rows with Random Scores
UPDATE enrollment
SET score = ROUND(RAND() * 100, 2);

-- Task: Procedures
-- Try to list all courses of student into one line and also average score by given student (use IN arg)
DELIMITER $$
CREATE PROCEDURE student_course(in id int)
BEGIN
    select * from
        (select tbl.student_id,tbl.enrolled_student,group_concat(tbl.course_name) as courses,round(avg(tbl.score),2)
            from(
                    select student.student_id,concat(substring(student.student_name,1,1),'.',student.student_surname) as enrolled_student,course.course_name,enrollment.score
                    from student
                    left join enrollment
                    using (student_id)
                    left join course
                    using(course_id)
                ) as tbl
            group by student_id) as sub
    where sub.student_id=id;
END $$
DELIMITER ;

-- Try to give count of students by given cource name (use IN argument).
DELIMITER $$
CREATE PROCEDURE get_course(in name varchar(255))
BEGIN
    select * from
    (
        select course.course_name,count(enrollment.student_id) as student_count
        from course
        left join enrollment
        using (course_id)
        group by course_name
    ) as tbl
    where course_name=name;
END $$
DELIMITER ;

call get_course('Linear Algebra');

-- Try to give count of courses and also list of all cources by given teacher name (use IN argument)
DELIMITER $$
CREATE PROCEDURE teacher_course(in name varchar(255))
BEGIN 
    select * from(
        select teacher.teacher_name,count(enrollment.course_id) as course_count,group_concat(course.course_name)as courses_list
        from teacher
        left join enrollment
        using(teacher_id)

        left join course
        using (course_id)
        group by teacher_name
    ) as tbl
    where tbl.teacher_name=name;
END $$
DELIMITER ;


call teacher_course('Professor Brown');

-- Try to list names of teachers and also count of teachers by given department (use IN argument)
DELIMITER $$
CREATE PROCEDURE department_staff(in name varchar(255))
BEGIN 
    select department, count(teacher_id) as teacher_count,group_concat(teacher_name) as teachers 
    from teacher
    group by department
    having department=name;
END $$
DELIMITER;

call department_staff('Physics');



