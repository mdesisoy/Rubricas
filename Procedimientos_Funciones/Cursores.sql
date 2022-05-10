-- 1. Escribe las sentencias SQL necesarias para crear una base de 
-- datos llamada test, una tabla llamada alumnos y 4 sentencias de 
-- inserción para inicializar la tabla. La tabla alumnos está 
-- formada por las siguientes columnas:
-- 		id (entero sin signo y clave primaria)
-- 		nombre (cadena de caracteres)
-- 		apellido1 (cadena de caracteres)
-- 		apellido2 (cadena de caracteres
-- 		fecha_nacimiento (fecha)
USE test

DROP TABLE IF EXISTS alumnos;
CREATE TABLE alumnos(
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    fecha_nacimiento DATE,
    PRIMARY KEY(id)
);

INSERT INTO alumnos VALUES (1, 'María', 'Lozano', 'Ledesma', '2000-02-12');
INSERT INTO alumnos VALUES (2, 'Kit', 'Sebastian', 'Connor', '2004-03-08');

-- Una vez creada la tabla se decide añadir una nueva columna a la 
-- tabla llamada edad que será un valor calculado a partir de la 
-- columna fecha_nacimiento. Escriba la sentencia SQL necesaria para
-- modificar la tabla y añadir la nueva columna.

ALTER TABLE alumnos ADD edad INT;

-- Escriba una función llamada calcular_edad que reciba una fecha y 
-- devuelva el número de años que han pasado desde la fecha actual 
-- hasta la fecha pasada como parámetro:
-- 		Función: calcular_edad
-- 		Entrada: Fecha
-- 		Salida: Número de años (entero)

DROP FUNCTION IF EXISTS calcular_edad;
CREATE FUNCTION calcular_edad(fecha DATE)
  RETURNS INT -- lo que devuelve
BEGIN
	RETURN TRUNCATE(DATEDIFF(CURRENT_DATE(),fecha)/365,1);
END;

-- Prueba
SELECT calcular_edad('2000-02-12');

-- Ahora escriba un procedimiento que permita calcular la edad de 
-- todos los alumnmos que ya existen en la tabla. Para esto será 
-- necesario crear un procedimiento llamado actualizar_columna_edad 
-- que calcule la edad de cada alumno y actualice la tabla. Este 
-- procedimiento hará uso de la función calcular_edad que hemos 
-- creado en el paso anterior.

DROP PROCEDURE IF EXISTS actualizar_columna_edad
CREATE PROCEDURE actualizar_columna_edad()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE i_fecha DATE;
  DECLARE aux_id INT;
  DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM alumnos;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO aux_id, i_fecha;
    IF done THEN
      LEAVE read_loop;
    END IF;
   	UPDATE alumnos SET edad = calcular_edad(i_fecha)
   	WHERE aux_id = id;
  END LOOP;
  CLOSE cur1;
END;

CALL actualizar_columna_edad();


-- Modifica la tabla alumnos del ejercicio anterior para añadir una
-- nueva columna email. Una vez que hemos modificado la tabla 
-- necesitamos asignarle una dirección de correo electrónico de 
-- forma automática.

ALTER TABLE alumnos ADD email VARCHAR(30);

-- Escriba un procedimiento llamado crear_email que dados los 
-- parámetros de entrada: nombre, apellido1, apellido2 y dominio, 
-- cree una dirección de email y la devuelva como salida.

-- Procedimiento: crear_email
-- Entrada:
-- 		nombre (cadena de caracteres)
-- 		apellido1 (cadena de caracteres)
-- 		apellido2 (cadena de caracteres)
-- 		dominio (cadena de caracteres)
-- Salida:
-- 		email (cadena de caracteres)

-- devuelva una dirección de correo electrónico con el siguiente 
-- formato:

-- 	El primer carácter del parámetro nombre.
-- 	Los tres primeros caracteres del parámetro apellido1.
-- 	Los tres primeros caracteres del parámetro apellido2.
-- 	El carácter @.
-- 	El dominio pasado como parámetro.

DROP PROCEDURE IF EXISTS crear_email;
CREATE PROCEDURE crear_email(in nombre VARCHAR(50),
							in apellido1 VARCHAR(50),
							in apellido2 VARCHAR(50),
							in dominio VARCHAR(20),
							out email VARCHAR(30))
BEGIN 
	SET email = CONCAT(LEFT(nombre,1),LEFT(apellido1,3),
						LEFT(apellido2,3),"@", dominio);
END;

-- prueba
CALL crear_email('María', 'Lozano', 'Ledesma', 'gmail.joe', @email);
SELECT @email;

-- Ahora escriba un procedimiento que permita crear un email para 
-- todos los alumnmos que ya existen en la tabla. Para esto será 
-- necesario crear un procedimiento llamado actualizar_columna_email
-- que actualice la columna email de la tabla alumnos. 
-- Este procedimiento hará uso del procedimiento crear_email que 
-- hemos creado en el paso anterior.

DROP PROCEDURE IF EXISTS actualizar_columna_email;
CREATE PROCEDURE actualizar_columna_email()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE i_nombre, i_apell1, i_apell2 VARCHAR(50);
  DECLARE aux_id INT;
  DECLARE dominio VARCHAR(20) DEFAULT "gmail.com";
  DECLARE direccion_email VARCHAR(30);
  DECLARE cur1 CURSOR FOR SELECT id, nombre, apellido1, apellido2 
 			FROM alumnos;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO aux_id, i_nombre, i_apell1, i_apell2;
    IF done THEN
      LEAVE read_loop;
    END IF;
    CALL crear_email(i_nombre, i_apell1, i_apell2, dominio, direccion_email);
   	UPDATE alumnos SET alumnos.email = direccion_email
   	WHERE aux_id = id;				/* se puede pasar con o sin @*/
  END LOOP;
  CLOSE cur1;
END;

CALL actualizar_columna_email();

-- Escribe un procedimiento llamado crear_lista_emails_alumnos que 
-- devuelva la lista de emails de la tabla alumnos separados por un 
-- punto y coma. 
-- Ejemplo: juan@iescelia.org;maria@iescelia.org;
-- 			pepe@iescelia.org;lucia@iescelia.org.

DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos;
CREATE PROCEDURE crear_lista_emails_alumnos()
BEGIN
	DECLARE done INT DEFAULT FALSE;
  	DECLARE i_email VARCHAR(30);
  	DECLARE lista VARCHAR(1000) DEFAULT "";
	DECLARE cur1 CURSOR FOR SELECT email FROM alumnos;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  	OPEN cur1;

  	read_loop: LOOP
	    FETCH cur1 INTO i_email; 
	    IF done THEN
	      LEAVE read_loop;
	    END IF;
	   	SET lista = CONCAT(lista, i_email, ";");
	END LOOP;
	/* para quitar el ; del final*/
	SET lista = SUBSTRING(lista, 1, LENGTH(lista)-1); 
  	CLOSE cur1;
  	SELECT lista;
END;

CALL crear_lista_emails_alumnos();
