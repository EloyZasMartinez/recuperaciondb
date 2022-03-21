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

-- 4.- ¿Que persona (ID y nombre) interpretó al personaje más alto?

-- 5.- ID y Nombre de los capitulos en los que se menciona 'Playa de Cangrejos Gigantes'

-- 6.- ¿Cuantas anecdotas hay que estuvieran en 'Catedral Del Dolor'?

-- 7.- ID y Nombre de los personajes que estuvieron en 'Catedral Del Dolor'

-- 8.- Estatura media de los Elfos (Todas las clases, salvo Noldor)

-- 9.- ¿Que persona ha mencionado más anecdotas del capitulo 'Cap 06'?

-- 10.- ¿Que razas se han casado más veces?

-- 11.- ¿Cual es la media de fuerza de los guerreros?

-- 12.- ¿Cual es la media de lugares por capitulo? 
-- (Revisar las anecdotas que SI estuvieron en algún capitulo)

-- 13.- ¿Que personaje estuvo en más anecdotas?

-- 14.- ¿Hubo algún personaje que no esté en ningún capitulo?

-- 15.- ¿Que raza de personaje es más bajo de media?