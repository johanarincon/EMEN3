 CREATE DATABASE IF NOT EXISTS emen;
USE emen;

CREATE TABLE IF NOT EXISTS Roles (
  idRoles INT NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idRoles)
);

CREATE TABLE IF NOT EXISTS Cliente (
  idClientes INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(125) NOT NULL,
  Documento VARCHAR(45) NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  Contraseña VARBINARY(255) NOT NULL,
  Fechadenacimiento DATETIME NOT NULL,
  Roles_idRoles INT NOT NULL,
  PRIMARY KEY (idClientes),
  INDEX (Roles_idRoles ASC) VISIBLE,
  CONSTRAINT FOREIGN KEY (Roles_idRoles)
    REFERENCES Roles (idRoles)
);

CREATE TABLE IF NOT EXISTS Mesa (
  idMesa INT NOT NULL AUTO_INCREMENT,
  Numeropiso INT NOT NULL,
  NumeroMesa INT NOT NULL,
  CantidadPuestos INT NOT NULL,
  PRIMARY KEY (idMesa)
);

CREATE TABLE IF NOT EXISTS Menu (
  idMenu INT NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(80) NOT NULL,
  PRIMARY KEY (idMenu)
);

CREATE TABLE IF NOT EXISTS Orden (
  idOrden INT NOT NULL AUTO_INCREMENT,
  PrecioFinal FLOAT NOT NULL,
  Fecha DATETIME NOT NULL,
  PRIMARY KEY (idOrden)
);

CREATE TABLE IF NOT EXISTS Producto (
  idProducto INT NOT NULL AUTO_INCREMENT,
  Precio FLOAT NOT NULL,
  Disponibilidad TINYINT NOT NULL,
  Cantidad INT NOT NULL,
  Orden_idOrden INT NOT NULL,
  PRIMARY KEY (idProducto),
  INDEX (Orden_idOrden ASC) VISIBLE,
  CONSTRAINT FOREIGN KEY (Orden_idOrden)
    REFERENCES Orden (idOrden)
);

CREATE TABLE IF NOT EXISTS CodigoNis (
  idCodigoNIS INT NOT NULL AUTO_INCREMENT,
  Descripcion  VARCHAR(10) NOT NULL, 
  Mesa_idMesa INT NOT NULL,
  Menu_idMenu INT NOT NULL,
  Cliente_idClientes INT NOT NULL,
  Producto_idProducto INT NOT NULL,
  PRIMARY KEY (idCodigoNIS),
  INDEX (Mesa_idMesa ASC) VISIBLE,
  INDEX (Menu_idMenu ASC) VISIBLE,
  INDEX (Cliente_idClientes ASC) VISIBLE,
  INDEX (Producto_idProducto ASC) VISIBLE,
  CONSTRAINT FOREIGN KEY (Mesa_idMesa)
    REFERENCES Mesa (idMesa),
  CONSTRAINT FOREIGN KEY (Menu_idMenu)
    REFERENCES Menu (idMenu),
  CONSTRAINT FOREIGN KEY (Cliente_idClientes)
    REFERENCES Cliente (idClientes),
  CONSTRAINT FOREIGN KEY (Producto_idProducto)
    REFERENCES Producto (idProducto)
);

CREATE TABLE IF NOT EXISTS detalleDeOrden (
  idDetalleDeOrden INT NOT NULL AUTO_INCREMENT,
  Descripcion VARCHAR(700) NOT NULL,
  Hora TIME NOT NULL,
  Entregado TINYINT NOT NULL,
  Orden_idOrden INT NOT NULL,
  PRIMARY KEY (idDetalleDeOrden),
  INDEX (Orden_idOrden ASC) VISIBLE,
  CONSTRAINT FOREIGN KEY (Orden_idOrden)
    REFERENCES Orden (idOrden)
);

CREATE TABLE IF NOT EXISTS categoria (
  idcategoria INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  Producto_idProducto INT NOT NULL,
  PRIMARY KEY (idcategoria),
  INDEX fk_categoria_Producto1_idx (Producto_idProducto ASC) VISIBLE,
  CONSTRAINT fk_categoria_Producto1 FOREIGN KEY (Producto_idProducto)
    REFERENCES Producto (idProducto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS metodoDePago (
  idmetodoDePago INT NOT NULL,
  Metodo VARCHAR(45) NOT NULL,
  detalleDeOrden_idDetalleDeOrden INT NOT NULL,
  PRIMARY KEY (idmetodoDePago),
  INDEX fk_metodoDePago_detalleDeOrden1_idx (detalleDeOrden_idDetalleDeOrden ASC) VISIBLE,
  CONSTRAINT fk_metodoDePago_detalleDeOrden1 FOREIGN KEY (detalleDeOrden_idDetalleDeOrden)
    REFERENCES detalleDeOrden (idDetalleDeOrden)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Insertar datos en Roles
INSERT INTO Roles (Descripcion) VALUES
('Admin'),
('Gerente'),
('Bartender'),
('Cliente');

-- Insertar datos en Cliente
INSERT INTO Cliente (Nombre, Documento, Correo, Contraseña, Fechadenacimiento, Roles_idRoles) VALUES
('Carlos Pérez', '123456789', 'carlos@example.com', 'hashed_password1', '1990-05-10 00:00:00', 1),
('Ana Gómez', '987654321', 'ana@example.com', 'hashed_password2', '1985-03-15 00:00:00', 2),
('Luis Martínez', '456789123', 'luis@example.com', 'hashed_password3', '2000-01-20 00:00:00', 3),
('Marta Sánchez', '321654987', 'marta@example.com', 'hashed_password4', '1995-07-25 00:00:00', 4),
('Juan Torres', '159753456', 'juan@example.com', 'hashed_password5', '1988-11-30 00:00:00', 4),
('Sofía Ruiz', '258147369', 'sofia@example.com', 'hashed_password6', '1992-02-12 00:00:00', 4),
('Diego López', '369258147', 'diego@example.com', 'hashed_password7', '1993-09-05 00:00:00', 4),
('Valentina Díaz', '147852369', 'valentina@example.com', 'hashed_password8', '1991-04-20 00:00:00', 4),
('Mateo Castillo', '753159486', 'mateo@example.com', 'hashed_password9', '1994-06-15 00:00:00', 4),
('Laura Morales', '951753468', 'laura@example.com', 'hashed_password10', '1987-08-10 00:00:00', 4),
('Andrés Ramírez', '852963147', 'andres@example.com', 'hashed_password11', '1989-12-22 00:00:00', 4),
('Camila Ortega', '159753258', 'camila@example.com', 'hashed_password12', '1996-01-18 00:00:00', 4),
('Felipe Aguirre', '789456123', 'felipe@example.com', 'hashed_password13', '1990-03-30 00:00:00', 4),
('Isabella Silva', '654789321', 'isabella@example.com', 'hashed_password14', '1992-10-05 00:00:00', 4),
('Julián Castro', '321789654', 'julian@example.com', 'hashed_password15', '1984-11-15 00:00:00', 4);

-- Insertar datos en Mesa
INSERT INTO Mesa (Numeropiso, NumeroMesa, CantidadPuestos) VALUES
(1, 1, 6),
(1, 2, 6),
(2, 1, 6),
(2, 2, 6);

-- Insertar datos en Menu
INSERT INTO Menu (Descripcion) VALUES
('Común'),
('Evento');

-- Insertar datos en Orden
INSERT INTO Orden (PrecioFinal, Fecha) VALUES
(15000, '2024-01-15 10:00:00'),
(25000, '2024-01-16 12:30:00'),
(30000, '2024-01-17 14:15:00'),
(20000, '2024-01-18 16:45:00'),
(50000, '2024-01-19 18:30:00');

-- Insertar datos en Producto
INSERT INTO Producto (Precio, Disponibilidad, Cantidad, Orden_idOrden) VALUES
(5000, 1, 10, 1), -- Dulces
(6000, 1, 15, 1),
(7000, 1, 8, 2),
(8000, 1, 12, 2),
(9000, 1, 20, 3),
(10000, 1, 5, 3), -- Bebidas alcohólicas
(11000, 1, 3, 4),
(12000, 1, 4, 4),
(13000, 1, 6, 5),
(14000, 1, 8, 5),
(15000, 1, 10, 1), -- Vapers
(16000, 1, 9, 1),
(17000, 1, 7, 2),
(18000, 1, 11, 3),
(19000, 1, 5, 4),
(20000, 1, 3, 5);

-- Insertar datos en detalleDeOrden
INSERT INTO detalleDeOrden (Descripcion, Hora, Entregado, Orden_idOrden) VALUES
('Compra de dulces', '10:30:00', 1, 1),
('Compra de bebidas', '12:45:00', 1, 2),
('Compra de vapers', '14:30:00', 1, 3),
('Compra de dulces', '16:00:00', 0, 4),
('Compra de bebidas', '18:00:00', 1, 5);

-- Insertar datos en CodigoNis
INSERT INTO CodigoNis (Mesa_idMesa, Menu_idMenu, Cliente_idClientes, Producto_idProducto, Descripcion) VALUES
(1, 1, 1, 1, '1234'),
(1, 2, 2, 6, '5678'),
(2, 1, 3, 11, '9101'),
(2, 2, 4, 16, '1121'),
(1, 1, 5, 1, '3141');

-- Insertar datos en categoria
INSERT INTO categoria (idcategoria, nombre, Producto_idProducto) VALUES
(1, 'Dulces', 1),
(2, 'Dulces', 2),
(3, 'Dulces', 3),
(4, 'Dulces', 4),
(5, 'Dulces', 5),
(6, 'Bebidas alcohólicas', 6),
(7, 'Bebidas alcohólicas', 7),
(8, 'Bebidas alcohólicas', 8),
(9, 'Bebidas alcohólicas', 9),
(10, 'Bebidas alcohólicas', 10),
(11, 'Vapers', 11),
(12, 'Vapers', 12),
(13, 'Vapers', 13),
(14, 'Vapers', 14),
(15, 'Vapers', 15);


-- Insertar datos en metodoDePago
INSERT INTO metodoDePago (idmetodoDePago, Metodo, detalleDeOrden_idDetalleDeOrden) VALUES
(1, 'Efectivo', 1),
(2, 'Tarjeta', 2),
(3, 'Efectivo', 3),
(4, 'Tarjeta', 4),
(5, 'Efectivo', 5);


---------------------------------------------------------------------------------------------------
-- subconsultas
-- Esta consulta obtiene los métodos de pago que han sido utilizados más de una vez.
SELECT mp.Metodo
FROM metodoDePago mp  -- Seleccionamos la tabla de métodos de pago y le damos un alias 'mp'
WHERE mp.idmetodoDePago IN (  -- Filtramos para incluir solo los métodos que cumplen la condición
    SELECT mp2.idmetodoDePago  -- Subconsulta: seleccionamos el ID del método de pago desde la tabla 'metodoDePago' con el alias 'mp2'
    FROM detalleDeOrden d  -- Desde la tabla de detalles de órdenes con el alias 'd'
    JOIN metodoDePago mp2 ON d.Orden_idOrden = mp2.detalleDeOrden_idDetalleDeOrden  -- Relacionamos 'detalleDeOrden' con 'metodoDePago' usando el campo que conecta ambas tablas
    GROUP BY mp2.idmetodoDePago  -- Agrupamos los resultados por el ID del método de pago para contar cuántas veces se ha utilizado
    HAVING COUNT(d.idDetalleDeOrden) < 2  -- Filtramos los grupos para obtener solo aquellos métodos de pago que han sido utilizados menos de dos veces
);


-- Esta consulta obtiene los nombres de los clientes que han realizado órdenes cuyo precio final es mayor que el precio promedio de todas las órdenes.
SELECT DISTINCT c.Nombre  -- Selecciona los nombres únicos de los clientes
FROM Cliente c  -- Desde la tabla de clientes
JOIN detalleDeOrden d ON d.Orden_idOrden IN (  -- Une con detalles de orden
    SELECT o.idOrden  -- Selecciona los IDs de órdenes
    FROM Orden o  -- Desde la tabla de órdenes
    WHERE o.PrecioFinal > (SELECT AVG(PrecioFinal) FROM Orden)  -- Filtra por el precio promedio
);




-- Esta consulta obtiene todos los productos que no tienen ninguna venta registrada.
SELECT p.Precio
FROM Producto p
WHERE p.idProducto NOT IN (
    SELECT cn.Producto_idProducto
    FROM CodigoNis cn
);

---------------------------------------------------------------------------------------------------

-- COnsultas anidadas



-- Esta consulta obtiene los precios y cantidades de los productos que pertenecen a una categoría específica.
SELECT p.Precio, p.Cantidad
FROM Producto p  -- Selecciona la tabla Producto, asignándole el alias 'p'
WHERE p.idProducto IN (
    -- Subconsulta para obtener los IDs de productos de CodigoNis
    SELECT cn.Producto_idProducto
    FROM CodigoNis cn  -- Selecciona la tabla CodigoNis, asignándole el alias 'cn'
    JOIN detalleDeOrden d ON d.Orden_idOrden = cn.Mesa_idMesa  -- Une CodigoNis con detalleDeOrden usando Orden_idOrden y Mesa_idMesa
    WHERE EXISTS (
        -- Verifica si hay una entrada en la tabla categoria para el producto actual
        SELECT 1
        FROM categoria cat  -- Selecciona la tabla categoria, asignándole el alias 'cat'
        WHERE cat.Producto_idProducto = p.idProducto  -- Compara el id del producto en categoria con el id del producto actual
        AND cat.nombre = 'Dulces'  -- Filtra para que solo incluya productos de la categoría 'Dulces'
    )
);


-- Esta consulta obtiene los nombres de los clientes que han realizado órdenes cuyo precio final es mayor que el precio promedio de todas las órdenes.
SELECT DISTINCT c.Nombre
FROM Cliente c
JOIN detalleDeOrden d ON d.Orden_idOrden IN (
    SELECT o.idOrden
    FROM Orden o
    WHERE o.PrecioFinal > (SELECT AVG(PrecioFinal) FROM Orden)  -- Precio promedio de todas las órdenes
);





---------------------------------------------------------------------------------------------------
-- inner joins

-- Esta consulta obtiene los nombres de los clientes y la descripción de sus roles.
SELECT c.Nombre, r.Descripcion AS Rol
FROM Cliente c
INNER JOIN Roles r ON c.Roles_idRoles = r.idRoles;



 -- Esta consulta obtiene la descripción de los productos y los detalles de la orden a la que pertenecen.
SELECT d.Descripcion AS Detalle, p.Precio
FROM detalleDeOrden d
INNER JOIN Producto p ON d.Orden_idOrden = p.Orden_idOrden;


-- Esta consulta obtiene la descripción del menú y el número de la mesa.
SELECT m.NumeroMesa, m.Numeropiso, me.Descripcion AS Menu
FROM Mesa m
INNER JOIN CodigoNis cn ON m.idMesa = cn.Mesa_idMesa
INNER JOIN Menu me ON cn.Menu_idMenu = me.idMenu;



-- Esta consulta obtiene el método de pago y la descripción del detalle de la orden.
SELECT mp.Metodo, d.Descripcion AS Detalle
FROM metodoDePago mp
INNER JOIN detalleDeOrden d ON mp.detalleDeOrden_idDetalleDeOrden = d.idDetalleDeOrden;


---------------------------------------------------------------------------------------------------

-- left join 

-- Esta consulta obtiene todos los productos y sus respectivas categorías.
-- Si un producto no tiene categoría asignada, se mostrará NULL en la columna de categoría.
SELECT p.Precio, 
       c.nombre AS Categoria
FROM Producto p
LEFT JOIN categoria c ON p.Precio < 10000; -- Relacionando por el precio del producto



-- Esta consulta obtiene todos los métodos de pago y los detalles asociados a ellos.
-- Si un método de pago no tiene detalles, se mostrará NULL en la columna de detalle.
SELECT mp.Metodo, 
       d.Descripcion AS Detalle
FROM metodoDePago mp
LEFT JOIN detalleDeOrden d ON mp.Metodo = 'Efectivo'; -- Relacionando por el método de pago



-- Esta consulta obtiene todos los métodos de pago y las órdenes asociadas.
-- Si un método de pago no tiene órdenes asociadas, se mostrará NULL en la columna de orden.
SELECT mp.Metodo, 
       o.Fecha AS FechaOrden, 
       o.PrecioFinal
FROM metodoDePago mp
LEFT JOIN detalleDeOrden d ON mp.detalleDeOrden_idDetalleDeOrden = d.idDetalleDeOrden -- Relacionando por el detalle de la orden
LEFT JOIN Orden o ON d.Orden_idOrden = o.idOrden; -- Relacionando por la orden


---------------------------------------------------------------------------------------------------

-- RIGTH join

-- Esta consulta obtiene todas las órdenes y sus detalles.
-- Si una orden no tiene detalles asociados, se mostrará NULL en la columna de detalle.
SELECT o.idOrden, 
       o.Fecha, 
       d.Descripcion AS Detalle
FROM detalleDeOrden d
RIGHT JOIN Orden o ON d.Orden_idOrden = o.idOrden; -- Relacionando detalles con órdenes


-- Esta consulta obtiene todos los productos y sus categorías.
-- Si un producto no tiene categoría asignada, se mostrará NULL en la columna de categoría.
SELECT p.idProducto, 
       p.Precio, 
       c.nombre AS Categoria
FROM categoria c
RIGHT JOIN Producto p ON c.Producto_idProducto = p.idProducto; -- Relacionando productos con categorías


-- Esta consulta obtiene todas las mesas y los códigos NIS asociados.
-- Si una mesa no tiene código NIS, se mostrará NULL en la columna de código NIS.
SELECT m.idMesa, 
       m.NumeroMesa, 
       cn.idCodigoNIS
FROM CodigoNis cn
RIGHT JOIN Mesa m ON cn.Mesa_idMesa = m.idMesa; -- Relacionando códigos NIS con mesas


---------------------------------------------------------------------------------------------------
