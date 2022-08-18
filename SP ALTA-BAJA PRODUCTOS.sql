---------------------------------------------------------
---------------------------------------------------------CREANDO BD PRACTICA
---------------------------------------------------------
use master
go
drop database if exists PRACTICA
go
CREATE DATABASE PRACTICA
go
---------------------------------------------------------USANDO BD PRACTICA
USE PRACTICA
go
---------------------------------------------------------

---------------------------------------------------------
---------------------------------------------------------CREANDO TABLA PRODUCTOS
---------------------------------------------------------
drop table if exists dbo.PRODUCTOS
go
CREATE TABLE PRODUCTOS
( 
IDPRODUCTO VARCHAR(20) NOT NULL,
IDCATEGORIA VARCHAR(20),
NOMBRE VARCHAR(50),
DESCRIPCION VARCHAR(50),
STOCK DECIMAL(18,2),
PRECIO_COMPRA DECIMAL(18,2),
PRECIO_VENTA DECIMAL(18,2),
FECHA_VENCIMIENTO DATE,
)
go
---------------------------------------------------------INSERTANDO REGISTROS TABLA PRODUCTOS

INSERT INTO PRODUCTOS(IDPRODUCTO,IDCATEGORIA,NOMBRE,DESCRIPCION,STOCK,PRECIO_COMPRA,PRECIO_VENTA,FECHA_VENCIMIENTO) VALUES
('34519','35741','Aceite de oliva', 'Aceite para chicharronerias',196, 14.20, 15.00,'2022-12-11'), 
('34520','35741','Aceite y manteca de coco', 'Aceite para picanterias',77, 6.10, 7.10,'2022-09-10'),
('34521','35741','Grasa animal: manteca de cerdo','manteca para postres',44, 8.40, 9.70,'2022-06-08'),
('34522','35742','Puré de espinaca zapallito y arroz','Pure para recreo de niños',19, 10.10, 11.00,'2022-07-09'),
('34523','35742','Puré de manzana','Pure para bebes',87, 12.50, 13.60,'2022-06-08'),
('34524','35742','Puré de pera','Pure para escolares',24, 11.10, 12.30,'2022-03-09'),
('34525','35743','Pepino dulce','Pepinos para Plaza Vea',45, 14.20, 15.30,'2022-04-10'),
('34526','35743','Pepinillo pecera','Pepino para Metro',24, 11.10, 12.30,'2022-03-09'),
('34527','35743','Cebollitas cocktail','Cebollitas encurtidas',14, 9.00, 10.30,'2022-04-10'),
('34528','35744','Azúcar blanca y morena','azucar para bodegas',94, 8.10, 9.30,'2022-04-07'),
('34529','35744','Miel y melazas','miel para restaurantes',264, 13.30, 14.30,'2022-08-08'),
('34530','35744','Fructosa y sacarina','sacarina en botella', 59, 15.80, 16.30,'2022-08-02'),
('34531','35745','Cerveza sin gluten','cerveza artesanal de maracuya',250, 18.10, 20.30,'2022-12-11'),
('34532','35745','Vino','Vino de mesa',241, 16.10, 18.40,'2022-12-07'),
('34533','35745','Ron, vodka y whisky','bebidas para discotecas',350, 25.10, 28.70,'2022-11-12')
go
---------------------------------------------------------LISTADO REGISTROS TABLA CATEGORIAS
SELECT * FROM PRODUCTOS
go




---------------------------------------------------------
-------------------------------------------------------Mostar los productos de acuerdo al nombre de su categoria
---------------------------------------------------------CREANDO SP SPPRODUCTOS_AUMENTAR_DISMINUIR
drop proc if exists dbo.SPPRODUCTOS_AUMENTAR_DISMINUIR
go
CREATE PROCEDURE SPPRODUCTOS_AUMENTAR_DISMINUIR
(
@IDPRODUCTO VARCHAR(50),
@OPERACION VARCHAR(10),
@STOCK DECIMAL(18,2)
)
AS
BEGIN
	DECLARE @IDPRODUCTO_EXISTE INT
	DECLARE @STOCK_ACTUAL INT

	SET @IDPRODUCTO_EXISTE = (SELECT COUNT(*) FROM PRODUCTOS WHERE IDPRODUCTO = @IDPRODUCTO)
	IF @IDPRODUCTO_EXISTE = 0
	BEGIN
		PRINT 'CÓDIGO DEL PRODUCTO NO EXISTE'
	END
	ELSE
	BEGIN
		IF @OPERACION = '+' OR @OPERACION = '-'
		BEGIN 
			IF  @OPERACION = '-'
			BEGIN
				SET @STOCK_ACTUAL = (SELECT SUM(STOCK) FROM PRODUCTOS WHERE IDPRODUCTO = @IDPRODUCTO)
				IF @STOCK_ACTUAL < @STOCK
				BEGIN
					PRINT 'NO EXISTE SUFICIENTE STOCK PARA LA OPERACIÓN'
				END
				ELSE
				BEGIN
					UPDATE PRODUCTOS SET STOCK = STOCK - @STOCK WHERE IDPRODUCTO = @IDPRODUCTO
				END
			END
			ELSE
			BEGIN
				UPDATE PRODUCTOS SET STOCK = STOCK + @STOCK WHERE IDPRODUCTO = @IDPRODUCTO
			END
		END
		ELSE
		BEGIN
			PRINT 'OPERACIÓN NO EXISTE: solo + o - antes de la cantidad'
		END
	END
END
go
---------------------------------------------------------PROBANDO SP SPPRODUCTOS_AUMENTAR_DISMINUIR
EXEC SPPRODUCTOS_AUMENTAR_DISMINUIR '34519','-', 3

EXEC SPPRODUCTOS_LISTAR

