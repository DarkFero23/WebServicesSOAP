CREATE TABLESPACE Procesos DATAFILE 
'D:\FERITO23\Procesos.dbf' SIZE 100M EXTENT 
MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
--error: ORA-65096: nombre de usuario o rol común no válido-- ERROR 
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER FERITO23
IDENTIFIED BY SYLAS
DEFAULT TABLESPACE Procesos
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON Procesos;

-- ROLES
GRANT CONNECT,RESOURCE TO FERITO23;

-- SYSTEM PRIVILEGES
GRANT CREATE ANY INDEX TO FERITO23 ;
GRANT CREATE ANY SEQUENCE TO FERITO23 ;
GRANT CREATE ANY SYNONYM TO FERITO23 ;
GRANT CREATE ANY VIEW TO FERITO23 ;
GRANT CREATE ANY TABLE TO FERITO23 ;
GRANT CREATE ANY TYPE TO FERITO23 ;

ALTER USER FERITO23 quota unlimited on Procesos;
-------------------------------------------
--PRIMERO SE TIENEN QUE CREAR LAS TABLAS PARA PODER EJECUTAR LAS SECUENCIAS Y LOS TRIGGERS
---------
CREATE SEQUENCE pr_sq START WITH 1 INCREMENT BY 1;
----------
CREATE SEQUENCE cat_sq START WITH 1 INCREMENT BY 1;
-----------
CREATE SEQUENCE prod_sq START WITH 1 INCREMENT BY 1;
--------
CREATE SEQUENCE ped_sq START WITH 1 INCREMENT BY 1;
------
CREATE SEQUENCE det_sq START WITH 1 INCREMENT BY 1;
------
CREATE SEQUENCE numero_pedido_sq START WITH 1 INCREMENT BY 3;
---
CREATE SEQUENCE ven_sq START WITH 1 INCREMENT BY 1;
SELECT *FROM USUARIOS u 
SELECT *FROM PRODUCTO p  
SELECT * FROM venta
CREATE OR REPLACE TRIGGER prov_seq_tr
    BEFORE INSERT ON Usuarios FOR EACH ROW
  WHEN (NEW.idUsuario IS NULL OR NEW.idUsuario = 0)
  BEGIN
    SELECT pr_sq.NEXTVAL INTO :NEW.idUsuario FROM dual;
  END;
 ------------
 CREATE OR REPLACE TRIGGER cat_seq_tr
    BEFORE INSERT ON Categoria FOR EACH ROW
  WHEN (NEW.idCategoria IS NULL OR NEW.idCategoria = 0)
  BEGIN
    SELECT cat_sq.NEXTVAL INTO :NEW.idCategoria FROM dual;
  END;
--------
 CREATE OR REPLACE TRIGGER prod_sq_tr
    BEFORE INSERT ON Producto FOR EACH ROW
  WHEN (NEW.idProducto IS NULL OR NEW.idProducto = 0)
  BEGIN
    SELECT prod_sq.NEXTVAL INTO :NEW.idProducto FROM dual;
  END;
 -----------
  CREATE OR REPLACE TRIGGER ped_sq_tr
    BEFORE INSERT ON Pedidos FOR EACH ROW
  WHEN (NEW.idPedido IS NULL OR NEW.idPedido = 0)
  BEGIN
    SELECT ped_sq.NEXTVAL INTO :NEW.idPedido FROM dual;
  END;
 -------
  CREATE OR REPLACE TRIGGER det_sq_tr
    BEFORE INSERT ON DetallesPedido FOR EACH ROW
  WHEN (NEW.idDetalle IS NULL OR NEW.idDetalle = 0)
  BEGIN
    SELECT det_sq.NEXTVAL INTO :NEW.idDetalle FROM dual;
  END;
-----
  CREATE OR REPLACE TRIGGER numero_pedido_tr
    BEFORE INSERT ON Pedidos FOR EACH ROW
  WHEN (NEW.numero_pedido IS NULL OR NEW.numero_pedido = 0)
  BEGIN
    SELECT numero_pedido_sq.NEXTVAL INTO :NEW.numero_pedido FROM dual;
  END;
 -------
   CREATE OR REPLACE TRIGGER venta_tr
    BEFORE INSERT ON Venta FOR EACH ROW
  WHEN (NEW.idVenta IS NULL OR NEW.idVenta = 0)
  BEGIN
    SELECT ven_sq.NEXTVAL INTO :NEW.idVenta FROM dual;
  END;


CREATE TABLE Usuarios (
  idUsuario NUMBER(10)UNIQUE,
  nombre VARCHAR2(100),
  contraseña VARCHAR2(100),
  correo VARCHAR2(100),
  DNI VARCHAR2(20) PRIMARY KEY
  
);
SELECT * FROM venta 
-----
-- Tabla: Categoria
DROP TABLE CATEGORIA 

CREATE TABLE Categoria (
  idCategoria NUMBER(10) UNIQUE ,
  nombre_categoria VARCHAR2(100) PRIMARY KEY
);
SELECT * FROM Categoria  
-- Tabla: Productos
CREATE TABLE Producto (
  idProducto NUMBER(10) UNIQUE ,
  nombre_producto VARCHAR2(100) PRIMARY KEY,
  descripcion VARCHAR2(200),
  precio NUMBER(10,2),
  nombre_categoria VARCHAR2(100),
  FOREIGN KEY (nombre_categoria) REFERENCES CATEGORIA(nombre_categoria)
);
-- Tabla: Pedidos
CREATE TABLE Pedidos (
  idPedido NUMBER(10) UNIQUE,
  numero_pedido NUMBER(10) PRIMARY KEY,
  DNI VARCHAR(20),
  fecha DATE,
  total NUMBER(10,2),
  FOREIGN KEY (DNI) REFERENCES Usuarios(DNI)
);
SELECT * FROM PEDIDOS p 
SELECT * FROM DetallesPedido p 

--Tabla: DetallesPedido--
CREATE TABLE DetallesPedido (
  idDetalle NUMBER(10) PRIMARY KEY,
  numero_pedido NUMBER(10),
  nombre_prod VARCHAR2(100),
  cantidad NUMBER(10),
  subtotal NUMBER(10,2),
  FOREIGN KEY (nombre_prod) REFERENCES PRODUCTO(nombre_producto),
  FOREIGN KEY (numero_pedido) REFERENCES Pedidos(numero_pedido)
);
CREATE TABLE Venta (
  idVenta NUMBER(10) PRIMARY KEY,
  DNI VARCHAR2(100),
  nombre_producto VARCHAR2(100),
  Cantidades NUMBER(10),
  precio_uni NUMBER(10,2),
  precio_acumulado NUMBER(10,2),
  FOREIGN KEY (DNI) REFERENCES Usuarios(DNI),
  FOREIGN KEY (nombre_producto) REFERENCES Producto(nombre_producto)
  ALTER TABLE Venta ADD IDconjunto NUMBER(10);
SELECT * FROM  Venta;
 );
---
CREATE OR REPLACE PROCEDURE crearVenta(dni_ve Venta.DNI%TYPE, nombre_vent Venta.NOMBRE_PRODUCTO %TYPE, Cantidades Venta.CANTIDADES %TYPE, precio_ven Venta.PRECIO_UNI %TYPE,precio_tot venta.PRECIO_ACUMULADO %TYPE ,fecha_ven venta.FECHA  %TYPE)
IS
BEGIN
    INSERT INTO Venta(DNI, nombre_producto, Cantidades, precio_uni,precio_acumulado,FECHA)
    VALUES (dni_ve, nombre_vent, Cantidades, precio_ven,precio_tot,fecha_ven);
END;
------
INSERT INTO Venta (DNI, nombre_producto, Cantidades, precio_uni,precio_acumulado ) VALUES ('123', 'Paracetamol12', 1,1,1);
SELECT * FROM VENTA v 
-- Tabla: CarritoCompra
CREATE TABLE CarritoCompra (
  idCarrito NUMBER(10) PRIMARY KEY,
  DNI NUMBER(10),
  FOREIGN KEY (DNI) REFERENCES Usuarios(DNI)
);

CREATE TABLE ProductosCarrito (
  idCarrito NUMBER(10),
  nombre_prod NUMBER(10),
  cantidad NUMBER(10),
  PRIMARY KEY (idCarrito, idProducto),
  FOREIGN KEY (idCarrito) REFERENCES CarritoCompra(idCarrito),
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
);

--POBLANDO BASE DE DATOS--
INSERT INTO Usuarios (nombre, correo, contraseña, DNI ) VALUES ('John Doe', 'john.doe@example.com', 'password1','12345678');

INSERT INTO Usuarios (nombre, correo, contraseña) VALUES ('Jane Smith', 'jane.smith@example.com', 'password2');

INSERT INTO Usuarios (nombre, correo, contraseña) VALUES ('Luis Luque', 'luizln760@gmail.com', 'marmotafeliz');

INSERT INTO Usuarios (nombre, correo, contraseña) VALUES ('Roger Euclides', 'rogeris345@gmail.com', 'ciudadmapache');

INSERT INTO Usuarios (nombre, correo, contraseña) VALUES ('Son Goku', 'gokupro1234@gmail.com', 'LeganoATodos');
UPDATE Usuarios
SET DNI = 
  CASE idUsuario
    
    WHEN 41 THEN '123456789'
    -- Agrega más casos según la cantidad de filas que desees actualizar
  END
WHERE DNI IS NULL;
SELECT * FROM USUARIOS
SELECT * FROM Categoria
SELECT * FROM PRODUCTO p 
SELECT * FROM venta v
-- Insertar datos en la tabla Categoría
INSERT INTO Categoria (nombre_categoria) VALUES ('Antibioticos Especiales');
INSERT INTO Categoria (nombre_categoria) VALUES ('Productos de limpieza');
INSERT INTO Categoria (nombre_categoria) VALUES ('Fungicos');
INSERT INTO Categoria (nombre_categoria) VALUES ('Lociones');
INSERT INTO Categoria (nombre_categoria) VALUES ('Pastillas Generales');
SELECT *FROM Categoria  ORDER BY idCategoria ASC;
 SELECT *FROM PRODUCTO p 
-- Insertar datos en la tabla Productos
INSERT INTO Producto(nombre_producto, descripcion, precio, nombre_categoria) VALUES ('Azacitidina Avibactam ','Lo mas potente en antibiticos', 120,'Antibioticos Especiales');

INSERT INTO Producto (nombre, descripcion, precio, nombre_categoria) VALUES ('Rizos Obedientes ', 'Para que tu cabello rizado siempre se vea bien', 20, 2);

INSERT INTO Producto (nombre, descripcion, precio, nombre_categoria) VALUES ('Plumigil ', 'Para matar a los hongos', 15, 3);

INSERT INTO Producto (nombre, descripcion, precio, nombre_categoria) VALUES ('Nivea crema en bote ', 'Para cuidar tu piel ', 30, 4);

INSERT INTO Producto (nombre, descripcion, precio, nombre_categoria) VALUES ('Paracetamol', 'Pastilla para todo tipo de dolencias', 2, 5);

-- Insertar datos en la tabla Pedidos
ALTER TABLE Pedidos
DROP COLUMN total;
ALTER TABLE Pedidos ADD total INT;
SELECT * FROM PEDIDOS p 
SELECT * FROM DETALLESPEDIDO d  
INSERT INTO Pedidos (DNI, fecha, TOTAL ) VALUES ('12345678',TO_DATE('2023-05-24', 'YYYY-MM-DD'),0);

INSERT INTO Pedidos (idUsuario, fecha ) VALUES (2,TO_DATE('2022-05-24', 'YYYY-MM-DD'));

-- Insertar datos en la tabla DetallesPedido

INSERT INTO DetallesPedido (numero_pedido,NOMBRE_PROD ,CANTIDAD ,SUBTOTAL ) VALUES (61,'Azacitidina Avibactam ', 10,0);

INSERT INTO DetallesPedido (idPedido, idProducto, cantidad, subtotal) VALUES ( 2, 4, 2, 60);
SELECT * FROM DetallesPedido  

-- Insertar datos en la tabla CarritoCompra
INSERT INTO CarritoCompra (idCarrito, idUsuario) VALUES (1, 1);
SELECT * FROM CarritoCompra  
SELECT * FROM PRODUCTO ORDER BY idProducto ASC 
-- Insertar datos en la tabla ProductosCarrito
--INSERT INTO ProductosCarrito (idCarrito, idProducto, cantidad) VALUES (1, 5, 1);
--SELECT * FROM ProductosCarrito  

--CRUD PARA USUARIOS---

CREATE OR REPLACE PROCEDURE crearUsuarios(us_nom varchar2, us_correro varchar2, us_contraseña varchar2,us_dni varchar2)
IS
BEGIN
    
    INSERT INTO USUARIOS(nombre,correo,contraseña,DNI) VALUES (us_nom, us_correro , us_contraseña,us_dni);
    
END;
--Read--
CREATE OR REPLACE PROCEDURE listarUsuarios(usr_cursor OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM USUARIOS) LOOP 
		OPEN usr_cursor FOR
		SELECT * FROM USUARIOS  ORDER BY IDUSUARIO  asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Usuarios');	
END;

--UPDATE --
CREATE OR REPLACE PROCEDURE actualizarUsuario(us_dni IN USUARIOS.DNI%TYPE, us_nom IN USUARIOS.NOMBRE%TYPE, us_correo IN USUARIOS.CORREO%TYPE, us_contrasena IN USUARIOS.CONTRASEÑA%TYPE)
IS
BEGIN
    UPDATE USUARIOS
    SET
        nombre = us_nom,
        correo = us_correo,
        contraseña = us_contrasena
    WHERE DNI = us_dni;
END;

--DELET--
CREATE OR REPLACE PROCEDURE eliminarUsuario(us_dni IN USUARIOS.DNI%TYPE)
IS
BEGIN
    DELETE FROM USUARIOS WHERE DNI = us_dni;
END;
CALL eliminarUsuario('72797080')
SELECT * FROM USUARIOS u 
---CRUD CATEGORIA--
--CREATE--
CREATE OR REPLACE PROCEDURE crearCategoria(nom_cat varchar2)
IS
BEGIN
    
    INSERT INTO Categoria(nombre_categoria) VALUES (nom_cat);
    
END;
--Read--
CREATE OR REPLACE PROCEDURE listarCategoria(list_cursor OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM Categoria) LOOP 
		OPEN list_cursor FOR
		SELECT * FROM Categoria ORDER BY IDCATEGORIA  asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Departamentos');	
END;

--UPDATE --

CREATE OR REPLACE PROCEDURE actualizarCategoria(cat_nombre_actual IN Categoria.NOMBRE_CATEGORIA%TYPE, cat_nombre_nuevo IN Categoria.NOMBRE_CATEGORIA%TYPE)
IS
BEGIN
    
    UPDATE Categoria 
    SET  
    nombre_categoria = cat_nombre_nuevo
    WHERE NOMBRE_CATEGORIA  = cat_nombre_actual;
END;
--Delete--
CREATE OR REPLACE PROCEDURE eliminarCategoria(cat_nombre IN Categoria.NOMBRE_CATEGORIA%TYPE)
IS
BEGIN
    
    DELETE FROM CATEGORIA c WHERE NOMBRE_CATEGORIA  = cat_nombre;
    
END;

SELECT * FROM CATEGORIA c 

CREATE TABLE Producto (
  idProducto NUMBER(10) UNIQUE ,
  nombre_producto VARCHAR2(100) PRIMARY KEY,
  descripcion VARCHAR2(200),
  precio NUMBER(10,2),
  nombre_categoria VARCHAR2(100),
  FOREIGN KEY (nombre_categoria) REFERENCES CATEGORIA(nombre_categoria)
);
ALTER TABLE Producto
ADD stock NUMBER(10);
SELECT * FROM PRODUCTO p 
SELECT * FROM CATEGORIA ORDER BY idCategoria  
--CRUD PRODUCTO--
--CREATE--
CREATE OR REPLACE PROCEDURE crearProducto(nom_prod Producto.nombre_producto%TYPE, des_prod Producto.descripcion%TYPE, pre_prod Producto.precio%TYPE, nom_cat Producto.nombre_categoria%TYPE,stock_prod Producto.STOCK%TYPE)
IS
BEGIN
    INSERT INTO Producto(nombre_producto, descripcion, precio, nombre_categoria,STOCK)
    VALUES (nom_prod, des_prod, pre_prod, nom_cat,stock_prod);
END;

--READ--
CREATE OR REPLACE PROCEDURE listarProductos(list_prod OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM PRODUCTO ) LOOP 
		OPEN list_prod FOR
		SELECT * FROM PRODUCTO ORDER BY IDPRODUCTO asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Productos');	
END;
-------READVENTA---
CREATE OR REPLACE PROCEDURE listarVentas(list_venta OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM VENTA ) LOOP 
		OPEN list_venta FOR
		SELECT * FROM VENTA ORDER BY IDVENTA  asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Productos');	
END;

-----
--UPDATE--
CREATE OR REPLACE PROCEDURE actualizarProducto(prod_nombre_act IN Producto.nombre_producto%TYPE , prod_nombre_nuevo IN Producto.nombre_producto%TYPE, prod_des IN Producto.descripcion%TYPE, prod_precio IN Producto.precio%TYPE, prod_cat IN Producto.NOMBRE_CATEGORIA%TYPE, prod_stock IN Producto.STOCK%TYPE)
IS
BEGIN
    UPDATE Producto
    SET  
        nombre_producto = prod_nombre_nuevo,
        descripcion = prod_des,
        precio = prod_precio,
        NOMBRE_CATEGORIA  = prod_cat,
        stock = prod_stock
    WHERE nombre_producto = prod_nombre_act;
END;

call actualizarProducto('Azacitidina Avibactam ','Azacitidina Avibactamn', 'Un Antibiotico muy poderoso', 200, 'Productos para la piel',23);
SELECT * FROM PRODUCTO ORDER BY IDPRODUCTO ASC
SELECT * FROM CATEGORIA c 
--Delete--
CREATE OR REPLACE PROCEDURE eliminarProducto(nom_prod IN Producto.nombre_producto%TYPE)
IS
BEGIN
    
    DELETE FROM PRODUCTO p WHERE nombre_producto  = nom_prod;
    
END;
SELECT * FROM FERITO23.CATEGORiA 
SELECT * FROM PRODUCTO p 
SELECT * FROM USUARIOS u 
UPDATE Producto
SET stock = 50 -- Nueva cantidad de stock
WHERE idProducto = 1;

--Verificar DNI--
CREATE OR REPLACE PROCEDURE VerificarDNIExistente(p_dni IN VARCHAR2, p_existe OUT BOOLEAN) IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM usuarios
    WHERE dni = p_dni;

    IF v_count > 0 THEN
        p_existe := TRUE;
    ELSE
        p_existe := FALSE;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_existe := FALSE;
    WHEN OTHERS THEN
        -- Manejar la excepción si ocurre algún error durante la consulta
        RAISE;
END;
DECLARE
  v_existe BOOLEAN;
BEGIN
  VerificarDNIExistente('123', v_existe);
  IF v_existe THEN
    DBMS_OUTPUT.PUT_LINE('El DNI existe');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El DNI no existe');
  END IF;
END;

-------------------------------------- 	
CREATE OR REPLACE PROCEDURE crearPedido(
  DNI IN Pedidos.DNI%TYPE,
  fecha IN Pedidos.fecha%TYPE,
  total IN Pedidos.total%TYPE
)
IS
BEGIN
  INSERT INTO Pedidos( DNI, fecha, total)
  VALUES (DNI, fecha, total);
END;
-------
CREATE OR REPLACE PROCEDURE listarPedidos(list_ped OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM Pedidos) LOOP 
		OPEN list_ped FOR
		SELECT * FROM PEDIDOS ORDER BY IDPEDIDO  asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Productos');	
END;
-----------
CREATE OR REPLACE PROCEDURE crearDetallePedido(
  numero_pedido IN DetallesPedido.numero_pedido%TYPE,
  nombre_prod IN DetallesPedido.nombre_prod%TYPE,
  cantidad IN DetallesPedido.cantidad%TYPE,
  subtotal IN DetallesPedido.subtotal%TYPE
)
IS
BEGIN
  INSERT INTO DetallesPedido(numero_pedido, nombre_prod, cantidad, subtotal)
  VALUES (numero_pedido, nombre_prod, cantidad, subtotal);
END;
-----
CREATE OR REPLACE PROCEDURE listarDePedidos(list_deped OUT sys_refcursor)
IS
BEGIN
	
	FOR i IN (SELECT * FROM DETALLESPEDIDO) LOOP 
		OPEN list_deped FOR
		SELECT * FROM DETALLESPEDIDO ORDER BY IDDETALLE  asc ;
	END LOOP;
EXCEPTION	
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE ('Error Al listar Productos');	
END;

SELECT * FROM DETALLESPEDIDO d 
SELECT *FROM PEDIDOS p 
SELECT * FROM USUARIOS u
SELECT * FROM PRODUCTO p2 
SELECT * FROM venta 

CREATE OR REPLACE PROCEDURE ObtenerMaxIDConjunto(
    maxIDConjunto OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN maxIDConjunto FOR
        SELECT MAX(IDCONJUNTO) AS maxID FROM venta;
END;
CREATE TABLE Venta (
  idVenta NUMBER(10) PRIMARY KEY,
  DNI VARCHAR2(100),
  nombre_producto VARCHAR2(100),
  Cantidades NUMBER(10),
  precio_uni NUMBER(10,2),
  precio_acumulado NUMBER(10,2),
  FOREIGN KEY (DNI) REFERENCES Usuarios(DNI),
  FOREIGN KEY (nombre_producto) REFERENCES Producto(nombre_producto)
  ALTER TABLE Venta ADD IDconjunto NUMBER(10);
 );
 CREATE OR REPLACE PROCEDURE ActualizarMaxIDConjunto(p_nuevoID venta.IDCONJUNTO %TYPE) IS
BEGIN
  -- Actualizar el valor máximo de ID en la tabla Venta
  UPDATE Venta SET IDconjunto = p_nuevoID;

  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    -- Manejar errores aquí si es necesario
    -- ...
    ROLLBACK;
    RAISE;
END;
SELECT * FROM venta 