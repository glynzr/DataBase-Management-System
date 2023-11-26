create database papers;
use papers;


CREATE TABLE students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50)
);

CREATE TABLE paper(
    title VARCHAR(100) PRIMARY KEY,
    grade INT,
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
    ON DELETE CASCADE 
    ON UPDATE CASCADE 
); 


INSERT INTO students (firstName) VALUES 
    ('Roya'), 
    ('Emiliya'), 
    ('Ilkay'), 
    ('Sevilay'), 
    ('Lisa');
     
INSERT INTO paper (student_id, title, grade ) VALUES
    (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (3, 'Introduction to Programming', 94),
    (3, 'The history of Ottoman Empiry', 98),
    (4, 'Magical Realism', 89);