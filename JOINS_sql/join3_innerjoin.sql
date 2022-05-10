-- 1. Devuelve un listado con el identificador, nombre y los 
-- apellidos de todos los clientes que han realizado algún pedido. 
-- El listado debe estar ordenado alfabéticamente y se deben 
-- eliminar los elementos repetidos.

SELECT c.id, c.nombre, c.apellido1, c.apellido2 
FROM cliente c INNER JOIN pedido p 
on c.id = p.id_cliente 
GROUP BY c.id
ORDER BY c.nombre ASC; 

-- 2. Devuelve un listado que muestre todos los pedidos que ha 
-- realizado cada cliente. El resultado debe mostrar todos los 
-- datos de los pedidos y del cliente. El listado debe mostrar 
-- los datos de los clientes ordenados alfabéticamente.

SELECT p.*, c.*
FROM cliente c INNER JOIN pedido p 
on c.id = p.id_cliente 
ORDER BY c.nombre ASC;

-- 3. Devuelve un listado que muestre todos los pedidos en los 
-- que ha participado un comercial. El resultado debe mostrar 
-- todos los datos de los pedidos y de los comerciales. El listado 
-- debe mostrar los datos de los comerciales ordenados 
-- alfabéticamente.

SELECT p.*, c2.*
FROM comercial c2 INNER JOIN pedido p 
on c2.id = p.id_comercial 
ORDER BY c2.nombre ASC;

-- 4. Devuelve un listado que muestre todos los clientes, con 
-- todos los pedidos que han realizado y con los datos de los 
-- comerciales asociados a cada pedido.

SELECT c.nombre as NOMBRE_CLIENTE, c.apellido1, c.apellido2,
		p.id as ID_PEDIDO, p.total, p.fecha, 
		c2.nombre AS NOMBRE_COMERCIAL, c2.apellido1, 
		c2.apellido2, c2.comisión 
FROM comercial c2 INNER JOIN pedido p 
on c2.id = p.id_comercial 
INNER JOIN cliente c 
on c.id = p.id_cliente;

-- 5. Devuelve un listado de todos los clientes que realizaron 
-- un pedido durante el año 2017, cuya cantidad esté entre 300 € 
-- y 1000 €.

SELECT c.id, c.nombre, c.apellido1, c.apellido2, 
		YEAR(p.fecha) as FECHA, p.total 
FROM cliente c INNER JOIN pedido p 
on c.id = p.id_cliente 
WHERE YEAR(p.fecha) = 2017 AND p.total BETWEEN 300 AND 1000; 

-- 6. Devuelve el nombre y los apellidos de todos los comerciales 
-- que ha participado en algún pedido realizado por María Santana 
-- Moreno.

SELECT c2.nombre as NOMBRE_COMERCIAL, 
		c2.apellido1 AS APELLIDO_COMERCIAL, 
		c2.apellido2 AS APELLIDO_COMERCIAL,
		c.nombre as NOMBRE_CLIENTE, c.apellido1 AS APELLIDO_CLIENTE,
		c.apellido2 AS APELLIDO_CLIENTE
FROM comercial c2 INNER JOIN pedido p 
on c2.id = p.id_comercial
INNER JOIN cliente c 
on c.id = p.id_cliente
WHERE c.nombre = "María" AND c.apellido1 = "Santana" 
		AND c.apellido2 = "Moreno"
GROUP BY c2.nombre;

-- 7. Devuelve el nombre de todos los clientes que han realizado 
-- algún pedido con el comercial Daniel Sáez Vega.

SELECT c.nombre as NOMBRE_CLIENTE, c.apellido1 AS APELLIDO_CLIENTE,
		c.apellido2 AS APELLIDO_CLIENTE, c2.nombre as NOMBRE_COMERCIAL, 
		c2.apellido1 AS APELLIDO_COMERCIAL, 
		c2.apellido2 AS APELLIDO_COMERCIAL
FROM comercial c2 INNER JOIN pedido p 
on c2.id = p.id_comercial
INNER JOIN cliente c 
on c.id = p.id_cliente
WHERE c2.nombre = "Daniel" AND c2.apellido1 = "Sáez" 
		AND c2.apellido2 = "Vega"
GROUP BY c.nombre;
