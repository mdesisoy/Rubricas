-- 1. Devuelve un listado con todos los empleados junto con los 
-- datos de los departamentos donde trabajan. Este listado 
-- también debe incluir los empleados que no tienen ningún 
-- departamento asociado.

SELECT e.nombre, e.apellido1, e.apellido2, d.*
FROM empleado e left join departamento d 
on e.codigo_departamento = d.codigo;

-- 2. Devuelve un listado donde sólo aparezcan aquellos empleados 
-- que no tienen ningún departamento asociado.

SELECT e.nombre, e.apellido1, e.apellido2, d.nombre 
FROM empleado e left join departamento d 
on e.codigo_departamento = d.codigo
WHERE d.codigo IS NULL;

-- 3. Devuelve un listado donde sólo aparezcan aquellos 
-- departamentos que no tienen ningún empleado asociado.

SELECT e.nombre, e.apellido1, e.apellido2, d.nombre 
FROM empleado e right join departamento d 
on e.codigo_departamento = d.codigo
WHERE e.codigo IS NULL;

-- 4. Devuelve un listado con todos los empleados junto con 
-- los datos de los departamentos donde trabajan. El listado 
-- debe incluir los empleados que no tienen ningún departamento 
-- asociado y los departamentos que no tienen ningún empleado 
-- asociado. Ordene el listado alfabéticamente por el nombre 
-- del departamento.
SELECT NOMBRE, APELLIDO1, APELLIDO2, DEPARTAMENTO
FROM (
	-- subconsulta joins, lo ponemos asi para poder ordenar
	SELECT e.nombre AS NOMBRE, e.apellido1 AS APELLIDO1, 
			e.apellido2 AS APELLIDO2, d.nombre AS DEPARTAMENTO 
	FROM empleado e left join departamento d 
	on e.codigo_departamento = d.codigo
	
	union
	
	SELECT e.nombre AS NOMBRE, e.apellido1 AS APELLIDO1, 
			e.apellido2 AS APELLIDO2, d.nombre AS DEPARTAMENTO 
	FROM empleado e right join departamento d 
	on e.codigo_departamento = d.codigo) sub
ORDER BY DEPARTAMENTO ASC;

-- 5. Devuelve un listado con los empleados que no tienen ningún 
-- departamento asociado y los departamentos que no tienen ningún 
-- empleado asociado. Ordene el listado alfabéticamente por el 
-- nombre del departamento.
SELECT NOMBRE, APELLIDO1, APELLIDO2, DEPARTAMENTO
FROM (
	SELECT e.nombre AS NOMBRE, e.apellido1 AS APELLIDO1, 
			e.apellido2 AS APELLIDO2, d.nombre AS DEPARTAMENTO 
	FROM empleado e left join departamento d 
	on e.codigo_departamento = d.codigo
	WHERE d.codigo IS NULL
	
	union
	
	SELECT e.nombre AS NOMBRE, e.apellido1 AS APELLIDO1, 
			e.apellido2 AS APELLIDO2, d.nombre AS DEPARTAMENTO 
	FROM empleado e right join departamento d 
	on e.codigo_departamento = d.codigo
	WHERE e.codigo IS NULL) sub
ORDER BY DEPARTAMENTO ASC;

