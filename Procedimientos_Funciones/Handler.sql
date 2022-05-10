-- Crea una base de datos llamada test que contenga una tabla 
-- llamada alumno. La tabla debe tener cuatro columnas:
-- 	id: entero sin signo (clave primaria).
-- 	nombre: cadena de 50 caracteres.
-- 	apellido1: cadena de 50 caracteres.
-- 	apellido2: cadena de 50 caracteres.

CREATE TABLE alumno (
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50),
    PRIMARY KEY(id)
);

-- Una vez creada la base de datos y la tabla deberá crear un 
-- procedimiento llamado insertar_alumno con las siguientes 
-- características. El procedimiento recibe cuatro parámetros de 
-- entrada (id, nombre, apellido1, apellido2) y los insertará en 
-- la tabla alumno. El procedimiento devolverá como salida un 
-- parámetro llamado error que tendrá un valor igual a 0 si la 
-- operación se ha podido realizar con éxito y un valor igual a 
-- 1 en caso contrario.
-- Deberá manejar los errores que puedan ocurrir cuando se intenta
-- insertar una fila que contiene una clave primaria repetida.

drop procedure if exists insertar_alumno;
create procedure insertar_alumno(id INT UNSIGNED, nombre VARCHAR(50),
    apellido1 VARCHAR(50), apellido2 VARCHAR(50))
BEGIN
	DECLARE error INT; /* TAMBIÉN SE PUEDE HACER DECLARANDOLO COMO OUT*/
	DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	BEGIN
		SET error = 1;
		SELECT error;
	END;
	INSERT INTO  alumno VALUES (id, nombre, apellido1, apellido2);
	SET error = 0;
	SELECT error;
END;

call insertar_alumno(1, 'María', 'Lozano', 'Ledesma');


