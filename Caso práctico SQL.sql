--a) Crear la base de datos con el archivo create_restaurant_db.sql
--LISTO
--b) Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM menu_items

--1.- Realizar consultas para contestar las siguientes preguntas:
SELECT * FROM menu_items

--● Encontrar el número de artículos en el menú.
--RESPUESTA: 32
SELECT COUNT (menu_item_id)
FROM menu_items

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
-- RESPUESTA: Shrimp Scampi $19.95 es el más caro.
-- RESPUESTA: Edamame $5.00 es el más barato.
SELECT * FROM menu_items
ORDER BY (price) DESC
LIMIT 1

SELECT * FROM menu_items
ORDER BY (price) ASC
LIMIT 1

--● ¿Cuántos platos americanos hay en el menú?
--RESPUESTA: Hay 6 platos americanos.
SELECT COUNT (menu_item_id), Category
FROM menu_items
GROUP BY category

--● ¿Cuál es el precio promedio de los platos?
--RESPUESTA: El promedio es 13.28593750
SELECT AVG(price)
FROM menu_items

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
SELECT * FROM order_details

--1.- Realizar consultas para contestar las siguientes preguntas:
--● ¿Cuántos pedidos únicos se realizaron en total?
-- RESPUESTA: Son 5,370 pedidos únicos.
SELECT COUNT (DISTINCT (order_id))
FROM order_details

--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
-- RESPUESTA: Los pedidos 440, 2675, 3473, 4305 y 443, con 14 artículos cada uno.
SELECT * FROM order_details

SELECT COUNT (order_details_id), order_id
FROM order_details
GROUP BY order_id
ORDER BY (count) DESC
LIMIT 5

--● ¿Cuándo se realizó el primer pedido y el último pedido?
--RESPUESTA: El primer pedido se realizó el "2023-01-01" a las 11:38:36 hrs.
--RESPUESTA: El último pedido se realizó el "2023-03-31" a las 22:15:48 hrs.
SELECT * FROM order_details 
ORDER BY (order_date) ASC, (order_time) ASC

SELECT * FROM order_details 
ORDER BY (order_date) DESC, (order_time) DESC

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
--RESPUESTA: 702 pedidos.
SELECT COUNT (order_details_id) AS "Total de pedidos entre 2023-01-01 y 2023-01-05"
FROM order_details
WHERE (order_date) BETWEEN DATE'2023-01-01' AND DATE'2023-01-05'

--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
--1.- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT * FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id= order_details.item_id

SELECT menu_items.menu_item_id, 
	order_details.item_id
FROM menu_items
LEFT JOIN order_details
ON menu_items.menu_item_id=order_details.item_id

/*e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las preguntas planteadas, realiza un análisis adicional utilizando 
este join entre las tablas. El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del restaurante en el lanzamiento de su 
nuevo menú. Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a estas conclusiones.*/
SELECT * FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id

SELECT COUNT (order_id), item_name
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY item_name
ORDER BY count DESC

SELECT COUNT (order_id), item_name
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY item_name
ORDER BY count ASC

SELECT SUM (price), item_name
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY item_name
ORDER BY sum DESC

SELECT SUM (price), item_name
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY item_name
ORDER BY sum ASC

SELECT SUM (price), order_date
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY order_date
ORDER BY sum ASC

SELECT SUM (price), order_date
FROM menu_items
INNER JOIN order_details
ON menu_items.menu_item_id = order_details.item_id
GROUP BY order_date
ORDER BY sum DESC

/*Contexto: Se presenta un análisis de un restaurante de comida internacional, para evaluar los puntos fuertes del local y los puntos de oportunidad
que existen. Este restaurante cuenta con información suficiente para hacer un análisis general de la situación actual, identificando sus categorías, 
lo más vendido, lo menos vendido y los precios de los platillos.

Puntos clave: 
1- El restaurante recaudó menos fondos el 2023-03-22 y el día que más se recauda es el 2023-02-01. 
2- La hamburguesa es el platillo más vendido. 
3- Por su parte, los chickes tacos son el platillo menos vendido, seguido por los potstickers.
4- Los mayores ingresos son por el platillo korean beef bowl.
5- El platillo que deja menores ingresos es el chicken tacos, seguido del platillo potstickers.

Conclusión: 
Despúes de análizar lo anterior, se concluyó que Chicken tacos y potstickers siendo los productos menos vendidos y que menos ingresos obtienen, se quiten 
del menú y se agreguen nuevos platillos para que estén a prueba durante un periodo y se realice nuevamente el estudio de análisis.
se considere un nuevo platillo de ser necesario. Además, viendo que la hamburguesa es el platillo más vendido, se recomienda subir ligeramente el precio 
de este artículo, suponiendo una demanda inelastica, esto obtendría mayores ganancias.
