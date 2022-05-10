-- 1. Devuelve un listado con todos los clientes junto con los 
-- datos de los pedidos que han realizado. Este listado también 
-- debe incluir los clientes que no han realizado ningún pedido. 
-- El listado debe estar ordenado alfabéticamente por el primer 
-- apellido, segundo apellido y nombre de los clientes.

SELECT c.nombre, c.apellido1, c.apellido2, p.*
FROM cliente c LEFT JOIN pedido p 
on c.id = p.id_cliente 
ORDER BY c.apellido1 ASC, c.apellido2 ASC, c.nombre ASC;

-- 2. Devuelve un listado con todos los comerciales junto con los 
-- datos de los pedidos que han realizado. Este listado también 
-- debe incluir los comerciales que no han realizado ningún pedido. 
-- El listado debe estar ordenado alfabéticamente por el primer 
-- apellido, segundo apellido y nombre de los comerciales.

SELECT c2.nombre, c2.apellido1, c2.apellido2, p.*
FROM comercial c2 LEFT JOIN pedido p 
on c2.id = p.id_comercial 
ORDER BY c2.apellido1 ASC, c2.apellido2 ASC, c2.nombre ASC;

-- 3. Devuelve un listado que solamente muestre los clientes que 
-- no han realizado ningún pedido.

SELECT c.nombre, c.apellido1, c.apellido2, p.id as PEDIDO
FROM cliente c LEFT JOIN pedido p 
on c.id = p.id_cliente 
WHERE p.id_cliente is NULL;

-- 4. Devuelve un listado que solamente muestre los comerciales 
-- que no han realizado ningún pedido.

SELECT c2.nombre, c2.apellido1, c2.apellido2, p.id as PEDIDO
FROM comercial c2 LEFT JOIN pedido p 
on c2.id = p.id_comercial 
WHERE p.id_cliente is NULL;

-- 5. Devuelve un listado con los clientes que no han realizado 
-- ningún pedido y de los comerciales que no han participado en 
-- ningún pedido. Ordene el listado alfabéticamente por los 
-- apellidos y el nombre. En en listado deberá diferenciar de 
-- algún modo los clientes y los comerciales.

SELECT NOMBRE, APELLIDO, APELLIDO2, TIPO, PEDIDO
FROM (
	-- subconsulta joins, lo ponemos asi para poder ordenar
	SELECT c.nombre AS NOMBRE, c.apellido1 AS APELLIDO, 
			c.apellido2 AS APELLIDO2, p.id as PEDIDO, 
			"cliente" as TIPO
	FROM cliente c LEFT JOIN pedido p 
	on c.id = p.id_cliente 
	WHERE p.id_cliente is NULL
	
	UNION 
	
	SELECT c2.nombre AS NOMBRE, c2.apellido1 AS APELLIDO, 
			c2.apellido2 AS APELLIDO2, p.id as PEDIDO,
			"comercial" as TIPO
	FROM comercial c2 LEFT JOIN pedido p 
	on c2.id = p.id_comercial 
	WHERE p.id_cliente is NULL) res
ORDER BY NOMBRE ASC, APELLIDO ASC, APELLIDO2 ASC;

-- 6. ¿Se podrían realizar las consultas anteriores con NATURAL 
-- LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.

-- No, porque el natural obliga a que las columnas que cruzas sean
-- iguales. No se utiliza condición ON en los natural joins.
-- En el caso anterior estarías mezclando datos diferentes.

								
		
								
		
		
		
		
		
		


