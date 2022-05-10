-- 4. Crea una base de datos llamada procedimientos que contenga una 
-- tabla llamada cuadrados. La tabla cuadrados debe tener dos 
-- columnas de tipo INT UNSIGNED, una columna llamada número y 
-- otra columna llamada cuadrado.

DROP DATABASE IF EXISTS Procedimientos;
CREATE DATABASE Procedimientos;
USE Procedimientos;

CREATE TABLE cuadros (
    numero INT UNSIGNED,
    cuadrado INT UNSIGNED
);

-- Una vez creada la base de datos y la tabla deberá crear un 
-- procedimiento llamado calcular_cuadrados con las siguientes 
-- características. El procedimiento recibe un parámetro de entrada 
-- llamado tope de tipo INT UNSIGNED y calculará el valor de los 
-- cuadrados de los primeros números naturales hasta el valor 
-- introducido como parámetro. El valor del números y de sus 
-- cuadrados deberán ser almacenados en la tabla cuadrados que 
-- hemos creado previamente.
-- Tenga en cuenta que el procedimiento deberá eliminar el 
-- contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.

-- Utilice un bucle WHILE para resolver el procedimiento.

drop procedure if exists calcular_cuadrados;
create procedure calcular_cuadrados(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM cuadros;
	while (i <= tope) DO
		INSERT INTO  cuadros VALUES (i, i*i);
		SET i = i+1;
	end while;
end;

call calcular_cuadrados(2);

-- 5. Utilice un bucle REPEAT para resolver el procedimiento del 
-- ejercicio anterior.

drop procedure if exists calcular_cuadrados_REPEAT;
create procedure calcular_cuadrados_REPEAT(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM cuadros;
	REPEAT
		INSERT INTO  cuadros VALUES (i, i*i);
		SET i = i+1;
	UNTIL (i > tope)
	END REPEAT;
end;

call calcular_cuadrados_REPEAT(6);

-- 6. Utilice un bucle LOOP para resolver el procedimiento del 
-- ejercicio anterior.

drop procedure if exists calcular_cuadrados_LOOP;
create procedure calcular_cuadrados_LOOP(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM cuadros;
	ins_loop: LOOP
		IF (i > tope) THEN
			LEAVE ins_loop;
		END IF;
		INSERT INTO  cuadros VALUES (i, i*i);
		SET i = i+1;
	END LOOP;
end;

call calcular_cuadrados_LOOP(7);

-- 7. Crea una base de datos llamada procedimientos que contenga una 
-- tabla llamada ejercicio. La tabla debe tener una única columna 
-- llamada número y el tipo de dato de esta columna debe ser INT 
-- UNSIGNED.
-- Una vez creada la base de datos y la tabla deberá crear un 
-- procedimiento llamado calcular_números con las siguientes 
-- características. El procedimiento recibe un parámetro de 
-- entrada llamado valor_inicial de tipo INT UNSIGNED y 
-- deberá almacenar en la tabla ejercicio toda la secuencia 
-- de números desde el valor inicial pasado como entrada hasta 
-- el 1.

-- Tenga en cuenta que el procedimiento deberá eliminar el contenido 
-- actual de las tablas antes de insertar los nuevos valores.

-- Utilice un bucle WHILE para resolver el procedimiento.

CREATE TABLE ejercicio (
    numero INT UNSIGNED
);

drop procedure if exists calcular_numeros;
create procedure calcular_numeros(valor_inicial INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT valor_inicial;
	DELETE FROM ejercicio;
	while (i >= 1) DO
		INSERT INTO  ejercicio VALUES (i);
		SET i = i - 1;
	end while;
end;

call calcular_numeros(8);

-- 8.Utilice un bucle REPEAT para resolver el procedimiento del 
-- ejercicio anterior.

drop procedure if exists calcular_numeros_REPEAT;
create procedure calcular_numeros_REPEAT(valor_inicial INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT valor_inicial;
	DELETE FROM ejercicio;
	REPEAT
		INSERT INTO  ejercicio VALUES (i);
		SET i = i - 1;
	UNTIL (i < 1)
	END REPEAT;
end;

call calcular_numeros_REPEAT(15);

-- 9.Utilice un bucle LOOP para resolver el procedimiento del 
-- ejercicio anterior.

drop procedure if exists calcular_numeros_LOOP;
create procedure calcular_numeros_LOOP(valor_inicial INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT valor_inicial;
	DELETE FROM ejercicio;
	ins_loop: LOOP
		IF (i < 1) THEN
			LEAVE ins_loop;
		END IF;
		INSERT INTO  ejercicio VALUES (i);
		SET i = i - 1;
	END LOOP;
end;

call calcular_numeros_LOOP(20);

-- 10. Crea una base de datos llamada procedimientos que contenga
-- una tabla llamada pares y otra tabla llamada impares. Las dos 
-- tablas deben tener única columna llamada número y el tipo de 
-- dato de esta columna debe ser INT UNSIGNED.

CREATE TABLE pares (
    numero INT UNSIGNED
);

CREATE TABLE impares (
    numero INT UNSIGNED
);

-- Una vez creada la base de datos y las tablas deberá crear un 
-- procedimiento llamado calcular_pares_impares con las 
-- siguientes características. El procedimiento recibe un 
-- parámetro de entrada llamado tope de tipo INT UNSIGNED y 
-- deberá almacenar en la tabla pares aquellos números pares 
-- que existan entre el número 1 el valor introducido como 
-- parámetro. Habrá que realizar la misma operación para 
-- almacenar los números impares en la tabla impares.

-- Tenga en cuenta que el procedimiento deberá eliminar el 
-- contenido actual de las tablas antes de insertar los nuevos 
-- valores.

-- Utilice un bucle WHILE para resolver el procedimiento.

drop procedure if exists calcular_pares_impares;
create procedure calcular_pares_impares(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM pares;
	DELETE FROM impares;
	while (i <= tope) DO
		IF(i%2 = 0) THEN
			INSERT INTO  pares VALUES (i);
		ELSE
			INSERT INTO  impares VALUES (i);
		END IF;
		SET i = i + 1;
	end while;
end;

call calcular_pares_impares(10);

-- 11. Utilice un bucle REPEAT para resolver el procedimiento 
-- del ejercicio anterior.

drop procedure if exists calcular_pares_impares_REPEAT;
create procedure calcular_pares_impares_REPEAT(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM pares;
	DELETE FROM impares;
	REPEAT
		IF(i%2 = 0) THEN
			INSERT INTO  pares VALUES (i);
		ELSE
			INSERT INTO  impares VALUES (i);
		END IF;
		SET i = i + 1;
	UNTIL (i > tope)
	END REPEAT;
end;

call calcular_pares_impares_REPEAT(20);

-- 12. Utilice un bucle LOOP para resolver el procedimiento del 
-- ejercicio anterior.

drop procedure if exists calcular_pares_impares_LOOP;
create procedure calcular_pares_impares_LOOP(tope INT UNSIGNED)
begin
	DECLARE i INTEGER DEFAULT 1;
	DELETE FROM pares;
	DELETE FROM impares;
	ins_loop: LOOP
		IF(i > tope) THEN
			LEAVE ins_loop;
		END IF;
		IF(i%2 = 0) THEN
			INSERT INTO  pares VALUES (i);
		ELSE
			INSERT INTO  impares VALUES (i);
		END IF;
		SET i = i + 1;
	END LOOP;
end;

call calcular_pares_impares_LOOP(30);










