use project2;
select * from netflix_data;

-- What	is	the	total	number	of	'Movies'	and	'TV	Shows'	on	Netflix?
select type,
       count(type) as count
from netflix_data
group by type
order by count desc;

-- Which	country	has	produced	the	most	content	(Movies	+	TV	Shows)	on	Netflix? List	the top	5	countries.

select country,
       count(type) as count
from netflix_data
where country is not null and trim(country) <> ""
group by country
order by count desc;

-- Retrieve	a	list	of	all	movies	and	TV	shows	released	in	the	year	2020.
select title,type,release_year from netflix_data
where release_year=2020

-- What	are	the	titles	of	all	movies	directed	by	'Kirsten	Johnson'?
Select title,
       director
from netflix_data
where director="Kirsten Johnson" and type="Movie" ;

-- Which	content	rating	is	the	most	common	on	Netflix?	(Count	of	titles	by	rating).
select rating,
      count(rating) as count
from netflix_data
group by rating
order by count desc
limit 1;

-- Find	the	list	of	all	'TV	Shows'	that	have	5	or	more	seasons.
select title,
       type,
       duration
from netflix_data
where cast(substring_index(duration,' ',1)as unsigned) >=5 and type="TV Show"
order by cast(substring_index(duration,' ',1)as unsigned) desc;

-- List	all	the	movies	produced	in	'India'	that	belong	to	the	'Comedies'	category.
select title,
	   country,
       listed_in
from netflix_data
where country like "%India%" and 
      listed_in like "%Comedies%" and
      type="Movie";

-- How	many	new	shows/movies	were	released	each	year?	Sort	the	results	in	descending order	of	the	release	year.
select release_year,
       count(title) as count
from netflix_data
group by release_year
order by count desc;

-- Who	are	the	top	5	directors	with	the	highest	number	of	directed	movies?
select director,
       count(title) as count
from netflix_data
where type="Movie"
group by director
order by count desc;

-- In	which	year	did	Netflix	add	the	highest	amount	of	content	to	its	platform?
select release_year,
       sum(cast(substring_index(duration," ",1)as unsigned)) as max_duration
from netflix_data
group by release_year
order by max_duration desc;

select release_year,
       count(title) as content
from netflix_data
group by release_year
order by content desc;

-- Which	are	the	5	oldest	movies	released	in	India	on	Netflix?
select title,
       release_year
from netflix_data
where country like "%India%" and type="Movie"
order by release_year
limit 5;

-- Find	the	titles	of	all	movies	listed	as	'Documentaries'	that	were	released	after	the year	2015.
select title,
       listed_in,
       release_year
from netflix_data
where listed_in like "%Documentaries%" and release_year >= 2015 and type="Movie";

-- Which	movie	has	the	longest	duration	in	minutes	on	Netflix?
select title,
       cast(substring_index(duration,' ',1)as unsigned) as max_duration
from netflix_data
order by max_duration desc
limit 1;

-- What	is	the	most	recently	released	movie	for	each	country?
SELECT n.country,
       n.title,
       n.release_year
FROM netflix_data n
JOIN (
    SELECT country,
           MAX(release_year) AS latest_year
    FROM netflix_data
    GROUP BY country
) m
ON n.country = m.country
AND n.release_year = m.latest_year;

--  Identify	the	release	years	in	which	more	than	5	movies	from	United	States	were	released.
SELECT release_year,
       COUNT(title) AS content_count
FROM netflix_data
WHERE country = 'United States'
GROUP BY release_year
HAVING COUNT(title) >= 5
ORDER BY content_count DESC;





      
