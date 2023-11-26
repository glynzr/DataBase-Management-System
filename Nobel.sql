-- creating database
create database nobel;

-- connecting to database
use nobel;

-- creating table
create table nobel_winners(
    year int,
    subject varchar(255),
    winner varchar(255),
    country varchar(255),
    category varchar(255)
);

-- inserting new records to the table
insert into nobel_winners
values 
(1970,'Physics','Hannes Alfven','Sweden','Scientist'),
(1970,'Physics','Louis Neel','France','Scientist'),
(1970,'Chemistry','Luis Federico Leloir','France','Scientist'),
(1970,'Physiology','Ulf von Euler','Sweden','Scientist'),
(1970,'Physiology','Bernard Katz','Germany','Scientist'),
(1970,'Literature','Aleksandr Solzhenitsyn','Russia','Linguist'),
(1970,'Economics','Paul Samuelson','USA','Economist'),
(1970,'Physiology','Julius Axelrod','USA','Scientist'),
(1971,'Physics','Dennis Gabor','Hungary','Scientist'),
(1971,'Chemistry','Gerhard Herzberg','Germany','Scientist'),
(1971,'Peace','Willy Brandt','Germany','Chancellor'),
(1971,'Literature','Pablo Neruda','Chile','Linguist'),
(1971,'Economics','Simon Kuznets','Russia','Economist'),
(1978,'Peace','Anwar al-Sadat','Egypt','President'),
(1978,'Peace','Menachem Begin','Israel','Prime Minister'),
(1987,'Chemistry','Donald J. Cram','USA','Scientist'),
(1987,'Chemistry','Jean-Marie Lehn','France','Scientist'),
(1987,'Physiology','Susumu Tonegawa','Japan','Scientist'),
(1994,'Economics','Reinhard Selten','Germany','Economist'),
(1994,'Peace','Yitzhak Rabin','Israel','Prime Minister'),
(1987,'Physics','Johannes Georg Bednorz','Germany','Scientist'),
(1987,'Literature','Joseph Brodsky','Russia','Linguist'),
(1987,'Economics','Robert Solow','USA','Economist'),
(1994,'Literature','Kenzaburo Oe','Japan','Linguist');

-- a SQL query to display the Nobel prizes for 1970
select * from nobel_winners where year=1970;

-- a SQL query to know the winner of the 1971 prize for Literature
select winner from nobel_winners where year=1971 and subject='Literature';

-- a SQL query to display the year and subject that won 'Dennis Gabor' his prize
select year,subject,winner from nobel_winners where winner='Dennis Gabor';

-- a SQL query to give the name of the 'Physics' winners since the year 1950
select winner from nobel_winners where subject='Physics' and year>=1950;

-- a SQL query to Show all the details (year, subject, winner, country) of the Chemistry prize winners between the year 1965 to 1975 inclusive
select * from nobel_winners where subject='Chemistry' and year>=1965 and year<=1975;

--a SQL query to show all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin
select * from nobel_winners where category='Prime Minister' and year>1972;

-- a SQL query to show all the details of the winners with first name Louis.
select * from nobel_winners where substring(winner,1,5)='Louis';

-- a SQL query to find all details of the prize won by Johannes Georg Bednorz
select * from nobel_winners where winner='Johannes Georg Bednorz';

-- a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last
select * from nobel_winners where year=1970 ORDER BY subject DESC,winner ;

