-- 1. Escribe un procedimiento que reciba el nombre de un país 
-- como parámetro de entrada y realice una consulta sobre la tabla 
-- cliente para obtener todos los clientes que existen en la tabla 
-- de ese país.

drop procedure if exists pais;
create procedure pais(pais varchar(20))
begin
	SELECT c.nombre_cliente 
	FROM cliente c
	WHERE c.pais = pais;
end;

call pais("Spain");

-- 2. Escribe un procedimiento que reciba como parámetro de entrada 
-- una forma de pago, que será una cadena de caracteres (Ejemplo: 
-- PayPal, Transferencia, etc). Y devuelva como salida el pago de 
-- máximo valor realizado para esa forma de pago. Deberá hacer uso 
-- de la tabla pago de la base de datos jardineria.

drop procedure if exists pago;
create procedure pago(in forma_pago varchar(30), out max_pago int)
begin
	SELECT MAX(p.total) into max_pago
	FROM pago p
	WHERE p.forma_pago = forma_pago;
end;

call pago("PayPal", @max_pago);
SELECT @max_pago;

-- 3. Escribe un procedimiento que reciba como parámetro de entrada 
-- una forma de pago, que será una cadena de caracteres (Ejemplo: 
-- PayPal, Transferencia, etc). Y devuelva como salida los 
-- siguientes valores teniendo en cuenta la forma de pago 
-- seleccionada como parámetro de entrada:

--    el pago de máximo valor,
--    el pago de mínimo valor,
--    el valor medio de los pagos realizados,
--    la suma de todos los pagos,
--    el número de pagos realizados para esa forma de pago.

drop procedure if exists pago2;
create procedure pago2(in forma_pago varchar(30), out max_pago int,
						out min_pago int, out avg_pago int,
						out sum_pago int, out count_pago int)
begin
	SELECT MAX(p.total) into max_pago FROM pago p 
	WHERE p.forma_pago = forma_pago;
	SELECT MIN(p.total) into min_pago FROM pago p 
	WHERE p.forma_pago = forma_pago;
	SELECT AVG(p.total) into avg_pago FROM pago p 
	WHERE p.forma_pago = forma_pago;
	SELECT SUM(p.total) into sum_pago FROM pago p 
	WHERE p.forma_pago = forma_pago;
	SELECT COUNT(p.total) into count_pago FROM pago p 
	WHERE p.forma_pago = forma_pago;
end;

call pago2("Cheque", @max_pago, @min_pago, @avg_pago, @sum_pago,
					@count_pago);
SELECT @max_pago;
SELECT @min_pago;
SELECT @avg_pago;
SELECT @sum_pago;
SELECT @count_pago;



