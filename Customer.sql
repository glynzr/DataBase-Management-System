-- GET COUNT OF CUSTOMERS BY EACH COUNTRY WHERE "COUNT > 10"
select count(customerName) as count ,country from customers
group by country
having count>10;

-- USING SIMPLE IF : to return N/A if the state is NULL
-- method 1
select customerName,city,country,
if(state is null,'N/A',state) as state 
from customers;

-- method 2
select customerName,city,country,
case 
    when state is null then 'N/A'
    else state
end as state
from customers;

-- to sort customers by states if the state is not NULL,  or sort the country in case the state is NULL"
-- "USING ORDER BY WITH CASE
-- method 1
select * from customers
order by (
    case
        when state is null then country
        else state 
    end 
);

-- method 2

select * from customers
order by if(state is null,country,state);

-- Select customers and creditLimit, name creditLimit AS 'HIGH' IF > 20000.00 ELSE 'LOW'
select customerName,IF(creditLimit>20000,'HIGH','LOW') as creditLimit from customers; 

-- Find customers whose creditLimit are greater than the average of creditLimit, using a subquery
select customerName from customers
where creditLimit> (select avg(creditLimit) from customers);

-- 