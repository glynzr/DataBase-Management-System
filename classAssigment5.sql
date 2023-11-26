--  Create students table;
create table students(
    student_id int auto_increment primary key,
    name varchar(255),
    surname varchar(255),
    age int,
    department varchar(255),
    gpa float(10,2),
    birth_city varchar(255)
);

create index birth_city
on students(birth_city);

-- Insert 20 records into the table;
INSERT INTO students (name, surname, age, department, gpa, birth_city) VALUES
    ('John', 'Doe', 22, 'Computer Science', 78.5, 'New York'),
    ('Alice', 'Smith', 21, 'Mathematics', 85.2, 'Los Angeles'),
    ('Michael', 'Johnson', 23, 'Physics', 64.7, 'Chicago'),
    ('Emily', 'Williams', 20, 'Biology', 92.0, 'San Francisco'),
    ('Daniel', 'Brown', 22, 'Chemistry', 76.3, 'Houston'),
    ('Sophia', 'Jones', 21, 'Computer Science', 83.1, 'Philadelphia'),
    ('Oliver', 'Garcia', 24, 'Mathematics', 74.9, 'Phoenix'),
    ('Emma', 'Martinez', 20, 'Physics', 61.5, 'San Antonio'),
    ('William', 'Lopez', 22, 'Biology', 88.2, 'San Diego'),
    ('Ava', 'Gonzalez', 21, 'Chemistry', 89.5, 'Dallas'),
    ('James', 'Rodriguez', 23, 'Computer Science', 73.4, 'San Jose'),
    ('Mia', 'Hernandez', 20, 'Mathematics', 76.6, 'Austin'),
    ('Benjamin', 'Perez', 22, 'Physics', 67.2, 'Jacksonville'),
    ('Charlotte', 'Torres', 21, 'Biology', 78.7, 'Fort Worth'),
    ('Elijah', 'Ramirez', 23, 'Chemistry', 71.5, 'Columbus'),
    ('Amelia', 'Flores', 20, 'Computer Science', 93.2, 'Charlotte'),
    ('Lucas', 'Rivera', 22, 'Mathematics', 82.4, 'Indianapolis'),
    ('Harper', 'Long', 21, 'Physics', 87.6, 'Seattle'),
    ('Ethan', 'Diaz', 24, 'Biology', 63.9, 'Denver'),
    ('Liam', 'Nguyen', 22, 'Chemistry', 84.8, 'Washington');


-- Display (name, surname) as concatted string, age, birthcity from STUDENTS
select concat(name,' ',surname) as student_name,age,birth_city from students;

-- Display (surname (1 character), name, age) as concatted string, birthcity from STUDENTS ;
select concat(substring(surname,1,1),'.',name,' ',age) as student,birth_city from students;

-- Display (surname (1 character), name) as concatted string, birthcity fileds and group records by birthcity;
select group_concat(concat(substring(surname,1,1),'.',name)) as student,birth_city from students
group by birth_city;

-- Display (surname (1 character), name, age) as concatted string,
-- department fileds and group records by department;
select group_concat(concat(substring(surname,1,1),'.',name,' ',age)),department
from students
group by department;

-- Display minimum, maximum and average gpa’s of students
select min(gpa) as min_gpa,max(gpa) as max_gpa,avg(gpa) as average_gpa from students;

-- Display students where students gpa is higher than the average gpa
select concat(surname,' ',name) as studen,gpa from students
where gpa> (select avg(gpa) from students);

-- Display count of students for each department;
select department,count(name) as student_count
from students
group by department;

-- Display average gpa of students for each birtcity;
select birth_city, round(avg(gpa),2) as average_gpa
from students
group by birth_city;

-- Display (name, surname) as concatted string, department, and gpa (like:
-- A(gpa>=91), B(gpa>=81), C(gpa>=71), D(gpa>=61)
select concat(surname,' ',name) as student,department,
case 
    when gpa>=91 then 'A'
    when gpa>=81 then 'B'
    when gpa>=71 then 'C'
    when gpa>=61 then 'D'
end as gpa
from students;