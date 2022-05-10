-- Crea una base de datos llamada cine que contenga dos tablas 
-- con las siguientes columnas.

DROP DATABASE IF EXISTS cine;
CREATE DATABASE cine;
USE cine;

-- Tabla cuentas:
-- 	id_cuenta: entero sin signo (clave primaria).
-- 	saldo: real sin signo.

CREATE TABLE cuentas (
    id_cuenta INT UNSIGNED,
    saldo REAL UNSIGNED,
    PRIMARY KEY(id_cuenta)
);

-- Tabla entradas:
-- 	id_butaca: entero sin signo (clave primaria).
-- 	nif: cadena de 9 caracteres.

CREATE TABLE entradas (
    id_butaca INT UNSIGNED,
    nif VARCHAR(9),
    PRIMARY KEY(id_butaca)
);

-- Una vez creada la base de datos y las tablas deberá crear un 
-- procedimiento llamado comprar_entrada con las siguientes 
-- características. El procedimiento recibe 3 parámetros de entrada 
-- (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro 
-- llamado error que tendrá un valor igual a 0 si la compra de la 
-- entrada se ha podido realizar con éxito y un valor igual a 1 en 
-- caso contrario.

-- El procedimiento de compra realiza los siguientes pasos:
-- 	Inicia una transacción.
-- 	Actualiza la columna saldo de la tabla cuentas cobrando 5 euros 
-- 	a la cuenta con el id_cuenta adecuado.
-- 	Inserta una fila en la tabla entradas indicando la butaca 
-- 	(id_butaca) que acaba de comprar el usuario (nif).
-- 	Comprueba si ha ocurrido algún error en las operaciones 
-- 	anteriores. Si no ocurre ningún error entonces aplica un COMMIT 
-- 	a la transacción y si ha ocurrido algún error aplica un ROLLBACK.
-- Deberá manejar los siguientes errores que puedan ocurrir durante 
-- el proceso.
-- ERROR 1264 (Out of range value)
-- ERROR 1062 (Duplicate entry for PRIMARY KEY)

-- ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos 
-- como parámetro un número de cuenta que no existe en la tabla 
-- cuentas? ¿Ocurre algún error o podemos comprar la entrada?

-- En caso de que exista algún error, ¿cómo podríamos resolverlo?.

drop procedure if exists comprar_entrada;
create procedure comprar_entrada(nif VARCHAR(9), 
								id_cuenta INT UNSIGNED,
								id_butaca INT UNSIGNED)
BEGIN
	DECLARE error INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
      	SET error = 1;
		SELECT error;
      	ROLLBACK;
    END;
	/*DECLARE EXIT HANDLER FOR SQLSTATE '1264'
	BEGIN
		SET error = 1;
		SELECT error;
		ROLLBACK;
	END;
	DECLARE EXIT HANDLER FOR SQLSTATE '1062'
	BEGIN
		SET error = 1;
		SELECT error;
		ROLLBACK;
	END;*/
    -- transacción
    START TRANSACTION;
   		SET error = 0;
		UPDATE cuentas c SET c.saldo = c.saldo - 5 
		WHERE c.id_cuenta = id_cuenta;
		INSERT INTO entradas VALUES (id_butaca, nif);
		SELECT error;
	COMMIT;
END;

/*iniciar cuentas*/
INSERT INTO cuentas VALUES (1,50);
INSERT INTO cuentas VALUES (2,5);

/*llamada a funcion*/
call comprar_entrada('73026258Q', 1, 2);
call comprar_entrada('73024558Q', 2, 3);


