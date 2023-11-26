-- here we will use azerbaijan db 

-- each region and its division count
select region, count(division_name) as division_count from administrative_divisions
group by region;

-- listing each region and its divisions
select region,group_concat(division_name separator ',') as divisions from administrative_divisions 
group by region;

-- finding total population of each region
select region,sum(population) as total_population from administrative_divisions
group by region;

-- finding the region that have minimum population
select region,total_population as min_total_population
from(
    select region,sum(population) as total_population
    from administrative_divisions
    group by region
) as subquery 
order by total_population
limit 1;

-- get areas, which greater than average area of regions
select * from administrative_divisions
where area> (select avg(area) from administrative_divisions);

-- selecting the regions which have divisions more than 5
-- method 1
select region,count(division_name) as divisions
from administrative_divisions
group by region
having divisions>=5;

-- method 2
select tbl.region,tbl.count
from(
    select region,count(*) as count from administrative_divisions group by region
) as tbl
where tbl.count>=5;

-- Create a report combining division_name and capital columns with a comma separator.
select CONCAT(division_name,',',capital) as capitals from administrative_divisions;

-- Shorten division_name to the first ten characters followed by an ellipsis.
select concat(
    SUBSTRING(division_name,1,10),'....'
) as division_name
from administrative_divisions;

-- Abbreviate division_name and capital columns to the first three characters followed by an ellipsis.
select CONCAT(SUBSTRING(division_name,1,3),'...') as division_name,
concat(SUBSTRING(capital,1,3),'...') as capital from administrative_divisions;

-- Replace instances of 'A' in the capital column with 'AAA'.
select REPLACE(capital,'A','AAA') as capital from administrative_divisions;

-- Generate sentences stating "My favorite city is [CAPITAL]" in uppercase letters.
select concat('My favourite city is ',UPPER(capital)) from administrative_divisions;

-- stored procedures
-- Get all details of region by given region name(use in keyword)
DELIMITER $$
CREATE PROCEDURE region_detail(in region varchar(255))
BEGIN
    select * from regions
    where region_name=region;
END $$
DELIMITER ;

call region_detail('Aran');

-- Get all cities by given 'region name'.
DELIMITER $$
CREATE PROCEDURE get_cities(in name varchar(255))
BEGIN
    select region,group_concat(capital) as cities
    from administrative_divisions
    group by region
    having region=name;
END $$
DELIMITER ;

-- IN and OUT parameters: Get total number of cities by given region name.
DELIMITER $$
CREATE PROCEDURE get_city_count(in name varchar(255), out count int)
BEGIN 
        select count(capital) as city_count into count
        from administrative_divisions
        group by region
        having region=name;
END $$
DELIMITER ;

call get_city_count('Aran',@count);
select @count;

-- INOUT parameter : Get total number of all divisions by given region name.
select count(division_name) from administrative_divisions group by region;

set @total=0;
DELIMITER $$
CREATE PROCEDURE total_divisions(IN name varchar(255),INOUT total int(10))
BEGIN 
    select count(division_name) into total from administrative_divisions group by region having region=name;
END $$
DELIMITER ;


-- IN and multiply OUT parameters :
-- 'Get the <total sum of population> and <total area> of each region'
DELIMITER $$
CREATE PROCEDURE total_area_population(in name varchar(255),out place FLOAT(10,2), out people int(10))
BEGIN
    select sum(population) into people
    from administrative_divisions
    where  region=name;

    select sum(area) into place
    from administrative_divisions
    where region=name;
END $$
DELIMITER ;

call total_area_population('Aran',@place,@people);
select @place,@people;

-- IN and multiply OUT parameters :
-- 'Get the <min area> and the <max area> of given region'
DELIMITER $$
CREATE PROCEDURE min_max_area(in name varchar(255),out min_ FLOAT(10,2),out max_ FLOAT(10,2))
BEGIN
    select min(area) into min_ from administrative_divisions
    where region=name;

    select max(area) into max_ from administrative_divisions
    where region=name;
END $$
DELIMITER ;

-- IN and multiply OUT parameters :
-- 'Get the <min area with division name> and the <max area with division name> of given region'
DELIMITER $$
CREATE PROCEDURE min_max_division(
    in name varchar(255),
    out min_area varchar(255),
    out max_area varchar(255)
)
BEGIN
    select concat(division_name,' ',area) into min_area
    from administrative_divisions
    order by area
    limit 1;

    select concat(division_name,' ',area) into max_area
    from administrative_divisions
    order by area desc
    limit 1;
END $$
DELIMITER ;

call min_max_division('Aran',@min_area,@max_area);
select @min_area,@max_area;

show procedure status ;

-- stored function
DELIMITER $$
CREATE FUNCTION area_size(
    region_area float(10,2)
)
RETURNS varchar(50)
DETERMINISTIC
BEGIN 
    DECLARE size varchar(50);
    IF region_area>20000 THEN set size='big';
    ELSEIF region_area>10000 THEN set size='medium';
    ELSE set size='small';
    END IF;
    RETURN size;
END $$
DELIMITER ;

SELECT region_name, area_size(area) as size from regions;

-- 'Return regions by area percentage'
DELIMITER $$
CREATE FUNCTION region_percentage(
    region_area float(10,2),
    total float(10,2)
)
RETURNs float(10,2)
DETERMINISTIC
BEGIN
    DECLARE percentage float(10,2);
    set percentage=(region_area/total)*100.00;
    return percentage;
END $$
DELIMITER ;

select region_name,region_percentage(area,(select sum(area) from regions)) as percentage from regions;