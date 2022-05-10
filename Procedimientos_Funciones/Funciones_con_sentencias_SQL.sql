USE tienda;
-- 1. Escribe una función para la base de datos tienda que 
-- devuelva el número total de productos que hay en la tabla 
-- productos.

DROP FUNCTION IF EXISTS total_productos
CREATE FUNCTION total_productos()
  RETURNS INT UNSIGNED -- lo que devuelve
BEGIN
	DECLARE total INT UNSIGNED;
	SET total = (
	    SELECT COUNT(*)
	    FROM producto);
   RETURN total;
END;

SELECT total_productos();

-- 2. Escribe una función para la base de datos tienda que 
-- devuelva el valor medio del precio de los productos de un 
-- determinado fabricante que se recibirá como parámetro de 
-- entrada. El parámetro de entrada será el nombre del fabricante.

DROP FUNCTION IF EXISTS valor_medio
CREATE FUNCTION valor_medio(fabricante VARCHAR(50))
  RETURNS REAL UNSIGNED -- lo que devuelve
BEGIN
	DECLARE media REAL UNSIGNED;
	SET media = (
	    SELECT AVG(p.precio)
	    FROM producto p, fabricante f 
	    WHERE p.codigo_fabricante = f.codigo 
	   		  AND f.nombre = fabricante);
   RETURN media;
END;

SELECT valor_medio('Lenovo');

-- 3. Escribe una función para la base de datos tienda que 
-- devuelva el valor máximo del precio de los productos de un 
-- determinado fabricante que se recibirá como parámetro de 
-- entrada. El parámetro de entrada será el nombre del fabricante.

DROP FUNCTION IF EXISTS precio_maximo
CREATE FUNCTION precio_maximo(fabricante VARCHAR(50))
  RETURNS REAL -- lo que devuelve
BEGIN
	DECLARE max REAL;
	SET max = (
	    SELECT MAX(p.precio)
	    FROM producto p, fabricante f 
	    WHERE p.codigo_fabricante = f.codigo 
	   		  AND f.nombre = fabricante);
   RETURN max;
END;

SELECT precio_maximo('Asus');

-- 4. Escribe una función para la base de datos tienda que 
-- devuelva el valor mínimo del precio de los productos de un 
-- determinado fabricante que se recibirá como parámetro de 
-- entrada. El parámetro de entrada será el nombre del fabricante

DROP FUNCTION IF EXISTS precio_minimo
CREATE FUNCTION precio_minimo(fabricante VARCHAR(50))
  RETURNS REAL -- lo que devuelve
BEGIN
	DECLARE min REAL;
	SET min = (
	    SELECT min(p.precio)
	    FROM producto p, fabricante f 
	    WHERE p.codigo_fabricante = f.codigo 
	   		  AND f.nombre = fabricante);
   RETURN min;
END;

SELECT precio_minimo('Asus');
