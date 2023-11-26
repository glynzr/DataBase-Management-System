-- grouping the states according to their join year
select join_year,group_concat(name) as state_names
from states
group by join_year;

-- counting the number of states according to their join year
select join_year,count(name) as state_count 
from states
group by join_year;

-- the state name that has minimum population
select name,join_year
from states
where population=(select min(population) from states);

-- Calculate the sum of the populations of all states.
select sum(population) as total_population from states;

-- Determine the count of states categorized 
-- as 'big' (population > 5 million) and 'small' (population <= 5 million).
select sum(
    if(population>5000000,1,0)
) as big_states,

sum(
    if(population<=5000000,1,0)
) as small_states
from states;

-- Classify states as 'big,' 'medium,' or 'small' based on population thresholds.
select count(name) as count,
case 
    WHEN population > 5000000 THEN 'big'
    WHEN population > 1000000 THEN 'medium'
    ELSE 'small'
end as state_size
from states
group by state_size;

-- Identify the state(s) with the highest population.
select name from states
where population= (select max(population) from states);

-- list the states that joined in years where more than one state joined.
SELECT COUNT(*) as count, join_year, GROUP_CONCAT(name) as names 
FROM states 
GROUP BY join_year 
HAVING count > 1;

-- Generate a combined list of states 
-- that either start with the letter 'N' or have a population exceeding 10 million.
select name from states where population>10000000
UNION
select name from states where name like 'N%';
