-- SE DEBE EDITAR ESTE FICHERO Y AÑADIR LAS CONSULTAS SQL QUE RESUELVAN LA PREGUNTA
-- <= Estos guiones son comentarios en el fichero, para que se pueda ejecutar directamente
-- tambien se usan para que los editores de texto como sublimeText reconozcan la sintaxis SQL


-- Se debe poner tambien el resultado que devuelva la consulta (usar los guiones para no estropear el fichero)
-- En caso que sea un listado, vale con el primer resultado y el numero de elementos que devuelve la consulta

-- EJEMPLO

-- ¿Cuantos capitulos hay?
SELECT COUNT(*) FROM capitulos;
-- 6


-- CONSULTAS DEL EXAMEN:

-- 1.- Lugares que estuvieran en anecdotas en las que se mencione un 'Dragon'

SELECT nombre FROM lugares WHERE id IN
    ( SELECT id_lugar FROM mn_lugares_anecdota WHERE id_anecdota IN
        ( SELECT id FROM anecdotas where
            (anecdotas.description LIKE "% Dragon %" )));

--Taberna 7º cielo 19 filas

-- 2.- ID y Nombre de las razas que hayan sido 'Guerrero'
SELECT id,nombre FROM raza WHERE id IN 
    (SELECT DISTINCT id_raza FROM personaje WHERE id_trabajo IN
        (SELECT id FROM trabajo where nombre="Guerrero"));

-- 1 elfo  4 filas

-- 3.- ID y Nombre de los personajes que tuvieron 'Pareja'

SELECT id,nombre FROM personaje WHERE id IN 
    (SELECT id_personaje from relacion WHERE id_tipo_relacion IN
        (SELECT id FROM tipo_relacion WHERE nombre = "pareja"));

--1 chorvitta, 11 filas

-- 4.- ¿Que persona (ID y nombre) interpretó al personaje más alto?

SELECT id, nombre FROM persona WHERE id IN
    (SELECT id_persona FROM personaje WHERE id=
        (SELECT id from carasteristicas_fisicas WHERE altura IN 
            (SELECT MAX(altura)FROM carasteristicas_fisicas WHERE id IN
                (SELECT personaje.id FROM personaje JOIN carasteristicas_fisicas cf ON personaje.id_fisicas = cf.id))));

--5 Becky


-- 5.- ID y Nombre de los capitulos en los que se menciona 'Playa de Cangrejos Gigantes'

SELECT id,titulo FROM capitulos WHERE id IN 
    ( SELECT id_capitulo FROM mn_anecdota_capitulo WHERE id_anecdota IN 
        ( SELECT id FROM anecdotas where 
            (anecdotas.description LIKE "% Playa de Cangrejos Gigantes %" )));
            
--sin resultado

SELECT id,titulo FROM capitulos WHERE id IN
    (SELECT id_capitulo FROM mn_anecdota_capitulo WHERE id_anecdota IN 
        (SELECT id FROM anecdotas WHERE id IN 
            ( SELECT id_anecdota FROM mn_lugares_anecdota WHERE id_lugar IN 
                ( SELECT id FROM lugares where nombre="Playa De Cangrejos Gigantes"))));


--id 1008 Cap 02 unica fila 


-- 6.- ¿Cuantas anecdotas hay que estuvieran en 'Catedral Del Dolor'?
SELECT COUNT(id) FROM anecdotas WHERE id IN 
    ( SELECT id_anecdota FROM mn_lugares_anecdota WHERE id_lugar IN 
        ( SELECT id FROM lugares where nombre="Catedral Del Dolor"));

--3


-- 7.- ID y Nombre de los personajes que estuvieron en 'Catedral Del Dolor'

SELECT id,nombre from personaje WHERE id IN 
    (SELECT id_personaje FROM mn_personaje_anectdota WHERE id_anecdota IN 
        (SELECT id FROM anecdotas WHERE id IN 
            ( SELECT id_anecdota FROM mn_lugares_anecdota WHERE id_lugar IN 
                ( SELECT id FROM lugares where nombre="Catedral Del Dolor"))));

--1 chorvitta 11 filas

-- 8.- Estatura media de los Elfos (Todas las clases, salvo Noldor)




-- 9.- ¿Que persona ha mencionado más anecdotas del capitulo 'Cap 06'?

-- 10.- ¿Que razas se han casado más veces?

-- 11.- ¿Cual es la media de fuerza de los guerreros?

SELECT AVG(fuerza) FROM caracteristicas_rol WHERE id IN
    (SELECT id_rol from personaje where id_trabajo IN 
        (SELECT id FROM trabajo WHERE nombre="Guerrero"));

--692.8000

-- 12.- ¿Cual es la media de lugares por capitulo? 
-- (Revisar las anecdotas que SI estuvieron en algún capitulo)

-- 13.- ¿Que personaje estuvo en más anecdotas?


SELECT COUNT(id_personaje),id_personaje FROM mn_personaje_anectdota WHERE mn_personaje_anectdota.id_anecdota IN 
    (SELECT id from anecdotas)
        GROUP BY id_personaje ORDER BY COUNT(id_personaje) DESC LIMIT 2;
--empate entre el personaje con id 15 y 18


-- 14.- ¿Hubo algún personaje que no esté en ningún capitulo?
SELECT id FROM personaje WHERE id NOT IN 
    ( SELECT id_personaje FROM mn_personaje_capitulo);


--no hay 


-- 15.- ¿Que raza de personaje es más bajo de media?
SELECT raza.nombre, avg(cf.altura) as media FROM personaje LEFT JOIN raza on raza.id = personaje.id_raza LEFT JOIN carasteristicas_fisicas cf ON cf.id = personaje.id_fisicas group by raza.id order by media ASC limit 1;

--wose