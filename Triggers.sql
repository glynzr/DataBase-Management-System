-- task 1
DROP TABLE IF EXISTS members;
CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

/* Second, create another table called reminders that stores reminder 
messages to members. */

DROP TABLE IF EXISTS reminders;
CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

/* The following statement creates an AFTER INSERT trigger that inserts 
a reminder into the reminders table if the birth date of the member is NULL. */
DELIMITER $$
CREATE TRIGGER remind_birthday
AFTER INSERT ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
    INSERT INTO (memberId,message)
    values 
    (NEW.id,CONCAT(new.name,',enter you birthdate'));
    END IF;
END $$
DELIMITER ;

--  task 2
-- create after insert trigger: After setting password change it after 30 days!
create table members(
    id int auto_increment PRIMARY KEY,
    name varchar(255),
    email varchar(255),
    password varchar(255)
);

create table reminders(
    id INT auto_increment PRIMARY key,
    memberId int,
    expiry_date DATE,
    CONSTRAINT memberId FOREIGN KEY (memberId)
    REFERENCES members(id)
);

DELIMITER $$
CREATE TRIGGER expiry_date
AFTER INSERT ON members
FOR EACH ROW 
BEGIN
    insert into reminders(memberId,expiry_date)
    values 
    (new.id,DATE_ADD(CURRENT_DATE(),INTERVAL 30 DAY));
END $$
DELIMITER ;


insert into members(name,email,password)
values
('John','john@gmail.com','112233');



-- task 3
DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

INSERT INTO Sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2001 Ferrari Enzo',140, 2021,1),
    ('1998 Chrysler Plymouth Prowler', 110,2021,1),
    ('1913 Ford Model T Speedster', 120,2021,1);

create table changes(
    id int auto_increment PRIMARY key,
    salesId int,
    oldquantity int,
    newquantity int,
    changedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create a trigger that stores the value of old and new quantites of the sales
DELIMITER $$
CREATE TRIGGER update_sales
AFTER UPDATE ON Sales
FOR EACH ROW
BEGIN 
    IF old.quantity <> new.quantity THEN
    insert into changes(salesId,oldquantity,newquantity)
    values
    (old.id,old.quantity,new.quantity);
    END IF;
END $$
DELIMITER ;

UPDATE Sales
SET quantity=350
WHERE id=1;


-- task 4
CREATE TABLE stores(
store_id BIGINT PRIMARY KEY AUTO_INCREMENT,
store_name VARCHAR(50)
);
INSERT INTO stores (store_name) VALUES ('Philadelphia');
INSERT INTO stores (store_name) VALUES ('Galloway');


CREATE TABLE products(
product_id BIGINT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(40),
cost_price DOUBLE,
retail_price DOUBLE,
availability VARCHAR(5)
);
INSERT INTO products (product_name, cost_price, retail_price, availability) 
VALUES 
('WIRELESS MOUSE', '18.23', '30.25','ALL'),
('8 MP CAMERA', '60.40', '85.40','ALL'),
('SMART WATCH', '189.60', '225.30','LOCAL');



CREATE TABLE price_changes(
    id int auto_increment primary key,
    product_id BIGINT,
    cost_price_old double,
    cost_price_new double,
    retail_price_old double,
    retail_price_new double,
    changedat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT product_id FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


/* BEFORE INSERT trigger: The trigger will make sure that the retail price 
of a product is greater than the cost price whenever items are inserted 
into the products table. Otherwise, the database user will get an error. */
DELIMITER $$
CREATE TRIGGER retail_price
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.cost_price>=NEW.retail_price
    THEN SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='The retail price should be greater than the cost price';
    END IF;
END $$
DELIMITER ;

/* BEFORE UPDATE trigger: This trigger will prevent database users from editing 
a product name once a product has been inserted into the database. */
DELIMITER $$
CREATE TRIGGER prevent_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN 
    IF OLD.product_name <> NEW.product_name
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='You can not update the product name';
    END IF;
END $$
DELIMITER ;

/* BEFORE DELETE trigger: Prevent users from deleting specific records from a table
where availability='ALL' */
DELIMITER $$
CREATE TRIGGER prevent_delete_availability
BEFORE DELETE ON products
FOR EACH ROW 
BEGIN
    IF OLD.availability='all' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='You can not delete the product with the availability all';
    END IF;
END $$
DELIMITER ;


/* AFTER UPDATE trigger: To keep track of price changes in our store over time. */
DELIMITER $$
create trigger follow_changes
AFTER UPDATE ON products
FOR EACH ROW
BEGIN 
    IF OLD.cost_price <>NEW.cost_price OR OLD.retail_price <> NEW.retail_price
    THEN 
    INSERT INTO price_changes(product_id,cost_price_old,cost_price_new,retail_price_old,retail_price_new)
    values 
        (old.product_id,old.cost_price,new.cost_price,old.retail_price,new.retail_price);
    END IF;
END $$
DELIMITER ;

UPDATE products
SET cost_price = 55.00, retail_price = 70.00
WHERE product_id = 1;



Create table `Student`-------------------------------------------------------- 

| Field | Type        | Null | Key | Default | Extra          | 
+-------+-------------+------+-----+---------+----------------+ 
| tid   | int(4)      | NO   | PRI | NULL    | auto_increment | 
| name  | varchar(30) | YES  |     | NULL    |                | 
| subj1 | int(2)      | YES  |     | NULL    |                | 
| subj2 | int(2)      | YES  |     | NULL    |                | 
| subj3 | int(2)      | YES  |     | NULL    |                | 
| total | int(3)      | YES  |     | NULL    |                | 
| per   | int(3)      | YES  |     | NULL    |                |
+-------+-------------+------+-----+---------+----------------

/* TASK:
Create a trigger in the student database in which whenever subjects marks are entered, 
before inserting this data into the database, trigger will compute those two values and 
insert with the entered values */

CREATE TRIGGER stud_marks 
BEFORE INSERT ON Student 
FOR EACH ROW 
SET Student.total = Student.subj1 + Student.subj2 + Student.subj3, 
    Student.per = Student.total * 60 / 100;


# test it
insert into Student values(0, "ABCDE", 20, 20, 20, 0, 0);