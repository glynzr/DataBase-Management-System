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
