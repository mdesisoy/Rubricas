-- 1. Obtén un listado con el nombre de cada cliente y el nombre y 
-- apellido de su representante de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos 
-- junto con el nombre de sus representantes de ventas.

SELECT c.nombre_cliente, e.nombre 
FROM cliente c inner join empleado e
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p 
on c.codigo_cliente = p.codigo_cliente
GROUP BY p.codigo_cliente;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos 
-- junto con el nombre de sus representantes de ventas.

SELECT c.nombre_cliente, e.nombre 
FROM cliente c inner join empleado e
on c.codigo_empleado_rep_ventas = e.codigo_empleado
	WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente
	FROM pago p 
	GROUP BY p.codigo_cliente);

-- 4. Devuelve el nombre de los clientes que han hecho pagos y 
-- el nombre de sus representantes junto con la ciudad de la 
-- oficina a la que pertenece el representante.

SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad 
FROM cliente c inner join empleado e
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join pago p 
on c.codigo_cliente = p.codigo_cliente
inner join oficina o 
on o.codigo_oficina = e.codigo_oficina;
/* También se puede poner el group by como antes*/

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos 
-- y el nombre de sus representantes junto con la ciudad de la 
-- oficina a la que pertenece el representante.

SELECT DISTINCT c.nombre_cliente, e.nombre, o.ciudad 
FROM cliente c inner join empleado e
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o 
on o.codigo_oficina = e.codigo_oficina
	WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente
	FROM pago p 
	GROUP BY p.codigo_cliente);

-- 6. Lista la dirección de las oficinas que tengan clientes 
-- en Fuenlabrada.

SELECT o.ciudad, o.codigo_postal, c.nombre_cliente, c.ciudad 
FROM cliente c inner join empleado e 
on c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN oficina o 
on o.codigo_oficina = e.codigo_oficina 
WHERE c.ciudad = "Fuenlabrada"
GROUP BY o.codigo_oficina;

-- 7. Devuelve el nombre de los clientes y el nombre de sus 
-- representantes junto con la ciudad de la oficina a la que 
-- pertenece el representante.

SELECT c.nombre_cliente, e.nombre, o.ciudad 
FROM cliente c inner join empleado e
on c.codigo_empleado_rep_ventas = e.codigo_empleado
inner join oficina o 
on o.codigo_oficina = e.codigo_oficina
GROUP BY c.codigo_cliente , e.codigo_empleado;

-- 8. Devuelve un listado con el nombre de los empleados junto 
-- con el nombre de sus jefes.

SELECT e.nombre as EMPLEADO, e2.nombre as JEFE
FROM empleado e inner join empleado e2 
on e.codigo_empleado = e2.codigo_jefe;

-- 9. Devuelve un listado que muestre el nombre de cada empleados, 
-- el nombre de su jefe y el nombre del jefe de sus jefe.

SELECT e.nombre as EMPLEADO, e2.nombre as JEFE1,
		e3.nombre as JEFE2
FROM empleado e inner join empleado e2 
on e.codigo_empleado = e2.codigo_jefe
INNER JOIN empleado e3 
on e2.codigo_empleado = e3.codigo_jefe;

-- 10. Devuelve el nombre de los clientes a los que no se les ha 
-- entregado a tiempo un pedido.

SELECT c.nombre_cliente as NOMBRE, 
		DATEDIFF(p.fecha_entrega, p.fecha_esperada) as Tardanza
FROM cliente c inner join pedido p 
on p.codigo_cliente = c.codigo_cliente 
WHERE DATEDIFF(p.fecha_entrega, p.fecha_esperada) > 0
GROUP BY NOMBRE;

-- 11. Devuelve un listado de las diferentes gamas de producto 
-- que ha comprado cada cliente.

SELECT DISTINCT c.nombre_cliente, p2.gama AS GAMA_PRODUCTOS
FROM cliente c INNER JOIN pedido p 
on c.codigo_cliente = p.codigo_cliente 
INNER JOIN detalle_pedido dp 
on p.codigo_pedido = dp.codigo_pedido 
INNER JOIN producto p2 
on p2.codigo_producto = dp.codigo_producto 
INNER JOIN gama_producto gp 
on gp.gama = p2.gama;
-- También se puede cambiar el distinct por:
-- GROUP BY c.nombre_cliente, gp.gama
-- ORDER BY c.nombre_cliente;




