CREATE TABLE suppliers (
        supplierID  INT UNSIGNED  NOT NULL AUTO_INCREMENT, 
        name        VARCHAR(30)   NOT NULL DEFAULT '', 
        phone       CHAR(8)       NOT NULL DEFAULT '',
        PRIMARY KEY (supplierID)
);

CREATE TABLE products (
        productID    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
        productCode  CHAR(3)       NOT NULL DEFAULT '',
        name         VARCHAR(30)   NOT NULL DEFAULT '',
        supplierID   INT UNSIGNED  NOT NULL,
        quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
        price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
        PRIMARY KEY  (productID)
);

ALTER TABLE products
       ADD FOREIGN KEY (supplierID) REFERENCES suppliers (supplierID);

INSERT INTO suppliers VALUES
        (1, 'ABC Traders', '88881111'), 
        (2, 'OYAL', '99442222'), 
        (3, 'MR Fix', '90055333'),
        (4, 'Coloritm', '99455333');

INSERT INTO products (productCode, name, supplierID, quantity, price) VALUES
        ('PEC', 'Pencil 2B', 1, 10000, 0.48),
        ('PEC', 'Pencil 2H', 1, 8000, 0.49),
        ('PEN', 'Pen Red', 1, 12000, 1.20),
        ('PEN', 'Pen Blue', 2, 12500, 1.15),
        ('PEN', 'Pen Black', 2, 13000, 1.00),
        ('PPR', 'A4', 4, 500, 4.50),
        ('PPR', 'A5', 4, 800, 5.50),
        ('PPR', 'A3', 2, 740, 8.00),
        ('PPR', 'A2', 2, 250, 10.00),
        ('PEC', 'Pencil Color Set N50', 3, 1000, 25.50),
        ('PEC', 'Pencil Color Set N25', 1, 1100, 20.50),
        ('PEC', 'Pencil Color Set N10', 1, 700, 10.00),
        ('BLK', 'Blackboard 2 x 1.5', 2, 210, 20.00),
        ('BLK', 'Blackboard 1 x 0.5', 3, 200, 12.00),
        ('BLK', 'Blackboard 0.5 x 0.2', 2, 400, 6.00);

-- TASKS:
--------------------------------------------------------------
--  1.Create procedure, to get `total sum of quantities` of all products by product code (use IN);  [1.4]
DELIMITER $$
CREATE procedure sum_quantity(in code char(3))
BEGIN   
    SELECT SUM(quantity) from products where productCode=code;
END $$
DELIMITER ;

call sum_quantity('PEC');

--  2.Create procedure, to count of all products and total sum of all (quantities)products by each suppliers (use IN, OUT);  [1.4]
DELIMITER $$
CREATE PROCEDURE suppliers_pro(in supplier varchar(30),out count_pro int UNSIGNED,out count_qua int UNSIGNED)
BEGIN 
    SELECT COUNT(productID) into count_pro as all_products
    from products left join suppliers
    using(supplierID) where supplier=suppliers.name;

    SELECT SUM(quantity) into count_qua as all_quantities
    from products left join suppliers
    using(supplierID) where supplier=suppliers.name;
END $$
DELIMITER ;

call suppliers_pro('OYAL',@count_pro,@count_qua);
select @count_pro,@count_qua;


--  3.Create a procedure to group products by productCode and displaying all products in a line, 
--     separating by comma, and displaying counts of products (use IN);  [1.5]
DELIMITER $$
CREATE PROCEDURE list_products(in code char(3))
BEGIN
        SELECT productCode,group_concat(name),count(name) from products
        group by productCode having productCode=code;
END $$
DELIMITER ;
-- 4.Create function, which will return `high price` or `low price` according to (if `total price` > average(price) ). 
--     Write a simple query to use the function;  [1.4]
DELIMITER $$
CREATE FUNCTION price_type(
        price DECIMAL(7,2),
        average decimal(7,2)
)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
        DECLARE result varchar(50);
        IF price> average THEN SET result='high price';
        ELSE SET result='low price';
        END IF;
        RETURN result;
END $$
DELIMITER ;

select productID,name,price_type(price, (select avg(price) from products)) as type from products;

--  5.Create function, which will return (display) total cost of each product by percentage;
--     Write a simple query to use the function;  [1.5]
DELIMITER $$
CREATE FUNCTION percentage(
        quantity int unsigned,
        price decimal(7,2),
        total_price decimal(10,2)
)
RETURNS decimal(7,2)
DETERMINISTIC
BEGIN
        DECLARE result decimal(7,2);
        set result= ((quantity*price)/total_price)*100;
        return result;
END $$
DELIMITER ;

select name, percentage(quantity,price,(select sum(quantity*price) from products)) as percentage from products;


-- 6.Create after delete trigger to store (OLD) deleted product record with the current datetime;  [1.4]
create table deleted(
        id int AUTO_INCREMENT PRIMARY KEY,
        productID    INT UNSIGNED  NOT NULL ,
        productCode  CHAR(3)       NOT NULL DEFAULT '',
        name         VARCHAR(30)   NOT NULL DEFAULT '',
        supplierID   INT UNSIGNED  NOT NULL,
        quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
        price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
        deleted_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER deleted_product
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO deleted(productID,productCode,name,supplierID,quantity,price)
    VALUES (OLD.productID,OLD.productCode,OLD.name,OLD.supplierID,OLD.quantity,OLD.price);
END $$
DELIMITER ;

DELETE FROM products
WHERE productID=1;

--  7.Create after update trigger to store (OLD) updated product record with the current datetime;  [1.4]
create table updated(
        id int auto_increment primary key,
        productID    INT UNSIGNED  NOT NULL ,
        productCode  CHAR(3)       NOT NULL DEFAULT '',
        name         VARCHAR(30)   NOT NULL DEFAULT '',
        supplierID   INT UNSIGNED  NOT NULL,
        quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
        price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
        updated_item VARCHAR(255),
        updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

DELIMITER $$
CREATE TRIGGER updated_product
AFTER UPDATE ON products
FOR EACH ROW 
BEGIN
        INSERT INTO updated(productID,productCode,name,supplierID,quantity,price,updated_time)
        VALUES (OLD.productID,OLD.productCode,OLD.name,OLD.supplierID,OLD.quantity,OLD.price,NOW());
END $$
DELIMITER ;

