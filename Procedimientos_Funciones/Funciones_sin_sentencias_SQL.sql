-- 1. Escribe una función que reciba un número entero de entrada 
-- y devuelva TRUE si el número es par o FALSE en caso contrario.

DROP FUNCTION IF EXISTS es_par
CREATE FUNCTION es_par(numero INT)
  RETURNS boolean -- lo que devuelve
BEGIN
	IF(numero%2 = 0)THEN
  		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;

SELECT es_par(15);

-- 2. Escribe una función que devuelva el valor de la hipotenusa 
-- de un triángulo a partir de los valores de sus lados.

DROP FUNCTION IF EXISTS hipotenusa
CREATE FUNCTION hipotenusa(cateto1 INT, cateto2 INT)
  RETURNS INT -- lo que devuelve
BEGIN
	RETURN SQRT((cateto1*cateto1) + (cateto2*cateto2));
END;

SELECT hipotenusa(3, 4);

-- 3. Escribe una función que reciba como parámetro de entrada un 
-- valor numérico que represente un día de la semana y que 
-- devuelva una cadena de caracteres con el nombre del día de la 
-- semana correspondiente. Por ejemplo, para el valor de entrada 
-- 1 debería devolver la cadena lunes.

DROP FUNCTION IF EXISTS dia_semana
CREATE FUNCTION dia_semana(dia INT)
  RETURNS VARCHAR(15) -- lo que devuelve
BEGIN
	CASE
		WHEN (dia = 1) THEN RETURN "lunes";
		WHEN (dia = 2) THEN RETURN "martes";
		WHEN (dia = 3) THEN RETURN "miercoles";
		WHEN (dia = 4) THEN RETURN "jueves";
		WHEN (dia = 5) THEN RETURN "viernes";
		WHEN (dia = 6) THEN RETURN "sabado";
		WHEN (dia = 7) THEN RETURN "domingo";
		WHEN (dia < 1 || dia > 7) THEN RETURN "NO VALIDO";
	END CASE;
END;

SELECT dia_semana(7);

-- 4. Escribe una función que reciba tres números reales como 
-- parámetros de entrada y devuelva el mayor de los tres.

DROP FUNCTION IF EXISTS num_mayor
CREATE FUNCTION num_mayor(num1 REAL, num2 REAL, num3 REAL)
  RETURNS REAL  -- lo que devuelve
BEGIN
	IF(num1 > num2 && num1 > num3) THEN
		RETURN num1;
	ELSEIF(num2 > num1 && num2 > num3) THEN
		RETURN num2;
	ELSE
		RETURN num3;
	END IF;
END;

SELECT num_mayor(7, 8.2,5.63);

-- 5. Escribe una función que devuelva el valor del área de un 
-- círculo a partir del valor del radio que se recibirá como 
-- parámetro de entrada.

DROP FUNCTION IF EXISTS area_circulo
CREATE FUNCTION area_circulo(radio FLOAT)
  RETURNS FLOAT  -- lo que devuelve
BEGIN
	DECLARE pi FLOAT;
	set pi = 3.1415;
	RETURN (pi * (radio * radio));
	-- también se puede usar directamente la constante PI
	-- RETURN (PI()*(radio*radio));
END;
					
SELECT area_circulo(2.1);

-- 6. Escribe una función que devuelva como salida el número de 
-- años que han transcurrido entre dos fechas que se reciben como 
-- parámetros de entrada. Por ejemplo, si pasamos como parámetros 
-- de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene 
-- que devolver que han pasado 10 años.
-- Para realizar esta función puede hacer uso de las siguientes 
-- funciones que nos proporciona MySQL:
-- 		DATEDIFF
-- 		TRUNCATE

DROP FUNCTION IF EXISTS diferenciaEntreFechas
CREATE FUNCTION diferenciaEntreFechas(fecha1 DATE, fecha2 DATE)
  RETURNS INT  -- lo que devuelve
BEGIN
	DECLARE anyos INT;
	SET anyos = DATEDIFF(fecha1,fecha2)/365;
	RETURN TRUNCATE(anyos,1);
END;
	
SELECT diferenciaEntreFechas('2018-01-01', '2008-01-01');

-- 7. Escribe una función que reciba una cadena de entrada y 
-- devuelva la misma cadena pero sin acentos. La función tendrá 
-- que reemplazar todas las vocales que tengan acento por la 
-- misma vocal pero sin acento. Por ejemplo, si la función recibe 
-- como parámetro de entrada la cadena María la función debe 
-- devolver la cadena Maria.

DROP FUNCTION IF EXISTS sinAcentos;
CREATE FUNCTION sinAcentos(cad VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN

    set @textvalue = cad;

    -- ACCENTS
    SET @withaccents = 'ŠšŽžÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝŸÞàáâãäåæçèéêëìíîïñòóôõöøùúûüýÿþƒ';
    SET @withoutaccents = 'SsZzAAAAAAACEEEEIIIINOOOOOOUUUUYYBaaaaaaaceeeeiiiinoooooouuuuyybf';
    SET @COUNT = LENGTH(@withaccents);

    WHILE (@count > 0) do
        SET @textvalue = REPLACE(@textvalue, SUBSTRING(@withaccents, @COUNT, 1), SUBSTRING(@withoutaccents, @COUNT, 1));
        SET @COUNT = @COUNT - 1;
    END WHILE;

    return @textvalue;
END;

SELECT sinAcentos('María Pérez');

/*OTRA MANERA*/

DROP FUNCTION IF EXISTS sinAcentos_2;
CREATE FUNCTION sinAcentos_2(cad VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN
	DECLARE string VARCHAR(100);
	SET string = cad;
	SET string = LOWER(string);
	SET string = replace(string, 'á', 'a');
	SET string = replace(string, 'é', 'e');
	SET string = replace(string, 'í', 'i');
	SET string = replace(string, 'ó', 'o');
	SET string = replace(string, 'ú', 'u');
	RETURN string;
END;

SELECT sinAcentos_2('María Pérez');









