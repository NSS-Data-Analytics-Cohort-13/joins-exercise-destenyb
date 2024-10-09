--q1
SELECT film_title, release_year, worldwide_gross
FROM specs AS sp
INNER JOIN revenue AS rev
ON sp.movie_id = rev.movie_id
ORDER BY worldwide_gross ASC;
-- answer:Semi-Tough, 1977, 37187139

--q2
SELECT release_year, AVG(imdb_rating) AS avg_rating
FROM specs AS sp
INNER JOIN rating AS rate
ON sp.movie_id = rate.movie_id
GROUP BY sp.release_year
ORDER BY avg(imdb_rating) DESC;
-- answer: 1991

--q3
SELECT company_name, mpaa_rating, worldwide_gross, film_title
FROM distributors AS dist
INNER JOIN specs AS sp
ON dist.distributor_id = sp.domestic_distributor_id
INNER JOIN revenue AS rev
ON sp.movie_id = rev.movie_id
WHERE sp.mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;
-- answer: Toy Story 4, Walt Disney

--q4
SELECT distributor_id, company_name, count(movie_id)
FROM distributors AS dist
LEFT JOIN specs AS sp
ON sp.domestic_distributor_id = dist.distributor_id
GROUP BY dist.company_name

--q5
SELECT company_name, round(avg(film_budget),2) AS avg_budget
FROM distributors AS dist
INNER JOIN specs AS sp
ON sp.domestic_distributor_id = dist.distributor_id
INNER JOIN revenue AS rev
ON sp.movie_id = rev.movie_id
GROUP BY company_name
ORDER BY avg_budget DESC
LIMIT 5;
-- answer: Walt Disney, Sony, Loinsgate, Dreamworks, Warner Bros.

--q6
SELECT film_title, imbd_rating, headquarters
FROM distributors AS dist
INNER JOIN specs AS sp
ON dist.distributor_id = sp.domestic_distributor_id
INNER JOIN rating AS rate
USING(movie_id)
WHERE headquarters NOT ILIKE '%, CA%'
ORDER BY imdb_rating DESC;


--q7
SELECT 
	CASE WHEN length_in_min >=0 AND length_in_min <=120 THEN 'Under 2 Hours' 
	ELSE 'Over 2 Hours'
	END AS length_range, 
	AVG(r.imdb_rating) as avg_rating
FROM specs as s
LEFT JOIN rating as r
USING(movie_id)
GROUP BY length_range
ORDER BY avg_rating DESC;
-- answer: over 2 hours = 7.25, under 2 hours = 6.91