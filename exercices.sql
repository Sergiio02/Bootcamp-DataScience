
--Ejercicios DataProject

--1. Crea el esquema de la BBDD

/* 
 1. Crear nueva base de datos 
 2. Abrir la BD proporcionada y ejecutarla
 3. Refresh y analizar el esquema haciendo clic en public -> ver esquema
 */


--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ

select "title" as "Film title"
from "film"
where "rating" = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

select concat("first_name", ' ', "last_name") as "Actor name"
from "actor"
where "actor_id" between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.

select "film_id", "title"
from "film"
where "language_id" = "original_language_id";

--todos los campos de original language id son nulls

--5. Ordena las películas por duración de forma ascendente.

select "film_id", "title", "length"
from "film"
order by "length" asc;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

select concat("first_name", ' ', "last_name") as "Actor name"
from "actor"
where "last_name" = 'ALLEN';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

select "rating", count("film_id") as "number of films"
from "film"
group by "rating";

--8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

select "title"
from "film"
where "rating" = 'PG-13' or "length" < 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select round(stddev("replacement_cost"),2) as "Variability of the cost of replacing the movies"
from "film";

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select max("length") as "maximun length", min("length") as "minimum length"
from film;

--11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select p."amount" as "cost of the third-to-last rental"
from "rental" r inner join "payment" p on p."rental_id" = r."rental_id"
order by "rental_date" desc
limit 1 offset 1;

--12 Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.

select "title"
from "film"
where "rating" not in ('G', 'NC-17');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select "rating", round(avg("length"),2) as "Average length"
from film
group by "rating";

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select "title"
from "film"
where "length"> 180;

--15. ¿Cuánto dinero ha generado en total la empresa?

select round(sum("amount"),2) as "total amount of money earned"
from "payment";

--16. Muestra los 10 clientes con mayor valor de id.

select "customer_id", concat("first_name", ' ', "last_name") as "Customer name"
from "customer"
order by "customer_id" desc 
limit 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

--opcion 1
select a."first_name", a."last_name" 
from "actor" a 
	inner join "film_actor" fa 
		on a."actor_id" = fa."actor_id"
	inner join "film" f
		on fa."film_id" = f."film_id"
where f."title" = 'EGG IGBY';

--opcion 2 
select a."first_name", a."last_name" 
from "actor" a 
	inner join "film_actor" fa 
		on a."actor_id" = fa."actor_id"
where fa."film_id" = (select "film_id"
						from film f where "title" = 'EGG IGBY')	;
					
--18. Selecciona todos los nombres de las películas únicos.
					
select count(distinct("title")) as "distinc film names"
from "film";
--comprobando la respuesta con un count normal, todos los títulos son únicos 

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

select f."title"
from "film" f 
	inner join "film_category" fc on fc."film_id" = f."film_id"
	inner join "category" c on c."category_id" = fc."category_id"
where c."name" = 'Comedy' and f."length" > 180;

--opcion 2 
select f."title"
from "film" f 
	inner join "film_category" fc on fc."film_id" = f."film_id"
where fc."category_id" in (select "category_id"
							from "category" 
							where "name" = 'Comedy')
					   and f."length" > 180;
	
--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

select "rating", round(avg("length"),2) as "lenght average"
from "film"
group by "rating"
having avg("length") > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?

select avg("return_date" - "rental_date") as " Average rental duration"
from "rental"

--24. Encuentra las películas con una duración superior al promedio.

select "title", "length"
from "film"
where "length" > (select avg("length") from film);

--25. Averigua el número de alquileres registrados por mes.

select count("rental_id") as "number of rentals", extract(month from "rental_date") as mes
from "rental"
group by "mes"


--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select round(avg("amount"),2) as "average money paid", round(stddev("amount"),2) as "variability of money paid", round(variance("amount"),2) as "variance of money paid"
from "payment";

--27. ¿Qué películas se alquilan por encima del precio medio?


select i."film_id"
from "inventory" i 
	inner join "rental" r 
		on i."inventory_id" = r."inventory_id"
	inner join "payment" p 
		on p."rental_id" = r."rental_id"
where p."amount" > (select avg("amount")
					from "payment");

--si quisieramos el title juntariamos con otro join la tabla film 
				
--28.
