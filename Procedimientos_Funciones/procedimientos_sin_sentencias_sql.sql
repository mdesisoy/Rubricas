-- SI PONGO DELIMITER DA ERROR
-- 1. Escribe un procedimiento que no tenga ningún parámetro de 
-- entrada ni de salida y que muestre el texto ¡Hola mundo!.

drop procedure hola;
create procedure hola()
begin
	SELECT "¡Hola mundo!";
end;

call hola();

-- 2. Escribe un procedimiento que reciba un número real de 
-- entrada y muestre un mensaje indicando si el número es 
-- positivo, negativo o cero.

drop procedure num_real;
create procedure num_real(num REAL)
begin
	if (num > 0) then
		SELECT "Positivo";
	elseif (num < 0) then
		SELECT "Negativo";
	else
		SELECT "Cero";
	end if;
end;

call num_real(-9);

-- 3. Modifique el procedimiento diseñado en el ejercicio anterior 
-- para que tenga un parámetro de entrada, con el valor un número 
-- real, y un parámetro de salida, con una cadena de caracteres 
-- indicando si el número es positivo, negativo o cero.

drop procedure if exists num_real2;
create procedure num_real2(in num REAL, out tipo varchar(20))
begin
	if (num > 0) then
		set tipo = "Positivo";
	elseif (num < 0) then
		set tipo = "Negativo";
	else
		set tipo = "Cero";
	end if;
end;

call num_real2(0, @tipo);
SELECT @tipo;


-- 4. Escribe un procedimiento que reciba un número real de 
-- entrada, que representa el valor de la nota de un alumno, 
-- y muestre un mensaje indicando qué nota ha obtenido teniendo 
-- en cuenta las siguientes condiciones:
--    [0,5) = Insuficiente
--    [5,6) = Aprobado
--    [6, 7) = Bien
--    [7, 9) = Notable
--    [9, 10] = Sobresaliente
--    En cualquier otro caso la nota no será válida.

drop procedure if exists notas;
create procedure notas(nota REAL)
begin
	case
	when (nota >= 0 && nota < 5) then
		SELECT "Insuficiente";
	when (nota >= 5 && nota < 6) then
		SELECT "Aprobado";
	when (nota >= 6 && nota < 7) then
		SELECT "Bien";
	when (nota >= 7 && nota < 9) then
		SELECT "Notable";
	when (nota >= 9 && nota <= 10) then
		SELECT "Sobresaliente";
	when (nota > 10 || nota < 0) then
		SELECT "NO VALIDO";
	end case;
end;

call notas(12);

-- 5. Modifique el procedimiento diseñado en el ejercicio anterior 
-- para que tenga un parámetro de entrada, con el valor de la nota 
-- en formato numérico y un parámetro de salida, con una cadena de 
-- texto indicando la nota correspondiente.

drop procedure if exists notas2_if;
create procedure notas2_if(in nota REAL, out valor varchar(20))
begin
	if (nota >= 0 && nota < 5) then
		set valor = "Insuficiente";
	elseif (nota >= 5 && nota < 6) then
		set valor = "Aprobado";
	elseif (nota >= 6 && nota < 7) then
		set valor = "Bien";
	elseif (nota >= 7 && nota < 9) then
		set valor = "Notable";
	elseif (nota >= 9 && nota <= 10) then
		set valor = "Sobresaliente";
	elseif (nota > 10 || nota < 0) then
		set valor = "NO VALIDO";
	end if;
end;

call notas2_if(4.7, @valor);
SELECT @valor;

-- 6. Resuelva el procedimiento diseñado en el ejercicio anterior 
-- haciendo uso de la estructura de control CASE.

drop procedure if exists notas2;
create procedure notas2(in nota REAL, out valor varchar(20))
begin
	case
	when (nota >= 0 && nota < 5) then
		set valor = "Insuficiente";
	when (nota >= 5 && nota < 6) then
		set valor = "Aprobado";
	when (nota >= 6 && nota < 7) then
		set valor = "Bien";
	when (nota >= 7 && nota < 9) then
		set valor = "Notable";
	when (nota >= 9 && nota <= 10) then
		set valor = "Sobresaliente";
	when (nota > 10 || nota < 0) then
		set valor = "NO VALIDO";
	end case;
end;

call notas2(4.7, @valor);
SELECT @valor;

-- 7. Escribe un procedimiento que reciba como parámetro de 
-- entrada un valor numérico que represente un día de la semana 
-- y que devuelva una cadena de caracteres con el nombre del día 
-- de la semana correspondiente. Por ejemplo, para el valor de 
-- entrada 1 debería devolver la cadena lunes.

drop procedure if exists dia_semana;
create procedure dia_semana(dia INT)
begin
	case
	when (dia = 1) then SELECT "lunes";
	when (dia = 2) then SELECT "martes";
	when (dia = 3) then SELECT "miercoles";
	when (dia = 4) then SELECT "jueves";
	when (dia = 5) then SELECT "viernes";
	when (dia = 6) then SELECT "sabado";
	when (dia = 7) then SELECT "domingo";
	when (dia < 1 || dia > 7) then SELECT "NO VALIDO";
	end case;
end;

call dia_semana(6);





