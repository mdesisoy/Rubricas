-- 1. Devuelve un listado que muestre solamente los clientes que 
-- no han realizado ningún pago.

SELECT c.nombre_cliente, p.codigo_cliente 
FROM cliente c left join pago p 
on c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 2. Devuelve un listado que muestre solamente los clientes 
-- que no han realizado ningún pedido.

SELECT c.nombre_cliente, p.codigo_cliente 
FROM cliente c left join pedido p 
on c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 3. Devuelve un listado que muestre los clientes que no han 
-- realizado ningún pago y los que no han realizado ningún pedido.

SELECT c.nombre_cliente, p.codigo_cliente 
FROM cliente c left join pago p 
on c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL

union

SELECT c.nombre_cliente, p2.codigo_cliente 
FROM cliente c left join pedido p2 
on c.codigo_cliente = p2.codigo_cliente 
WHERE p2.codigo_cliente IS NULL;

-- 4. Devuelve un listado que muestre solamente los empleados que 
-- no tienen una oficina asociada.

SELECT e.nombre, e.apellido1, e.apellido2, o.codigo_oficina 
FROM empleado e left join oficina o 
on o.codigo_oficina = e.codigo_oficina 
WHERE o.codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que 
-- no tienen un cliente asociado.

SELECT e.nombre, e.apellido1, e.apellido2, c.codigo_cliente 
FROM empleado e left join cliente c 
on c.codigo_empleado_rep_ventas = e.codigo_empleado 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 6. Devuelve un listado que muestre solamente los empleados que 
-- no tienen un cliente asociado junto con los datos de la oficina 
-- donde trabajan.

SELECT e.nombre, e.apellido1, e.apellido2, c.codigo_cliente,
		o.*
FROM empleado e left join cliente c 
on c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER join oficina o 
on e.codigo_oficina = o.codigo_oficina 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 7. Devuelve un listado que muestre los empleados que no tienen 
-- una oficina asociada y los que no tienen un cliente asociado.

SELECT e.nombre, e.apellido1, e.apellido2
FROM empleado e left join oficina o 
on o.codigo_oficina = e.codigo_oficina 
WHERE o.codigo_oficina IS NULL

UNION 

SELECT e.nombre, e.apellido1, e.apellido2
FROM empleado e left join cliente c 
on c.codigo_empleado_rep_ventas = e.codigo_empleado 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 8. Devuelve un listado de los productos que nunca han aparecido 
-- en un pedido.

SELECT p.nombre, dp.codigo_pedido 
FROM producto p left join detalle_pedido dp 
on p.codigo_producto = dp.codigo_producto 
WHERE dp.codigo_producto is NULL;

-- 9. Devuelve un listado de los productos que nunca han aparecido 
-- en un pedido. El resultado debe mostrar el nombre, la descripción
-- y la imagen del producto.

SELECT p.nombre, p.descripcion, p.dimensiones 
FROM producto p left join detalle_pedido dp 
on p.codigo_producto = dp.codigo_producto 
WHERE dp.codigo_producto is NULL;

-- 10. Devuelve las oficinas donde no trabajan ninguno de los 
-- empleados que hayan sido los representantes de ventas de algún 
-- cliente que haya realizado la compra de algún producto de la 
-- gama Frutales.

SELECT o.*
FROM empleado e LEFT JOIN oficina o 
on e.codigo_oficina = o.codigo_oficina 
INNER JOIN cliente c 
on e.codigo_empleado = c.codigo_empleado_rep_ventas 
INNER JOIN pedido p 
on c.codigo_cliente = p.codigo_cliente 
INNER JOIN detalle_pedido dp 
on p.codigo_pedido = dp.codigo_pedido 
INNER JOIN producto p2 
on p2.codigo_producto = dp.codigo_producto 
INNER JOIN gama_producto gp 
on p2.gama = gp.gama 
WHERE e.codigo_oficina IS NULL AND gp.gama = "Frutales";

-- 11. Devuelve un listado con los clientes que han realizado 
-- algún pedido pero no han realizado ningún pago.

SELECT DISTINCT c.nombre_cliente, p.codigo_cliente as PEDIDO , 
		p2.codigo_cliente AS PAGO
FROM cliente c inner join pedido p 
on c.codigo_cliente = p.codigo_cliente 
LEFT JOIN pago p2 
on c.codigo_cliente = p2.codigo_cliente 
WHERE p2.codigo_cliente IS NULL; 

-- 12. Devuelve un listado con los datos de los empleados que no 
-- tienen clientes asociados y el nombre de su jefe asociado.

SELECT e.nombre, e.apellido1, e.apellido2, c.codigo_cliente AS CLIENTE,
		e2.nombre as JEFE
FROM empleado e left join cliente c 
on c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN empleado e2 
on e.codigo_empleado = e2.codigo_jefe
WHERE c.codigo_empleado_rep_ventas IS NULL;


