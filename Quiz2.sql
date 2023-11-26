-- Create database: “worldcountries”
create database worldcountries;

use worldcountries;

-- Create 3 tables with names: “countries”, “cities”, “continents”

create table continents(
    continent_id int auto_increment primary key,
    continent_name varchar(255)
);


create table countries(
    country_code varchar(255) primary key ,
    country_name varchar(255),
    continent_id int 
);

create table cities(
    city_id int auto_increment primary key,
    city_name varchar(255),
    country_code varchar(255),
    population int(10),
    year int(4),
    capital int(1) DEFAULT 0
);

-- ADD foreign key constraints like, { UPDATE RESTRICT AND DELETE NULL } and prove it by writing simple query.
ALTER TABLE countries
ADD CONSTRAINT continent_id 
FOREIGN KEY (continent_id)
REFERENCES continents(continent_id)
ON UPDATE RESTRICT 
ON DELETE SET NULL;

ALTER TABLE cities
ADD CONSTRAINT country_code
FOREIGN KEY (country_code)
REFERENCES countries(country_code)
ON UPDATE RESTRICT 
ON DELETE SET NULL;

show create table countries;
show create table cities;


update continents
set continent_id=6
where continent_id=1;

delete from countries
where country_code='TR';


-- Insert values into “continents” table like { Europe, Asia, Africa, America, Australia… }
insert into continents(continent_name)
values
('Europe'),
('Asia'),
('Africa'),
('America'),
('Australia'),
('Antarctida');

-- Insert 15 Countries into “countries” table, example { “TR”, “Turkey”, 1 }
insert into countries(country_code,country_name,continent_id)
values
("TR","Turkey",1),
("AZ","Azerbaijan",2),
("Ru","Russia",1),
("AU","Australia",5),
("SW","Sweden",1),
("IR","Iran",2),
("FR","France",1),
("SP","Spain",2),
("ARG","Argentina",4),
("BR","Brasil",4),
("VE","Venesuela",4),
("JP","Japan",2),
("CO","Congo",3),
("NG","Nigeria",3),
("KO","Korea",2);

--Insert 15 cities into “cities” table, example { “Istanbul”, “TR”, 954656, 1800, 0 }
insert into cities(city_name,country_code,population,year,capital)
values
("Istanbul","TR",100000,1800,0),
("Baku","AZ",3000000,1975,0),
("Moscow","RU",4000000,1050,1),
("Melburn","AU",5000000,300,0),
("Malmo","SW",7000000,1500,0),
("Tehran","IR",50000,1902,1),
("Paris","FR",500000,1450,1),
("Barcelona","SP",400000,1400,0),
("Karakas","VE",900000,1800,1),
("Buenos Aires","ARG",170000,1870,1),
("Rio","BR",900000,1700,0),
("Tokio","JP",8000000,1900,1),
("Bukavu","CO",80000,1600,0),
("Abuca","NG",100000,1500,0),
("Seul","KO",9154000,1940,1);

-- Write a query: Show “continent names” and “country names”.  
-- group by continents and put all country names in one row, adding separator sign by your choice. 
select continents.continent_name,group_concat(countries.country_name) as country_list
from continents
left join countries
using (continent_id)
group by continent_name;

-- Write a query: Show “country names” and “capital cities” only, using Left Join.
select countries.country_name,cities.city_name as capital_city
from countries
left join cities
using (country_code)
where cities.capital=1;

-- Write a query: Show “continent names”,  “cities” and total population of each continent. 
-- Group by continents, and put all city names in one row, adding separator sign by your choice.
select continents.continent_name,group_concat(tbl.city_name) as continent_cities,sum(tbl.population) as population
from continents
left join (
    select countries.country_name,cities.city_name,countries.continent_id,cities.population
    from countries
    left join cities
    using(country_code)
) as tbl
using (continent_id)
group by continent_name;



-- Write a query: Show “country names”, “city names”, “year”. 
-- Point out city like “ANCIENT” city if “year <= 1000”, “OLD” if year > 1000 && year <= 1900 and “MODERN” if city > 1900.
select countries.country_name,cities.city_name,cities.year,
case
    when cities.year>1900 then 'modern'
    when cities.year>1000 then 'old'
    else 'ancient'
end city_age
from countries
right join cities
using (country_code);

-- Write a query: Show “country names”, “country code”, “capital” and “count of cities”, “total population of cities”.
SELECT 
    countries.country_name,
    countries.country_code,
    SUM(cities.population) AS total_population,
    GROUP_CONCAT(IF(cities.capital = 1, cities.city_name, 'Not given')) AS capital_cities,
    group_concat(cities.city_name) as city,
    count(cities.city_name) as city_count
FROM countries
LEFT JOIN cities USING (country_code)
GROUP BY countries.country_name, countries.country_code;
