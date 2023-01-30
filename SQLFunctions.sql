/*--FUNCTIONS 
--format: name_of_function(input)

*/
show databases;
use albums_db;
describe albums;
/*Count
select count(name) from albums;
--Numerial Functions
min, max, avg*/

select min(release_date) as min_release_date, 
max(release_date), 
avg(release_date),
round(avg(release_date), 1) -- chained two functions
from albums;

select concat('hello', 'world', '!') as helloworld;
select concat('my favorite artist is ', artist, '!');
select concat(artist, ' -- ', name) as artist_allbum, release_date
from albums;

-- Substr: extracts a portion of element
-- format: SUBSTRING(string, start, length)

select substr('hello oneil class', 7,5) ;
select susbstr('hello oneil class', 7);
select substr(release_date, 3,2 ), release_date
from albums;

-- Case conversion
select artist, upper(artist), lower(artist), release_date
from albums;

-- Replace: replace an element with something esle
-- format: REPLACE(string, from_string, new_string)

select REPLACE('hello oneil class!', 'oneil', 'O\'Neil');

select genre,
replace(lower(genre), 'rock', '***ROCK***') as genre_ROCKS
from albums;

-- TIME AND DATE FUNCTIONS -- 
select now();
select current_date();
select curdate();
select curtime();

select database(); 
select now(), current_date(), curtime();
select now(), convert_tz(now), '+00:00', '-6:00'; -- central time zone 

-- CASTING -- change datatype of vairable 
-- format: CAST(value as)

select 1 + '2'; -- generally dont need to cast datatypes in mysql
select month ('2023-01-23');


