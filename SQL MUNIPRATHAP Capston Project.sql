-- Capston Project---
use sakila;
-- Task1: Display the full name of actors available in the database ---
select * from actor;
select concat(first_name," ", last_name) as "Full Name" from actor; 

-- Task2.1: Display the number of times each firstname apperars in the database ---
select first_name, count(first_name) as "Count" from actor  group by first_name;

-- Task2.2: What is the count of actors that have unique first names in the database, display first name of all these actors ----
select first_name, count(first_name) as "Count" from actor 
group by first_name having count(first_name)=1;


-- Task3.1: Display the number of times each last name appears in the database ---
select last_name, count(last_name) as "Count" from actor
group by last_name;

-- Task3.2: Display all unique last names in the database
select last_name, count(last_name) as "Count" from actor
group by last_name having count(last_name)=1;


-- Task4.1: Display the list of records for the movies with rating "R" ---
select title, rating from film where rating = "R";

-- Task4.2: Display the list of records for the movies that are not rated "R" ---
select title, rating from film where rating != "R";

-- Task4.3: Display the list of records for the movies that are suitable for audience below 13 year of age ---
select title from film where rating = "PG" or rating = "PG-13";


-- Task5.1: Display the list of records fro the movies where the replacement cost is up to $11 ---
select title, replacement_cost from film  where replacement_cost<=11;

-- Task 5.2: Display the list of records for the movies where the replacement cost is between $11 and $20.
select title, replacement_cost from film where replacement_cost >=11 and replacement_cost <=20;

-- Task 5.3: Display the list of records for all movies in descending order of their replacement costs ---
select title, replacement_cost from film order by replacement_cost desc;



-- Task6: Display the names of the top 3 movies with the greatest number of actors --
select title, count(*) as Actor_count from film
join film_actor on film.film_id = film_actor.film_id group by title order by Actor_count desc limit 3;


-- Task7: Display the movies starting with the letters k and Q ---
select title from film where title like 'K%' or title like 'Q%';


-- Task8: The film 'Agent Truman' has been a great success, display the names of all actors who appeared in this film --
select concat( first_name , ' ', last_name) as 'Actors' from actor
join film_actor ON actor.actor_id = film_actor.actor_id
join film ON film_actor.film_id = film.film_id
where film.title ='Agent Truman';



-- Task9:Identify all the movies categorized as family films --
select film.title as 'Family Movie' from film
inner join film_category  on film_category.film_id = film.film_id
inner join category on film_category.category_id = category.category_id where name in ('Family'); 


-- Task10.1: Display the max, min and average rental rates ofmovies based on their ratings and display the out as descending order of average rental rates --
select rating, MAX(rental_rate) as max_rental_rate, MIN(rental_rate) as min_rental_rate, avg(rental_rate) as avg_rental_rate
from film group by rating 
order by avg_rental_rate desc;

-- Task10.2: Display the movies in descending order of their rental frequencies, so the mangement can maintain more copies of those movies --
select film.title, COUNT(rental.rental_id) as rental_frequency from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by  rental_frequency desc;



-- Task11: display the catgeory names , differnece between avg replacement cost and avg of rental rate ---
select category.name, avg(replacement_cost) as 'Avg Replacement_cost',Avg(rental_rate) as 'Avg Rental_rate', 
(avg(replacement_cost)-avg(rental_rate)) as " Difference"
from film inner join film_actor on film_actor.film_id = film.film_id
inner join category on film_actor.actor_id = category.category_id group by name having (AVG(replacement_cost)-AVG(rental_rate)) >15;



-- Task12:Display the film categories in which the number of movies is gretaer than 70 ---
select name,count(film_category.category_id) from film_category
inner join category on category.category_id = film_category.category_id
group by name having count(film_category.category_id)> 70;